<%--
  Created by IntelliJ IDEA.
  User: SAmwake
  Date: 2021/8/17
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="/WEB-INF/views/conment/css_js.jsp"%>
</head>
<body>
<div class="container">
    <%--部门添加modal--%>
    <div class="modal fade" id="depAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">dep add</h4>
                </div>
                <div class="modal-body">
                    <%--信息添加表单--%>
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">name</label>
                            <div class="col-sm-10">
                                <input type="text" name="name" class="form-control" id="dep_add_name" placeholder="name">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                    <button type="button" class="btn btn-primary" id="dep_save">Save</button>
                </div>
            </div>
        </div>
    </div>

        <div class="modal fade" id="depUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="dep_update">Update</button>
                    </div>
                </div>
            </div>
        </div>
    <%--标题--%>
    <div class="row">
        <div class="col-md-8">
            <h2><a href="${PATH}/index.jsp">杨歌集团</a>--部门管理</h2>
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
            <button class="btn btn-success" id="depAddBtn">
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
            <table class="table table-hover" id="dep_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th>#</th>
                    <th>Name</th>
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
    let currentPage;
    let currentName;
    let currentLikeName;

    //**************************部门添加*******************************
    $("#depAddBtn").click(dep_add)

    function dep_add(){
        $("#depAddModal").modal({
            backdrop:"static"
        })
    }

    $("#dep_add_name").blur(function(){
        dep_name_check("#dep_add_name")
    })

    function dep_name_check(element){
        let name =  $(element).val()
        let nameRex = /(^[a-zA-Z0-9_-]{3,15}$)|(^[\u2E80-\u9FFF]{2,10}$)/

        if (!nameRex.test(name)) {
            isValidate(element,"error","部门名格式错误")
            return false
        }else{
            $.ajax({
                url:"${PATH}/checkDep",
                data:"name="+name,
                type:"get",
                success:function(result){
                    if (result.code == 100){
                        isValidate(element,"success","该部门名可用")
                    }else{
                        isValidate(element,"error",result.info.err_massage)
                    }
                }
            })
        }
    }

    $("#dep_save").click(dep_save)

    function dep_save(){
        let name =  $("#dep_add_name").val()
        if ($("#dep_add_name").val() == "" ||
            $("#dep_add_name").next("span").text() == "部门名格式错误" ||
            $("#dep_add_name").next("span").text() == "部门名不可用"
        ){
            return false;
        }
        $.ajax({
            url:"${PATH}/dmp",
            type:"POST",
            data:"name="+name,
            success:function (result) {
                if (result.code == 100){
                    $("#depAddModal").modal('hide')
                    to_page(9999)
                }else{
                    if(undefined != result.info.err_massage.name){
                        isValidate("#dep_add_name","error","部门名格式错误")
                    }
                }
            }
        })
    }

    //******************************修改******************************
    $(document).on("click",".edit_btn",function(){
        //ajax发送请求，查询用户信息
        getDepMass($(this).attr("dep_id"))
        //点击按钮直接弹出模态框
        $("#depUpdateModal").modal({
            backdrop:"static"
        })
    })

    function getDepMass(id){
        $.ajax({
            url:"${PATH}/getDepMess",
            type:"get",
            data:"id="+id,
            success:function (result) {
                let dep = result.info.dep;
                $("#update_id").text(dep.id)
                $("#update_name").val(dep.name)
                currentName = dep.name
            }
        })
    }

    $("#dep_update").click(update_dep)

    function update_dep(){
        let id = $("#update_id").text()
        let name = $("#update_name").val()
        if ($("#update_name").val() == "" ||
            $("#update_name").next("span").text() == "部门名格式错误" ||
            $("#update_name").next("span").text() == "部门名不可用"
        ){
            return false;
        }
        $.ajax({
            url:"${PATH}/dep/"+id,
            data:"name="+name,
            type:"put",
            success:function (result) {
                if (currentPage == undefined){
                    currentPage = 1
                }
                $("#depUpdateModal").modal('hide')
                to_page(currentPage)
            }
        })
    }

    $("#update_name").blur(function(){
        console.log("111")
        check_update_name("#update_name")
    })

    function check_update_name(element){
        if ($("#update_name").val() == currentName){
            isValidate(element,"success","")
        }else{
            dep_name_check("#update_name")
        }
    }

    //************************删除dep操作*************************
    $(document).on("click",".delete_btn",function(){
        let id = $(this).attr("dep_id")
        let name = $(this).parents("tr").find("td:eq(2)").text()
        if (confirm("是否要删除 "+ name +" ?")){

            $.ajax({
                url:"${PATH}/dep/"+id,
                type:"DELETE",
                success:function (result) {
                    to_page(currentPage)
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
                    url:"${PATH}/dep/"+ids,
                    type:"DELETE",
                    success:function (result) {
                        if (currentPage == undefined){
                            currentPage = 1
                        }
                        to_page(currentPage)
                    }
                })
            }
        }
    })

    //*************************************查询操作******************************
    $("#search_btn").click(function () {
        to_Name_page($("#search_value").val(),currentPage)
    })

    function to_Name_page(name,page){
        if (page == undefined){
            page = 1
        }
        currentLikeName = name
        $.ajax({
            url:"${PATH}/getLikeNameEmp",
            data:"pageNum="+page +"&name="+name,
            type:"get",
            success:function (result) {
                buildDepTable(result)
                buildPageNav(result)
                buildPageNav(result)
            }
        })
    }




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

    //页面已启动，直接获取第一页信息
    $(function(){
        to_page(1);
    })

    function to_page(num){
        $.ajax({
            url:"${PATH}/getDepList",
            data:"pageNum="+num,
            type:"get",
            success:function (result) {
                buildDepTable(result)
                buildDepPageInfo(result)
                buildLikeNamePageNav(result)
            }
        })
    }

    //创建部门列表
    function buildDepTable(result){
        $("#dep_table tbody").empty()
        //dep_table
        let deps = result.info.pageInfo.list

        $.each(deps,function(index,item){
            let check = $("<td></td>").append($("<input type='checkbox' class='check_item'>"))
            let id = $("<td></td>").append(item.id)
            let name = $("<td></td>").append(item.name)
            let repairBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append("<span><span/>").addClass("glyphicon glyphicon-pencil").append("编辑")
            repairBtn.attr("dep_id",item.id)
            let delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span><span/>").addClass("glyphicon glyphicon-trash").append("删除")
            delBtn.attr("dep_id",item.id)


            let btn = $("<td></td>").append(repairBtn).append(" ").append(delBtn)


            let end = $("<tr></tr>").append(check).append(id).append(name).append(btn).appendTo("#dep_table tbody")
        })
    }
    //创建页面信息
    function buildDepPageInfo(result){
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
    //创建页面导航栏
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
                currentPage = item;
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
            currentPage = 1
        })
        pre.click(function(){
            to_page(result.info.pageInfo.pageNum-1)
            currentPage = result.info.pageInfo.pageNum-1
        })
        next.click(function(){
            to_page(result.info.pageInfo.pageNum+1)
            currentPage = result.info.pageInfo.pageNum+1
        })
        last.click(function(){
            to_page(result.info.pageInfo.pages)
            currentPage = result.info.pageInfo.pages
        })
    }//创建模糊名称页面导航栏
    function buildLikeNamePageNav(result){
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
                to_Name_page(item)
                currentPage = item;
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
            to_Name_page(1)
            currentPage = 1
        })
        pre.click(function(){
            to_Name_page(result.info.pageInfo.pageNum-1)
            currentPage = result.info.pageInfo.pageNum-1
        })
        next.click(function(){
            to_Name_page(result.info.pageInfo.pageNum+1)
            currentPage = result.info.pageInfo.pageNum+1
        })
        last.click(function(){
            to_Name_page(result.info.pageInfo.pages)
            currentPage = result.info.pageInfo.pages
        })
    }
</script>
</body>
</html>
