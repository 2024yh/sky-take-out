package com.sky.mapper;

import com.sky.entity.SetmealDish;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SetmealDishMapper {

    /**
     * 根据菜品id查询对应的套餐id
     * @param dishIds
     * @return
     */
    List<Long> getSetmealIdsByDishIds(List<Long> dishIds);

    /**
     * 维护套餐-菜品信息
     * @param setmealDishes
     */
    void insert(List<SetmealDish> setmealDishes);

    /**
     * 根据setmealId查询套餐
     * @param id
     */
    List<SetmealDish> getBySetmealId(Long id);

    /**
     * 根据setmealId删除
     * @param setmealId
     */
    void deleteBySetmealId(Long setmealId);
}
