package com.sky.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.annotation.AutoFill;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.entity.Setmeal;
import com.sky.entity.SetmealDish;
import com.sky.enumeration.OperationType;
import com.sky.mapper.SetmealDishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.result.PageResult;
import com.sky.service.SetmealService;
import com.sky.vo.SetmealVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SetmealServiceImpl implements SetmealService {

    @Autowired
    private SetmealMapper setmealMapper;

    @Autowired
    private SetmealDishMapper setmealDishMapper;

    /**
     * 分页查询套餐
     * @param setmealPageQueryDTO
     * @return
     */
    public PageResult pageQuery(SetmealPageQueryDTO setmealPageQueryDTO) {
        //开启分页
        PageHelper.startPage(setmealPageQueryDTO.getPage(),setmealPageQueryDTO.getPageSize());
        Page<SetmealVO> page = setmealMapper.pageQuery(setmealPageQueryDTO);
        return new PageResult(page.getTotal(),page.getResult());

    }

    /**
     * 根据setmealId查询套餐
     * @param id
     * @return
     */
    @Transactional
    public SetmealVO getById(Long id) {
        Setmeal setmeal = setmealMapper.getById(id);
        SetmealVO setmealVO = new SetmealVO();
        BeanUtils.copyProperties(setmeal,setmealVO);

       List<SetmealDish> setmealDishes = setmealDishMapper.getBySetmealId(id);

       setmealVO.setSetmealDishes(setmealDishes);

        return setmealVO;

    }

    /**
     * 新增套餐
     * @param setMealDTO
     */
    @Transactional
    public void save(SetmealDTO setMealDTO) {
        Setmeal setmeal = new Setmeal();
        BeanUtils.copyProperties(setMealDTO,setmeal);
        setmealMapper.insert(setmeal);

        Long setmealId = setmeal.getId();
        System.out.println(setmealId);

        List<SetmealDish> setmealDishes = setMealDTO.getSetmealDishes();
        setmealDishes.forEach(setmealDish ->{
            setmealDish.setSetmealId(setmealId);
        });

        System.out.println(setmealDishes);

        setmealDishMapper.insert(setmealDishes);

    }

    /**
     * 修改套餐
     * @param setmealVO
     */
    @Transactional
    public void update(SetmealVO setmealVO) {
        //修改套餐
        Setmeal setmeal = new Setmeal();
        BeanUtils.copyProperties(setmealVO,setmeal);
        setmealMapper.update(setmeal);

        //维护套餐-菜品表
        List<SetmealDish> setmealDishes = setmealVO.getSetmealDishes();
        //删除套餐对应的菜品信息
        setmealDishMapper.deleteBySetmealId(setmealVO.getId());
        //插入修改后套餐的菜品数据
        for (SetmealDish setmealDish : setmealDishes) {
            setmealDish.setSetmealId(setmealVO.getId());
        }
        System.out.println(setmealDishes);
        setmealDishMapper.insert(setmealDishes);

    }

    /**
     * 启售禁售套餐
     * @param status
     * @param id
     */
    public void startOrStop(Integer status, Long id) {
        Setmeal setmeal = new Setmeal();
        setmeal.setStatus(status);
        setmeal.setId(id);
        setmealMapper.update(setmeal);
    }

    /**
     * 批量删除套餐
     * @param ids
     */
    @Transactional
    public void deleteByIds(Long[] ids) {
        setmealMapper.deleteByIds(ids);

        //遍历删除菜品-套餐表关联的菜品信息
        for (Long id : ids) {
            setmealDishMapper.deleteBySetmealId(id);
        }

    }
}
