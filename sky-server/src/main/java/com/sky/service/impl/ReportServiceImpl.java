package com.sky.service.impl;

import com.sky.dto.GoodsSalesDTO;
import com.sky.entity.Orders;
import com.sky.mapper.OrderMapper;
import com.sky.mapper.UserMapper;
import com.sky.service.ReportService;
import com.sky.vo.OrderReportVO;
import com.sky.vo.SalesTop10ReportVO;
import com.sky.vo.TurnoverReportVO;
import com.sky.vo.UserReportVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 统计指定时间区间内的营业额数据
     * @param begin
     * @param end
     * @return
     */
    public TurnoverReportVO getTurnoverStatistics(LocalDate begin, LocalDate end) {

        //当前集合用于存放从begin到end范围内的每天的日期
        List<LocalDate> dateList = new ArrayList<>();
        dateList.add(begin);

        while(!begin.equals(end)){
            //日期计算，计算指定日期的后一天对应的日期
            begin = begin.plusDays(1);
            dateList.add(begin);
        }

        //存放每天的营业额
        List<Double> turnoverList = new ArrayList<>();

        for (LocalDate date : dateList) {
            //查询date日期对应的营业额数据，营业额是指：状态"已完成"的订单金额合计
           LocalDateTime beginTime =  LocalDateTime.of(date, LocalTime.MIN);
           LocalDateTime endTime = LocalDateTime.of(date,LocalTime.MAX);

            Map map = new HashMap();
            map.put("begin",beginTime);
            map.put("end",endTime);
            map.put("status", Orders.COMPLETED);

          Double turnover = orderMapper.sumByMap(map);
          turnover = turnover == null? 0.0 : turnover;
          turnoverList.add(turnover);

            //select sum(amount) from orders where order_time > ? and order_time < ? and status =5
        }



        return TurnoverReportVO
                .builder()
                .dateList(StringUtils.join(dateList,","))
                .turnoverList(StringUtils.join(turnoverList,","))
                .build();
    }

    /**
     * 统计指定时间区间内的用户数据
     * @param begin
     * @param end
     * @return
     */
    public UserReportVO getUserStatistics(LocalDate begin, LocalDate end) {

        //当前集合用于存放从begin到end范围内的每天的日期
        List<LocalDate> dateList = new ArrayList<>();
        dateList.add(begin);

        while(!begin.equals(end)){
            //日期计算，计算指定日期的后一天对应的日期
            begin = begin.plusDays(1);
            dateList.add(begin);
        }


        //存放每天新增用户数量
        List<Integer> newUserList = new ArrayList<>();
        //粗放每天用户总数量
        List<Integer> totalUserList = new ArrayList<>();

        for (LocalDate date : dateList) {
            LocalDateTime beginTime = LocalDateTime.of(date,LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(date,LocalTime.MAX);

            Map map = new HashMap();
            map.put("end",endTime);

            //总用户数量
            Integer totalUser = userMapper.countByMap(map);

            map.put("begin",beginTime);

            //新增用户数量
            Integer newUser = userMapper.countByMap(map);

            totalUserList.add(totalUser);
            newUserList.add(newUser);


        }

        return UserReportVO
                .builder()
                .dateList(StringUtils.join(dateList,","))
                .newUserList(StringUtils.join(newUserList,","))
                .totalUserList(StringUtils.join(totalUserList,","))
                .build();
    }

    /**
     * 统计指定时间区间内的订单数据
     * @param begin
     * @param end
     * @return
     */
    public OrderReportVO getOrderStatistics(LocalDate begin, LocalDate end) {
        //当前集合用于存放从begin到end范围内的每天的日期
        List<LocalDate> dateList = new ArrayList<>();
        dateList.add(begin);

        while(!begin.equals(end)){
            //日期计算，计算指定日期的后一天对应的日期
            begin = begin.plusDays(1);
            dateList.add(begin);
        }

        //存放每天订单总数
        List<Integer> orderCountList = new ArrayList<>();
        //粗放每天的有效订单数
        List<Integer> validOrderCountList = new ArrayList<>();


        //遍历dateList集合,查询每天的有效订单数和订单总数
        for (LocalDate date : dateList) {
            LocalDateTime beginTime = LocalDateTime.of(date,LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(date,LocalTime.MAX);

            Map map = new HashMap();
            map.put("begin",beginTime);
            map.put("end",endTime);

            //查询每天的订单总数
            Integer orderCount = orderMapper.countByMap(map);
            orderCountList.add(orderCount);
            map.put("status",Orders.COMPLETED);
            //查询每天的有效订单数
            Integer validOrderCount = orderMapper.countByMap(map);
            validOrderCountList.add(validOrderCount);

        }

        //计算时间区间内的订单总数量
       Integer totalOrderCount =  orderCountList.stream().reduce(Integer::sum).get();
        //计算时间区间内的有效订单数量
        Integer validOrderCount =  validOrderCountList.stream().reduce(Integer::sum).get();


        Double orderCompletionRate = 0.0;
                if (totalOrderCount !=0) {
                    //计算订单完成率
                    orderCompletionRate = validOrderCount.doubleValue() / totalOrderCount;
                }

        return OrderReportVO
                .builder()
                .dateList(StringUtils.join(dateList,","))
                .orderCountList(StringUtils.join(orderCountList,","))
                .validOrderCountList(StringUtils.join(validOrderCountList,","))
                .totalOrderCount(totalOrderCount)
                .validOrderCount(validOrderCount)
                .orderCompletionRate(orderCompletionRate)
                .build();

    }


    /**
     * 统计指定时间区间内的销量排名前10
     * @param begin
     * @param end
     * @return
     */
    public SalesTop10ReportVO getSalesTop10(LocalDate begin, LocalDate end) {
        LocalDateTime beginTime = LocalDateTime.of(begin,LocalTime.MIN);
        LocalDateTime endTime = LocalDateTime.of(end,LocalTime.MAX);

        List<GoodsSalesDTO> salesTop10 = orderMapper.getSalesTop10(beginTime,endTime);

     List<String> names = salesTop10.stream().map(GoodsSalesDTO::getName).collect(Collectors.toList());
     String nameList = StringUtils.join(names,",");
    List<Integer> numbers = salesTop10.stream().map(GoodsSalesDTO::getNumber).collect(Collectors.toList());
    String numberList = StringUtils.join(numbers,",");

    return SalesTop10ReportVO
            .builder()
            .nameList(nameList)
            .numberList(numberList)
            .build();
    }
}
