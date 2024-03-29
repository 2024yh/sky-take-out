package com.sky.controller.admin;

import com.sky.dto.CategoryDTO;
import com.sky.dto.CategoryPageQueryDTO;
import com.sky.entity.Category;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/category")
@Slf4j
@Api(tags = "分类相关接口")
public class CategoryController {


    @Autowired
    private CategoryService categoryService;

    /**
     * 新增菜品分类
     * @param categoryDTO
     * @return
     */
    @PostMapping()
    @ApiOperation("新增分类")
    public Result save(@RequestBody CategoryDTO categoryDTO){
        categoryService.save(categoryDTO);
        return Result.success();
    }

    /**
     * 分页查询菜品分类
     * @param categoryPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    @ApiOperation("分页查询菜品分类")
    public Result<PageResult> page(CategoryPageQueryDTO categoryPageQueryDTO){
       PageResult pageResult = categoryService.pageQuery(categoryPageQueryDTO);
       return Result.success(pageResult);
    }

    /**
     * 启用禁用菜品分类
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    @ApiOperation("启用禁用菜品分类")
    public Result startOrStop(@PathVariable Integer status,Long id){
        categoryService.startOrStop(status,id);
        return Result.success();

    }

    /**
     * 根据类型查询分类
     * @param type
     * @return
     */
    @GetMapping("/list")
    @ApiOperation("根据类型查询分类")
    public Result<List<Category>> list(Integer type){
        List<Category> list = categoryService.list(type);
        return Result.success(list);
    }

    /**
     * 新增菜品分类
     * @param categoryDTO
     * @return
     */
    @PutMapping()
    @ApiOperation("编辑菜品分类")
    public Result update(@RequestBody CategoryDTO categoryDTO){
        log.info("信息:{}",categoryDTO);
        categoryService.update(categoryDTO);
        return Result.success();
    }

    @DeleteMapping
    @ApiOperation("根据id删除菜品分类")
    public Result deleteById(Long id){
        log.info("id:{}",id);
        categoryService.deleteById(id);
        return Result.success();
    }




}
