package com.sky.controller.admin;


import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.result.PageResult;
import com.sky.result.Result;
import com.sky.service.SetmealService;
import com.sky.vo.SetmealVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.web.bind.annotation.*;

/**
 * 套餐管理
 */
@RestController
@RequestMapping("/admin/setmeal")
@Api(tags = "套餐相关接口")
@Slf4j
public class SetmealController {

    @Autowired
    private SetmealService setmealService;


    /**
     * 新增套餐
     * @param setMealDTO
     * @return
     */
    @PostMapping()
    @ApiOperation("新增套餐")
    @CacheEvict(cacheNames = "setmealCache",key = "#setMealDTO.categoryId")
    public Result save(@RequestBody SetmealDTO setMealDTO){
        log.info("新增套餐:{}",setMealDTO);
        setmealService.save(setMealDTO);

        return Result.success();
    }

    /**
     * 分页查询套餐
     * @param setmealPageQueryDTO
     * @return
     */
    @GetMapping("/page")
    @ApiOperation("分页查询套餐")
    public Result<PageResult> page(SetmealPageQueryDTO setmealPageQueryDTO){
        log.info("分页查询套餐:{}",setmealPageQueryDTO);

        PageResult pageResult = setmealService.pageQuery(setmealPageQueryDTO);

        return Result.success(pageResult);
    }

    /**
     * 根据setmealId查询套餐
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    @ApiOperation("根据setmealId查询套餐")
    public Result<SetmealVO> getById(@PathVariable Long id){
        log.info("根据setmealId查询套餐{}",id);
       SetmealVO setmealVO = setmealService.getById(id);

        return Result.success(setmealVO);
    }

    /**
     * 修改套餐信息
     * @param setmealVO
     * @return
     */
    @PutMapping
    @ApiOperation("修改套餐信息")
    @CacheEvict(cacheNames = "setmealCache",allEntries = true)
    public Result update(@RequestBody SetmealVO setmealVO){
        setmealService.update(setmealVO);
        return Result.success();
    }

    /**
     * 启售禁售套餐
     * @param status
     * @param id
     * @return
     */
    @PostMapping("/status/{status}")
    @ApiOperation("启售禁售套餐")
    @CacheEvict(cacheNames = "setmealCache",allEntries = true)
    public Result startOrStop(@PathVariable Integer status,Long id){
        setmealService.startOrStop(status,id);
        return Result.success();
    }


    /**
     * 批量删除套餐
     * @param ids
     * @return
     */
    @DeleteMapping
    @ApiOperation("批量删除套餐")
    @CacheEvict(cacheNames = "setmealCache",allEntries = true)
    public Result delete(Long[] ids){
        log.info("批量删除套餐:{}",ids);
        setmealService.deleteByIds(ids);

        return Result.success();
    }



}
