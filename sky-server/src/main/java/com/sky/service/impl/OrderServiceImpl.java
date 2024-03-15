package com.sky.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.constant.MessageConstant;
import com.sky.context.BaseContext;
import com.sky.dto.*;
import com.sky.entity.*;
import com.sky.exception.AddressBookBusinessException;
import com.sky.exception.OrderBusinessException;
import com.sky.exception.ShoppingCartBusinessException;
import com.sky.mapper.*;
import com.sky.result.PageResult;
import com.sky.service.OrderService;
import com.sky.utils.WeChatPayUtil;
import com.sky.vo.*;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.prefs.BackingStoreException;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Autowired
    private ShoppingCartMapper shoppingCartMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private AddressBookMapper addressBookMapper;
    @Autowired
    private WeChatPayUtil weChatPayUtil;

    /**
     * 用户下单
     * @param ordersSubmitDTO
     * @return
     */
    @Transactional
    public OrderSubmitVO submitOrder(OrdersSubmitDTO ordersSubmitDTO) {

        //处理各种业务异常(地址簿为空；购物车数据为空)
       AddressBook addressBook = addressBookMapper.getById(ordersSubmitDTO.getAddressBookId());
        if (addressBook == null){
            //抛出业务异常
            throw new AddressBookBusinessException(MessageConstant.ADDRESS_BOOK_IS_NULL);
        }

       //查询当前用户购物车数据
        Long userId = BaseContext.getCurrentId();
        List<ShoppingCart> list = shoppingCartMapper.query(userId);
        if (list ==null || list.size()==0){
            //抛出业务异常
            throw new ShoppingCartBusinessException(MessageConstant.SHOPPING_CART_IS_NULL);
        }

        //拼接地址
       String address = addressBook.getProvinceName() + addressBook.getCityName()+addressBook.getDistrictName()+addressBook.getDetail();


        //向订单表插入一条数据
        Orders orders = new Orders();
        BeanUtils.copyProperties(ordersSubmitDTO,orders);
        orders.setAddress(address);
        orders.setOrderTime(LocalDateTime.now());
        orders.setPayStatus(Orders.UN_PAID);
        orders.setStatus(Orders.PENDING_PAYMENT);
        orders.setNumber(String.valueOf(System.currentTimeMillis()));
        orders.setPhone(addressBook.getPhone());
        orders.setConsignee(addressBook.getConsignee());
        orders.setUserId(userId);
        orderMapper.insert(orders);


        List<OrderDetail> orderDetails = new ArrayList<>();
        //向订单明细表插入n条数据
        for (ShoppingCart shoppingCart : list) {
            OrderDetail orderDetail = new OrderDetail(); //订单明细
            BeanUtils.copyProperties(shoppingCart,orderDetail);
            orderDetail.setOrderId(orders.getId()); //设置当前订单明细关联的订单id
            orderDetails.add(orderDetail);
        }

        orderDetailMapper.insertBatch(orderDetails);


        //下单成功,清空当前用户的购物车数据
        shoppingCartMapper.delete(userId);

        //封装VO返回结果
       OrderSubmitVO orderSubmitVO = OrderSubmitVO
                .builder()
                .id(orders.getId())
                .orderTime(orders.getOrderTime())
                .orderNumber(orders.getNumber())
                .orderAmount(orders.getAmount())
                .build();

        return orderSubmitVO;

    }

    /**
     * 订单支付
     *
     * @param ordersPaymentDTO
     * @return
     */
    public OrderPaymentVO payment(OrdersPaymentDTO ordersPaymentDTO) throws Exception {
        // 当前登录用户id
       // Long userId = BaseContext.getCurrentId();
       // User user = userMapper.getById(userId);

        //调用微信支付接口，生成预支付交易单
//        JSONObject jsonObject = weChatPayUtil.pay(
//                ordersPaymentDTO.getOrderNumber(), //商户订单号
//                new BigDecimal(0.01), //支付金额，单位 元
//                "苍穹外卖订单", //商品描述
//                user.getOpenid() //微信用户的openid
//        );

//        JSONObject jsonObject = new JSONObject();
//
//        if (jsonObject.getString("code") != null && jsonObject.getString("code").equals("ORDERPAID")) {
//            throw new OrderBusinessException("该订单已支付");
//        }
//
//        OrderPaymentVO vo = jsonObject.toJavaObject(OrderPaymentVO.class);
//        vo.setPackageStr(jsonObject.getString("package"));
//
//        paySuccess(ordersPaymentDTO.getOrderNumber());

        //模拟支付
        OrderPaymentVO vo = new OrderPaymentVO();
        vo.setNonceStr("666");
        vo.setPaySign("hhh");
        vo.setPackageStr("prepay_id=wx");
        vo.setSignType("RSA");
        vo.setTimeStamp("1670380960");

        paySuccess(ordersPaymentDTO.getOrderNumber());

        return vo;
    }

    /**
     * 支付成功，修改订单状态
     *
     * @param outTradeNo
     */
    public void paySuccess(String outTradeNo) {

        // 根据订单号查询订单
        Orders ordersDB = orderMapper.getByNumber(outTradeNo);

        // 根据订单id更新订单的状态、支付方式、支付状态、结账时间
        Orders orders = Orders.builder()
                .id(ordersDB.getId())
                .status(Orders.TO_BE_CONFIRMED)
                .payStatus(Orders.PAID)
                .checkoutTime(LocalDateTime.now())
                .build();

        orderMapper.update(orders);
    }

    /**
     * 历史订单查询
     * @param ordersPageQueryDTO
     * @return
     */
    public PageResult queryHistoryOrders(OrdersPageQueryDTO ordersPageQueryDTO) {
        //设置当前用户id
        ordersPageQueryDTO.setUserId(BaseContext.getCurrentId());
        //设置分页
        PageHelper.startPage(ordersPageQueryDTO.getPage(),ordersPageQueryDTO.getPageSize());
        Page<Orders> page =orderMapper.pageQuery(ordersPageQueryDTO);

        List<OrderVO> list = new ArrayList<>();

        //System.out.println(page);

        if (page !=null && page.getTotal()>0){
            for (Orders orders : page) {
                Long orderId = orders.getId();

                List<OrderDetail> orderDetails = orderDetailMapper.getByOrderId(orderId);

                OrderVO orderVO = new OrderVO();

                BeanUtils.copyProperties(orders,orderVO);

                orderVO.setOrderDetailList(orderDetails);

                list.add(orderVO);

            }

        }

       return new PageResult(page.getTotal(),list);

    }

    /**
     * 查询订单详情
     * @param id
     * @return
     */
    public OrderVO queryOrderDetail(Long id) {
        //获取订单数据
        Orders orderDB = orderMapper.getByOrderId(id);

        OrderVO orderVO = new OrderVO();
        BeanUtils.copyProperties(orderDB,orderVO);

        List<OrderDetail> orderDetails = orderDetailMapper.getByOrderId(orderDB.getId());

        orderVO.setOrderDetailList(orderDetails);

        return orderVO;
    }

    /**
     * 取消订单
     * @param id
     */
    public void cancel(Long id) {
        //判断订单是否存在
        Orders orderDB = orderMapper.getByOrderId(id);

        if (orderDB == null){
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }

        //判断是否处于未付款或待接单状态下
        if (orderDB.getStatus() >2){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        Orders orders = new Orders();
        orders.setId(orderDB.getId());

        //判断是否已付款
        if (orderDB.getStatus().equals(Orders.TO_BE_CONFIRMED)){
            //退款后取消
            System.out.println("模拟退款");
            //支付状态设置为退款
            orders.setPayStatus(Orders.REFUND);
            orderMapper.update(orders);
        }

        orders.setStatus(Orders.CANCELLED);
        orders.setCancelReason("用户取消");
        orders.setCancelTime(LocalDateTime.now());
        orderMapper.update(orders);
    }

    /**
     * 再来一单
     * @param id
     */
    public void repetition(Long id) {
        //查询当前用户id
        Long userId = BaseContext.getCurrentId();

        //根据订单id查询订单详情对象集合
        List<OrderDetail> orderDetails = orderDetailMapper.getByOrderId(id);

        // 判断是否为空
        if (CollectionUtils.isNotEmpty(orderDetails)) {
            // 进行拆解封装
            List<ShoppingCart> shoppingCarts = orderDetails.stream().map(orderDetail -> {
                ShoppingCart shoppingCart = new ShoppingCart();

                // 将原订单详情里面的菜品信息重新复制到购物车对象中
                BeanUtils.copyProperties(orderDetail,shoppingCart,"id");
                shoppingCart.setUserId(userId);
                shoppingCart.setCreateTime(LocalDateTime.now());

                return shoppingCart;
            }).collect(Collectors.toList());

            for (ShoppingCart shoppingCart : shoppingCarts) {
                shoppingCartMapper.insert(shoppingCart);
            }
        }


    }

    /**
     * 订单搜索
     * @param ordersPageQueryDTO
     * @return
     */
    public PageResult conditionSearch(OrdersPageQueryDTO ordersPageQueryDTO) {

        PageHelper.startPage(ordersPageQueryDTO.getPage(),ordersPageQueryDTO.getPageSize());

        Page<Orders> page = orderMapper.pageQuery(ordersPageQueryDTO);

       List<OrderVO> list = new ArrayList<>();

        if (page !=null && page.getTotal()>0){

            for (Orders orders : page) {
                Long orderId = orders.getId();

                List<OrderDetail> orderDetail = orderDetailMapper.getByOrderId(orderId);

                OrderVO orderVO = new OrderVO();
                BeanUtils.copyProperties(orders,orderVO);

                orderVO.setOrderDetailList(orderDetail);

                list.add(orderVO);

            }

        }

        return new PageResult(page.getTotal(),list);

    }

    /**
     * 各个状态的订单数量统计
     * @return
     */
    public OrderStatisticsVO statistics() {
       Integer toBeConfirmed = orderMapper.countStatus(Orders.TO_BE_CONFIRMED);
       Integer confirmed = orderMapper.countStatus(Orders.CONFIRMED);
       Integer deliveryInProgress = orderMapper.countStatus(Orders.DELIVERY_IN_PROGRESS);

       OrderStatisticsVO orderStatisticsVO = new OrderStatisticsVO();
       orderStatisticsVO.setToBeConfirmed(toBeConfirmed);
       orderStatisticsVO.setConfirmed(confirmed);
       orderStatisticsVO.setDeliveryInProgress(deliveryInProgress);

        return orderStatisticsVO;
    }

    /**
     * 接单
     * @param ordersConfirmDTO
     */
    public void confirm(OrdersConfirmDTO ordersConfirmDTO) {
        ordersConfirmDTO.setStatus(Orders.CONFIRMED);
        Orders orders = new Orders();
        BeanUtils.copyProperties(ordersConfirmDTO,orders);
        orderMapper.update(orders);
    }

    /**
     * 拒单
     * @param ordersRejectionDTO
     */
    public void rejection(OrdersRejectionDTO ordersRejectionDTO) {
        Orders orderDB = orderMapper.getByOrderId(ordersRejectionDTO.getId());

        //判断订单是否存在
        if (orderDB == null){
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }

        Orders orders = new Orders();
        orders.setId(orderDB.getId());

        //判断是否处于待接单状态
        if (orderDB.getStatus() != 2){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        //判断是否已付款
        if (orderDB.getStatus().equals(Orders.TO_BE_CONFIRMED)){
            //退款后取消
            System.out.println("模拟退款");
            //支付状态设置为退款
            orders.setPayStatus(Orders.REFUND);
            orderMapper.update(orders);
        }

        orders.setStatus(Orders.CANCELLED);
        orders.setCancelReason(ordersRejectionDTO.getRejectionReason());
        orders.setCancelTime(LocalDateTime.now());
        orderMapper.update(orders);

    }

    /**
     * 派送订单
     * @param id
     */
    public void delivery(Long id) {
      Orders orderDB = orderMapper.getByOrderId(id);

       //校验订单是否存在，并且状态为3
      if (orderDB == null || !orderDB.getStatus().equals(Orders.CONFIRMED)){
          throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
      }

      Orders orders = new Orders();
      orders.setId(orderDB.getId());
      orders.setStatus(Orders.DELIVERY_IN_PROGRESS);

      orderMapper.update(orders);


    }

    /**
     * 完成订单
     * @param id
     */
    public void complete(Long id) {
        Orders orderDB = orderMapper.getByOrderId(id);

        //判断订单是否处于待派送状态
        if (orderDB ==null || !orderDB.getStatus().equals(Orders.DELIVERY_IN_PROGRESS)){
            throw new OrderBusinessException(MessageConstant.ORDER_STATUS_ERROR);
        }

        Orders orders = new Orders();
        orders.setId(orderDB.getId());
        orders.setStatus(Orders.COMPLETED);

        orderMapper.update(orders);

    }

    /**
     * 取消订单
     * @param ordersCancelDTO
     */
    public void cancelByAdmin(OrdersCancelDTO ordersCancelDTO) {
        Orders orderDB = orderMapper.getByOrderId(ordersCancelDTO.getId());
        if (orderDB == null){
            throw new OrderBusinessException(MessageConstant.ORDER_NOT_FOUND);
        }
        Orders orders = new Orders();
        orders.setId(orderDB.getId());

        if (orderDB.getPayStatus()==1){
            //给用户退款
            System.out.println("模拟退款");
            orders.setPayStatus(Orders.REFUND);
            orderMapper.update(orders);
        }

        orders.setStatus(Orders.CANCELLED);
        orders.setCancelReason(ordersCancelDTO.getCancelReason());
        orders.setCancelTime(LocalDateTime.now());
        orderMapper.update(orders);
    }


}
