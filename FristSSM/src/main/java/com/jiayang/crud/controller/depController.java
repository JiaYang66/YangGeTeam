package com.jiayang.crud.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiayang.crud.pojo.JsonMessage;
import com.jiayang.crud.pojo.User;
import com.jiayang.crud.pojo.department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import com.jiayang.crud.service.*;

import javax.validation.Valid;
import javax.validation.constraints.Past;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class depController {

    @Autowired
    private departmentService departmentService;

    @ResponseBody
    @RequestMapping("/allDeps")
    public JsonMessage getAllDeps(){
        List<department> departments = departmentService.queryAllDep();

        return JsonMessage.success().add("empsInfo", departments);
    }

    @GetMapping("/simDep")
    public String to_sim_depList(){
        return "listDep";
    }

    @ResponseBody
    @GetMapping("/getDepList")
    public JsonMessage getAllDep(@RequestParam(value="pageNum",defaultValue = "1")int pageNum){
        PageHelper.startPage(pageNum,5);
        List<department> list = departmentService.queryAllDep();

        PageInfo<department> userPageInfo = new PageInfo<>(list,5);
        JsonMessage result = JsonMessage.success().add("pageInfo", userPageInfo);

        return result;
    }

    @ResponseBody
    @GetMapping("/checkDep")
    public JsonMessage checkDepName(String name){
        String regx = "(^[a-zA-Z0-9_-]{3,15}$)|(^[\\u2E80-\\u9FFF]{2,10}$)";
        if (!name.matches(regx)){
            return JsonMessage.fail().add("err_massage", "部门名格式错误");
        }
        int temp = departmentService.queryNameCount(name);

        if (temp != 0) {
            return JsonMessage.fail().add("err_massage", "部门名不可用");
        } else {
            return JsonMessage.success();
        }
    }

    @ResponseBody
    @PostMapping("/dmp")
    public JsonMessage saveDep(String name){
        departmentService.register(name);
        return JsonMessage.success();
    }

    @ResponseBody
    @GetMapping("/getDepMess")
    public JsonMessage getDepMess(int id){
        department department = departmentService.queryDepartmentById(id);
        return JsonMessage.success().add("dep", department);
    }

    @ResponseBody
    @PutMapping("/dep/{id}")
    public JsonMessage update_dep(@PathVariable("id") int id,String name){
        departmentService.updateDep(new department(id,name));
        return JsonMessage.success();
    }


    @ResponseBody
    @DeleteMapping("/dep/{id}")
    public JsonMessage delete_dep(@PathVariable("id") String ids){
        if (ids.contains("-")){
            String[] strings = ids.split("-");
            for (String id : strings) {
                departmentService.deleteById(Integer.parseInt(id));
            }
            return JsonMessage.success();
        }else{
            int id = Integer.parseInt(ids);
            departmentService.deleteById(id);
            return JsonMessage.success();
        }
    }


    @ResponseBody
    @GetMapping("/getLikeNameEmp")
    public JsonMessage getLikeNameEmp(int pageNum,String name){
        System.out.println(pageNum+"   "+name);
        String like_name = "%"+name+"%";
        PageHelper.startPage(pageNum,5);
        List<department> departments = departmentService.queryLikeName(like_name);

        PageInfo<department> userPageInfo = new PageInfo<>(departments,5);
        JsonMessage result = JsonMessage.success().add("pageInfo", userPageInfo);

        return result;
    }




}
