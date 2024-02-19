package com.sky.service;


import com.sky.dto.CategoryDTO;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.result.PageResult;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

public interface CategoryService {
    /**
     * 新增菜品分类
     * @param categoryDTO
     */
    void save(CategoryDTO categoryDTO);

    /**
     * 分类查询菜品分类
     * @param categoryPageQueryDTO
     * @return
     */
    PageResult pageQuery(CategoryPageQueryDTO categoryPageQueryDTO);

    /**
     * 启用禁用菜品分类
     * @param status
     * @param id
     */
    void startOrStop(Integer status, Long id);

    /**
     * 根据类型查询分类
     * @return
     */
    List<Category> list(Integer type);

    /**
     * 编辑菜品分类
     * @param categoryDTO
     */
    void update(CategoryDTO categoryDTO);

    /**
     * 根据id删除菜品分类
     * @param id
     */
    void deleteById(Long id);
}
