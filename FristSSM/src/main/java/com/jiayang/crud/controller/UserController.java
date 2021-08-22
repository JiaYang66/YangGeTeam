package com.jiayang.crud.controller;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiayang.crud.pojo.*;
import com.jiayang.crud.service.UserService;
import com.jiayang.crud.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;


    /**
     * 根据参数页码查询user
     * @param page
     * @return
     */
//    @RequestMapping("/emps")
//    public String getList(@RequestParam(value = "pageNum",defaultValue = "1")int page,Model model){
////        参数一是页码 ， 参数二是一页有多少个数据
////        注意pageHelper是跟查找所有 user 紧挨着的
//        PageHelper.startPage(page, 5);
//        List<User> users = userService.queryAllUser();
////        pageInfo封装了详细的分页信息，包括有我们查询出来的数据
////        第二个参数是页面上面可以直接跳转的个数  | 1 | 2 | 3 | 4 | 5 |
//        PageInfo<User> info = new PageInfo<>(users,5);
////        通过model将数据传给页面
//        model.addAttribute("userPage", info);
//        return "list";
//    }

    /**
     * 返回json数据
     * @param pageNum
     * @return
     */
    @ResponseBody
    @RequestMapping("/empsJS")
    public JsonMessage getEmpsListWithJson(@RequestParam(value="pageNum",defaultValue = "1")int pageNum){
        PageHelper.startPage(pageNum,5);
        List<User> users = userService.queryAllUser();

        PageInfo<User> userPageInfo = new PageInfo<>(users,5);
        JsonMessage result = JsonMessage.success().add("pageInfo", userPageInfo);

        return result;

    }

    /**
     * 简单跳转到list页面 ， list页面会发送阿贾克斯请求/empsJs？pageNum=？ 获取数据
     * @return
     */
    @RequestMapping("/empsSim")
    public String getListSimple(){
        return "listJs";
    }


    /**
     * hibernate-validator支持JSR303数据校验 @Valid 表示对对象的属性进行校验，bindingResult表示错误结果
     * @param user
     * @param department_id
     * @param result
     * @return
     */
    @PostMapping("/emp")
    @ResponseBody
    public JsonMessage saveUser(@Valid User user, int department_id, BindingResult result) {

        if (result.hasErrors()){
            Map<String,Object> errorMap = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error : fieldErrors) {
                errorMap.put(error.getField(), error.getDefaultMessage());
            }

            return JsonMessage.fail().add("err_massage",errorMap);
        }else{
            userService.register(user,department_id);
            return JsonMessage.success();
        }
    }

    //双重验证，为了避免有人跳过前端
    @ResponseBody
    @RequestMapping("/checkUser")
    public JsonMessage userCheck(@RequestParam("name") String name) {
        String regx = "(^[a-zA-Z0-9_-]{3,15}$)|(^[\\u2E80-\\u9FFF]{2,10}$)";
        if (!name.matches(regx)){
            return JsonMessage.fail().add("err_massage", "用户名格式错误");
        }
        int temp = userService.queryNameCount(name);

        if (temp != 0) {
            return JsonMessage.fail().add("err_massage", "用户名不可用");
        } else {
            return JsonMessage.success();
        }
    }

    @ResponseBody
    @RequestMapping("/emailCheck")
    public JsonMessage userEmailCheck(@RequestParam("email") String email){
        String regx = "(^[a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6}$)";
        if (!email.matches(regx)){
            return JsonMessage.fail().add("err_massage", "邮箱格式错误");
        }

        int temp = userService.queryEmailCount(email);

        if (temp != 0){
            return JsonMessage.fail().add("err_massage", "该邮箱已经被注册");
        }else{
            return JsonMessage.success();
        }

    }

    /**
     * 查询员工信息
     * @param id
     * @return
     */
    @GetMapping("/emp/{id}")
    @ResponseBody
    public JsonMessage getUserById(@PathVariable("id") int id){
        User user = userService.queryUserById(id);
        return JsonMessage.success().add("user_massage", user);
    }


    /**
     * 跟新用户操作
     * @param user
     * @param department_id
     * @return
     */
    @PutMapping("/emp/{id}")
    @ResponseBody
    public JsonMessage save_update(@Valid User user,int department_id,BindingResult result){
        if (result.hasErrors()) {
            Map<String, Object> errorMap = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError error : fieldErrors) {
                errorMap.put(error.getField(), error.getDefaultMessage());
            }

            return JsonMessage.fail().add("err_massage", errorMap);
        }else{
            userService.updateUser(user,department_id);
            return JsonMessage.success();
        }

    }

    //单删双删二合一
    @DeleteMapping("/emp/{ids}")
    @ResponseBody
    public JsonMessage delete_user(@PathVariable("ids") String ids) {
        if (ids.contains("-")){
            String[] strings = ids.split("-");
            for (String id : strings) {
                userService.deleteUserById(Integer.parseInt(id));
            }
            return JsonMessage.success();
        }else{
            int id = Integer.parseInt(ids);
            userService.deleteUserById(id);
            return JsonMessage.success();
        }

    }


    //名字的模糊查询
    @ResponseBody
    @GetMapping("/empsLikeName")
    public JsonMessage getUserListByLikeName(String nameVal,@RequestParam(value="pageNum",defaultValue = "1")int pageNum){
        String name = "%"+nameVal+"%";
        PageHelper.startPage(pageNum,5);
        List<User> users = userService.queryUserByLikeName(name);

        PageInfo<User> userPageInfo = new PageInfo<>(users,5);
        JsonMessage result = JsonMessage.success().add("pageInfo", userPageInfo);

        return result;
    }

    //根据depId返回员工集合
    @ResponseBody
    @GetMapping("/empsDepName")
    public JsonMessage getUserListByLikeName(int dep_id,@RequestParam(value="pageNum",defaultValue = "1")int pageNum){
        PageHelper.startPage(pageNum,5);
        List<User> users = userService.queryUserByDepId(dep_id);

        PageInfo<User> userPageInfo = new PageInfo<>(users,5);
        JsonMessage result = JsonMessage.success().add("pageInfo", userPageInfo);

        return result;
    }








}
