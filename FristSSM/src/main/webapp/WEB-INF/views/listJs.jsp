<%--
  Created by IntelliJ IDEA.
  User: SAmwake
  Date: 2021/8/13
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.apache.taglibs.standard.lang.jstl.test.PageContextImpl" %><%--
  Created by IntelliJ IDEA.
  User: SAmwake
  Date: 2021/8/11
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户列表</title>
    <%@include file="/WEB-INF/views/conment/css_js.jsp"%>
</head>
<body>
<!-- userAddModal -->
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">User add</h4>
            </div>
            <div class="modal-body">
                <%--信息添加表单--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">name</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="user_add_name" placeholder="name">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="user_add_email" placeholder="email">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="user_add_gender_M" value="男" checked> man
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="user_add_gender_W" value="女"> women
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="department_id" id="dep_node">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                <button type="button" class="btn btn-primary" id="user_save">Save</button>
            </div>
        </div>
    </div>
</div>
<!--userUpdateModel-->
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >User update</h4>
            </div>
            <div class="modal-body">
                <%--信息添加表单--%>
                <form class="form-horizontal" method="post">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">id</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="update_id"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">name</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" class="form-control" id="update_name" placeholder="name">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="update_email" placeholder="email">
                            <span  class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_man" value="男" checked> man
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="update_women" value="女"> women
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="department_id" id="update_select">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="user_update">Update</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-8">
            <h2><a href="${PATH}/index.jsp">杨歌集团</a>--用户管理</h2>
        </div>
        <div class="col-md-5">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search by name" id="search_value">
                <span class="input-group-btn">
                <button class="btn btn-success" type="button" id="search_btn">Go!</button>
                </span>
            </div><!-- /input-group -->
        </div><!-- /.col-lg-6 -->
    </div>


    <%--修改按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-success" id="userAddBtn">
                <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>添加
            </button>
            <button class="btn btn-danger" id = "delete_all">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
            </button>
        </div>
    </div>


    <%--数据信息--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="checkAll"></th>
                        <th>#</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>
                            <div class="dropdown">
                                <button class="btn btn-default dropdown-toggle" type="button" id="department_toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                    department
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="department_toggle_value">

                                </ul>
                            </div>
                        </th>
                        <th>Operation</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>



            </table>
        </div>
    </div>
    <%--页面信息--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info">

        </div>

        <%--分页条信息   --%>
        <div class="col-md-6" id="page_nav">

        </div>

    </div>
</div>

    <script type="text/javascript">
        let currentPageNum;
        let pageItemNum;
        let likeName;
        let dep_id_const;
        let page_method; //name dep org
        //全面清除表单内容
        function clear_form(element){
            $(element)[0].reset()
            $(element).find("*").removeClass("has-error has-success")
            $(element).find(".help-block").text("")
        }

        //添加用户模态框
        $("#userAddBtn").click(function(){
            clear_form("#userAddModal form")

            getDepartments("#dep_node")

            //点击按钮直接弹出模态框
            $("#userAddModal").modal({
                backdrop:"static"
            })
        })

        //通用的模态框弹出部门操作，提供id即可
        function getDepartments(element){
            $(element).empty();
            $.ajax({
                url: "${PATH}/allDeps",
                type: "get",
                success:function(result){
                    let names = result.info.empsInfo
                    $.each(names,function(index,item){
                        $(element).append($("<option></option>").append(item.name).attr("value",this.id))
                    })
                }
            })
        }

        //通用的下拉框弹出部门操作，提供id即可
        function getDepartmentsSelect(element){
            $(element).empty();
            $.ajax({
                url: "${PATH}/allDeps",
                type: "get",
                success:function(result){
                    let names = result.info.empsInfo
                    $.each(names,function(index,item){
                        let select = $("<li></li>").append($("<a href='#'></a>").append(item.name).attr("value",this.id).addClass("select_item"))
                        $(element).append(select)
                    })
                }
            })
        }

        //根据depid实现跳转
        $(document).on("click",".select_item",to_dep_select)

        function to_dep_select(pageNum){
            if(typeof pageNum == "object"){
                pageNum = 1
            }
            let depId = $(this).attr("value")
            if (depId != undefined){
                dep_id_const = depId
            }
            $.ajax({
                url:"${PATH}/empsDepName",
                data:"dep_id="+dep_id_const+"&pageNum="+pageNum,
                type:"get",
                success:function (result) {
                    buildEmpsTable(result)
                    buildPageInfo(result)
                    buildDepPageNav(result)
                }
            })
        }

        //name 失去焦点函数
        function input_name_blur(element){
            let name_value = $(element).val();
            let regName = /(^[a-zA-Z0-9_-]{3,15}$)|(^[\u2E80-\u9FFF]{2,10}$)/

            //先检查名字符不符合标准，再检查名字在数据库有没有重复
            if (!regName.test(name_value)) {
                isValidate(element,"error","用户名格式错误")
                return false
            }else{
                $.ajax({
                    url:"${PATH}/checkUser",
                    data:"name="+name_value,
                    type:"get",
                    success:function(result){
                        if (result.code == 100){
                            isValidate(element,"success","该用户名可用")
                        }else{
                            isValidate(element,"error",result.info.err_massage)
                        }
                    }
                })
            }
        }

        //email 失去焦点函数
        function input_email_blur(element){
            let email_value = $(element).val();
            let regEmail = /(^[a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6}$)/
            if (!regEmail.test(email_value)) {
                isValidate(element,"error","邮箱格式错误")
                return false
            }else{
                //初步验证成功，验证是否已经被注册
                $.ajax({
                    url:"${PATH}/emailCheck",
                    data:"email="+email_value,
                    type:"get",
                    success:function(result){
                        if (result.code == 100){
                            isValidate(element,"success","该邮箱可用")
                        }else{
                            isValidate(element,"error",result.info.err_massage)
                        }
                    }
                })
            }
        }

        //填写用户姓名失去焦点
        $("#user_add_name").blur(function(){
            input_name_blur("#user_add_name")
        })

        //填写用户email失去焦点
        $("#user_add_email").blur(function(){
            input_email_blur("#user_add_email")
        })


        //验证表单
        function isValidate(element,status,massage){
            $(element).parent().removeClass("has-success has-error")
            $(element).next("span").text("")
            if ("success" == status){
                $(element).parent().addClass("has-success")
                $(element).next("span").text(massage)
            }else if("error" == status){
                $(element).parent().addClass("has-error")
                $(element).next("span").text(massage)
                return false;
            }
        }

        //保存用户
        $("#user_save").click(function(){
            if($("#user_add_name").next("span").text() != "该用户名可用" ||
                $("#user_add_email").next("span").text() != "该邮箱可用" ||
                $("#user_add_name").val() == "" ||
                $("#user_add_email").val() == ""
                ){
                return false;
            }
            $.ajax({
                url:"${PATH}/emp",
                type:"POST",
                data:$("#userAddModal form").serialize(),
                success:function(result){

                    //JSR303数据校验查看是否出错
                    if(result.code == 100){
                        $("#userAddModal").modal('hide')
                        to_page(9999)
                    }else{
                        //要是某个字出了错误，直接显示这个错误信息 ， 如果没有错误就是undefind
                        if(undefined != result.info.err_massage.email){
                            isValidate("#user_add_email","error","邮箱格式错误")
                        }
                        if(undefined != result.info.err_massage.name){
                            isValidate("#user_add_name","error","用户名格式错误")
                        }
                    }
                }
            })
        })

        //页面已启动，直接获取第一页信息
        $(function(){
            to_page(1)
        })

        //******************************************用户更新操作**********************************
        $(document).on("click",".edit_btn",function(){
            clear_form("#userUpdateModal form")
            //查询出部门信息
            getDepartments("#update_select")
            //ajax发送请求，查询用户信息
            getUserMass($(this).attr("user_id"))
            $("#user_update").attr("edit_id",$(this).attr("user_id"))
            //点击按钮直接弹出模态框
            $("#userUpdateModal").modal({
                backdrop:"static"
            })
        })

        //获取用户信息
        function getUserMass(id){
            $.ajax({
                url:"${PATH}/emp/"+id,
                type:"get",
                success: function (result) {
                    //获取用户数据并且进行赋值
                    let user = result.info.user_massage;

                    $("#update_id").text(user.id)
                    $("#update_name").val(user.name)
                    $("#userUpdateModal input[name=gender]").val([user.gender])
                    $("#update_email").val(user.email)
                    $("#userUpdateModal select").val([user.dep.id])

                }
            })
        }

        //更新表单的格式验证 ， 要是失去焦点的时候val与之前一样就不用比较
        $("#update_name").blur(function(){
            let id = $("#update_id").text();
            let name;
            $.ajax({
                url:"${PATH}/emp/"+id,
                type:"get",
                async:false,
                success:function (result) {
                    name = result.info.user_massage.name
                }
            })
            if (name != $("#update_name").val()){
                input_name_blur("#update_name")
            }else{
                $("#update_name").parent().removeClass("has-success has-error")
                $("#update_name").next("span").text("")
            }
        })
        $("#update_email").blur(function(){
            let id = $("#update_id").text();
            let email;
            $.ajax({
                url:"${PATH}/emp/"+id,
                type:"get",
                async:false,
                success:function (result) {
                    email = result.info.user_massage.email
                }
            })
            if (email != $("#update_email").val()){
                input_email_blur("#update_email")
            }else{
                $("#update_email").parent().removeClass("has-success has-error")
                $("#update_email").next("span").text("")
            }
        })

        //点击更新按钮，进行更新操作
        //如果直接发送put请求， Tomcat是不会封装请求体中的数据为map的，连getParameter()也获取不到
        //唯有添加过滤器FormContentFilter
        $("#user_update").click(function(){
            if($("#update_name").next("span").text() != "该用户名可用" &&
                $("#update_name").next("span").text() != "" ||
                $("#update_email").next("span").text() != "该邮箱可用" &&
                $("#update_email").next("span").text() != "" ||
                $("#update_name").val() == "" ||
                $("#update_email").val() == ""
            ){
                return false;
            }else{
                $.ajax({
                    url:"${PATH}/emp/"+$(this).attr("edit_id"),
                    type:"put",
                    data:$("#userUpdateModal form").serialize(),
                    success:function (result) {
                        if (result.code == 100){
                            $("#userUpdateModal").modal('hide')
                            to_page_method_nav(currentPageNum)
                        }else{
                            //要是某个字出了错误，直接显示这个错误信息 ， 如果没有错误就是undefind
                            if(undefined != result.info.err_massage.email){
                                isValidate("#update_email","error","邮箱格式错误")
                            }
                            if(undefined != result.info.err_massage.name){
                                isValidate("#update_name","error","用户名格式错误")
                            }
                        }

                    }
                })
            }
        })

        //**************************************用户删除操作***************************************
        $(document).on("click",".delete_btn",function(){
            let name = $(this).parents("tr").find("td:eq(2)").text()
            if (confirm("确认删除 " + name + " 嘛？")){
                let id = $(this).attr("user_id")
                $.ajax({
                    url:"${PATH}/emp/"+id,
                    type:"DELETE",
                    success:function (result) {
                        to_page_method_nav(currentPageNum)
                    }
                })
            }
        })

        $("#checkAll").click(function(){
            $(".check_item").prop("checked",$(this).prop("checked"))
        })

        $(document).on("click",".check_item",function(){
            if (pageItemNum == $(".check_item:checked").length){
                $("#checkAll").prop("checked",true)
            }else{
                $("#checkAll").prop("checked",false)
            }
        })

        $("#delete_all").click(function(){
            let names = "",ids = ""
            $.each($(".check_item:checked"),function(){
                let name = $(this).parents("tr").find("td:eq(2)").text()
                names += name+" , "
                let id = $(this).parents("tr").find("td:eq(1)").text();
                ids += id+"-"
            })

            names = names.substring(0,names.length-3)
            ids = ids.substring(0,ids.length-1)
            if (names != ""){
                if (confirm("确认删除 "+names+" 嘛？")){
                    $.ajax({
                        url:"${PATH}/emp/"+ids,
                        type:"DELETE",
                        success:function (result) {
                            to_page_method_nav(currentPageNum)
                        }
                    })
                }
            }
        })
        //*******************************************查询操作**********************************

        //查看当前是哪个查询
        function to_page_method_nav(page){
            if (page_method == "org"){
                to_page(page)
            }else if (page_method == "name"){
                to_likeName_page(likeName,page)
            }else if (page_method == "dep"){
                to_dep_select(page)
            }
        }

        //调用此方法可以根据形参跳转指定页面
        function to_page(num){
            page_method = "org"
            $.ajax({
                url:"${PATH}/empsJS",
                data:"pageNum="+num,
                type:"get",
                success:function(result){
                    $("#checkAll").prop("checked",false)
                    /*解析信息*/
                    buildEmpsTable(result)
                    buildPageInfo(result)
                    buildPageNav(result)
                    getDepartmentsSelect("#department_toggle_value")
                }
            })
        }

        //根据depid实现跳转
        $(document).on("click",".select_item",to_dep_select)

        function to_dep_select(pageNum){
            page_method = "dep"
            if(typeof pageNum == "object"){
                pageNum = 1
            }
            let depId = $(this).attr("value")
            if (depId != undefined){
                dep_id_const = depId
            }
            $.ajax({
                url:"${PATH}/empsDepName",
                data:"dep_id="+dep_id_const+"&pageNum="+pageNum,
                type:"get",
                success:function (result) {
                    buildEmpsTable(result)
                    buildPageInfo(result)
                    buildDepPageNav(result)
                }
            })
        }

        //模糊名字查询
        function to_likeName_page(nameVal,num){
            likeName = nameVal;
            page_method = "name"
            $.ajax({
                url:"${PATH}/empsLikeName",
                data:"pageNum="+num+"&nameVal="+nameVal,
                type:"get",
                success:function(result){
                    /*解析信息*/
                    buildEmpsTable(result)
                    buildPageInfo(result)
                    buildNamePageNav(result,nameVal)
                }
            })
        }

        $("#search_btn").click(function(){
            let name = $("#search_value").val()
            to_likeName_page(name,1)
        })




        //解析显示员工信息
        function buildEmpsTable(result){
            $("#emps_table tbody").empty()
             let emps = result.info.pageInfo.list;
             $.each(emps,function(index,item){
                let check = $("<td></td>").append($("<input type='checkbox' class='check_item'>"))
                let id = $("<td></td>").append(item.id)
                let name = $("<td></td>").append(item.name)
                let gender = $("<td></td>").append(item.gender)
                let email = $("<td></td>").append(item.email)
                let dep = $("<td></td>").append(item.dep.name)
                let repairBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                .append("<span><span/>").addClass("glyphicon glyphicon-pencil").append("编辑")
                repairBtn.attr("user_id",item.id)
                let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                                .append("<span><span/>").addClass("glyphicon glyphicon-trash").append("删除")
                delBtn.attr("user_id",item.id)


                let btn = $("<td></td>").append(repairBtn).append(" ").append(delBtn)


                let end = $("<tr></tr>").append(check).append(id).append(name).append(gender).append(email).append(email).append(dep).append(btn).appendTo("#emps_table tbody")
             })
        }

        //解析显示分页信息
        function buildPageInfo(result){
            $("#page_info").empty()
            // 当前 页   |   总 共页  |   总共  条数据
            $("#page_info").append("当前")
                          .append(result.info.pageInfo.pageNum)
                          .append("页 ， 总")
                          .append(result.info.pageInfo.pages)
                          .append("页 ， 总共")
                          .append(result.info.pageInfo.total)
                          .append("条数据")
            currentPageNum = result.info.pageInfo.pageNum
            pageItemNum = result.info.pageInfo.pageSize
        }

        //*************************************分页操作************************************
        //解析显示分页条
        function buildPageNav(result){
            $("#page_nav").empty()
            let fa_nav = $("<nav></nav>")
            let fa_ul = $("<ul></ul>").addClass("pagination")

            let first = $("<li></li>").append($("<a></a>").append("首页").attr("herf","#"))
            let pre = $("<li></li>").append($("<a></a>").append("&laquo;"))
            if (result.info.pageInfo.hasPreviousPage == false){
                first.addClass("disabled")
                pre.addClass("disabled")
            }

            fa_ul.append(first).append(pre)

            $.each(result.info.pageInfo.navigatepageNums,function(index,item){
                let navInfo = $("<li></li>").append($("<a></a>").append(item))
                if (result.info.pageInfo.pageNum == item){
                    navInfo.addClass("active")
                }
                navInfo.click(function(){
                    to_page(item)
                })
                fa_ul.append(navInfo)
            })

            let next = $("<li></li>").append($("<a></a>").append("&raquo;"))
            let last = $("<li></li>").append($("<a></a>").append("尾页").attr("herf","#"))
            if (result.info.pageInfo.hasNextPage == false){
                next.addClass("disabled")
                last.addClass("disabled")
            }

            fa_ul.append(next).append(last)
            fa_nav.append(fa_ul).appendTo("#page_nav")


            first.click(function(){
                to_page(1)
            })
            pre.click(function(){
                to_page(result.info.pageInfo.pageNum-1)
            })
            next.click(function(){
                to_page(result.info.pageInfo.pageNum+1)
            })
            last.click(function(){
                to_page(result.info.pageInfo.pages)
            })
        }

        //模糊名字分页条
        function buildNamePageNav(result,nameVal){
            $("#page_nav").empty()
            let fa_nav = $("<nav></nav>")
            let fa_ul = $("<ul></ul>").addClass("pagination")

            let first = $("<li></li>").append($("<a></a>").append("首页").attr("herf","#"))
            let pre = $("<li></li>").append($("<a></a>").append("&laquo;"))
            if (result.info.pageInfo.hasPreviousPage == false){
                first.addClass("disabled")
                pre.addClass("disabled")
            }

            fa_ul.append(first).append(pre)

            $.each(result.info.pageInfo.navigatepageNums,function(index,item){
                let navInfo = $("<li></li>").append($("<a></a>").append(item))
                if (result.info.pageInfo.pageNum == item){
                    navInfo.addClass("active")
                }
                navInfo.click(function(){
                    to_likeName_page(nameVal,item)
                })
                fa_ul.append(navInfo)
            })

            let next = $("<li></li>").append($("<a></a>").append("&raquo;"))
            let last = $("<li></li>").append($("<a></a>").append("尾页").attr("herf","#"))
            if (result.info.pageInfo.hasNextPage == false){
                next.addClass("disabled")
                last.addClass("disabled")
            }

            fa_ul.append(next).append(last)
            fa_nav.append(fa_ul).appendTo("#page_nav")


            first.click(function(){
                to_likeName_page(nameVal,1)
            })
            pre.click(function(){
                to_likeName_page(nameVal,result.info.pageInfo.pageNum-1)
            })
            next.click(function(){
                to_likeName_page(nameVal,result.info.pageInfo.pageNum+1)
            })
            last.click(function(){
                to_likeName_page(nameVal,result.info.pageInfo.pages)
            })
        }


        //根据depid查询员工分页条
        function buildDepPageNav(result){
            $("#page_nav").empty()
            let fa_nav = $("<nav></nav>")
            let fa_ul = $("<ul></ul>").addClass("pagination")

            let first = $("<li></li>").append($("<a></a>").append("首页").attr("herf","#"))
            let pre = $("<li></li>").append($("<a></a>").append("&laquo;"))
            if (result.info.pageInfo.hasPreviousPage == false){
                first.addClass("disabled")
                pre.addClass("disabled")
            }

            fa_ul.append(first).append(pre)

            $.each(result.info.pageInfo.navigatepageNums,function(index,item){
                let navInfo = $("<li></li>").append($("<a></a>").append(item))
                if (result.info.pageInfo.pageNum == item){
                    navInfo.addClass("active")
                }
                navInfo.click(function(){
                    to_dep_select(item)
                })
                fa_ul.append(navInfo)
            })

            let next = $("<li></li>").append($("<a></a>").append("&raquo;"))
            let last = $("<li></li>").append($("<a></a>").append("尾页").attr("herf","#"))
            if (result.info.pageInfo.hasNextPage == false){
                next.addClass("disabled")
                last.addClass("disabled")
            }

            fa_ul.append(next).append(last)
            fa_nav.append(fa_ul).appendTo("#page_nav")


            first.click(function(){
                to_dep_select(dep_id,1)
            })
            pre.click(function(){
                to_dep_select(result.info.pageInfo.pageNum-1)
            })
            next.click(function(){
                to_dep_select(result.info.pageInfo.pageNum+1)
            })
            last.click(function(){
                to_dep_select(result.info.pageInfo.pages)
            })
        }

    </script>

</body>
</html>
</body>
</html>
