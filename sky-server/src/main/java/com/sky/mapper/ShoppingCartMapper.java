package com.sky.mapper;

import com.sky.dto.ShoppingCartDTO;
import com.sky.entity.ShoppingCart;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.DeleteMapping;

import java.util.List;

@Mapper
public interface ShoppingCartMapper {

    /**
     * 动态条件查询
     * @param shoppingCart
     * @return
     */
    List<ShoppingCart> list(ShoppingCart shoppingCart);

    /**
     * 根据id修改商品数量
     * @param shoppingCart
     */
    @Update("update shopping_cart set number = #{number} where id = #{id}")
    void updateNumberById(ShoppingCart shoppingCart);

    /**
     * 插入购物车数据
     * @param shoppingCart
     */
    void insert(ShoppingCart shoppingCart);

    /**
     * 查看购物车数据
     * @param userId
     * @return
     */
    @Select("select * from shopping_cart where user_id = #{userId}")
    List<ShoppingCart> query(Long userId);

    /**
     * 删除购物车中一个商品
     * @param shoppingCart
     */
    void deleteById(ShoppingCart shoppingCart);

    /**
     * 清空购物车
     */
    @Delete("delete from shopping_cart where user_id = #{userId}")
    void delete(Long userId);
}
