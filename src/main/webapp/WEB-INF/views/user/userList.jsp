<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/16
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/include/jstl.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>

    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">
    <%@include file="/WEB-INF/views/include/header.jsp"%>
    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","/sys/user/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="/user/toUserList/1">用户列表</a></li>
    <li><a href="/user/toUserAdd/0">用户添加</a></li>
</ul>
<form id="searchForm" class="breadcrumb form-search " action="#" method="post">
    <input id="pageNo" name="pageNo" type="hidden" value="1"/>
    <input id="pageSize" name="pageSize" type="hidden" value="15"/>
    <input id="orderBy" name="orderBy" type="hidden" value=""/>

    <script type="text/javascript">
        $(document).ready(function() {
            var orderBy = $("#orderBy").val().split(" ");
            $(".sort-column").each(function(){
                if ($(this).hasClass(orderBy[0])){
                    orderBy[1] = orderBy[1]&&orderBy[1].toUpperCase()=="DESC"?"down":"up";
                    $(this).html($(this).html()+" <i class=\"icon icon-arrow-"+orderBy[1]+"\"></i>");
                }
            });
            $(".sort-column").click(function(){
                var order = $(this).attr("class").split(" ");
                var sort = $("#orderBy").val().split(" ");
                for(var i=0; i<order.length; i++){
                    if (order[i] == "sort-column"){order = order[i+1]; break;}
                }
                if (order == sort[0]){
                    sort = (sort[1]&&sort[1].toUpperCase()=="DESC"?"ASC":"DESC");
                    $("#orderBy").val(order+" DESC"!=order+" "+sort?"":order+" "+sort);
                }else{
                    $("#orderBy").val(order+" ASC");
                }
                page();
            });
        });
    </script>
    <ul class="ul-form">
        <li><label>所属公司：</label>
            <div class="input-append">
                <input id="companyId" name="company.id" class="input-small" type="hidden" value=""/>
                <input id="companyName" name="company.name" readonly="readonly" type="text" value="" data-msg-required=""
                       class="input-small" style=""/><a id="companyButton" href="javascript:" class="btn  " style="">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
            </div>
            <script type="text/javascript">
                $("#companyButton, #companyName").click(function(){
                    // 是否限制选择，如果限制，设置为disabled
                    if ($("#companyButton").hasClass("disabled")){
                        return true;
                    }
                    // 正常打开	
                    top.$.jBox.open("iframe:/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=1")+"&module=&checked=&extId=&isAll=", "选择公司", 300, 420, {
                        ajaxData:{selectIds: $("#companyId").val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                            if (v=="ok"){
                                var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                                var ids = [], names = [], nodes = [];
                                if ("" == "true"){
                                    nodes = tree.getCheckedNodes(true);
                                }else{
                                    nodes = tree.getSelectedNodes();
                                }
                                for(var i=0; i<nodes.length; i++) {//
                                    ids.push(nodes[i].id);
                                    names.push(nodes[i].name);//
                                    break; // 如果为非复选框选择，则返回第一个选择  
                                }
                                $("#companyId").val(ids.join(",").replace(/u_/ig,""));
                                $("#companyName").val(names.join(","));
                            }//
                            else if (v=="clear"){
                                $("#companyId").val("");
                                $("#companyName").val("");
                            }//
                            if(typeof companyTreeselectCallBack == 'function'){
                                companyTreeselectCallBack(v, h, f);
                            }
                        }, loaded:function(h){
                            $(".jbox-content", top.document).css("overflow-y","hidden");
                        }
                    });
                });
            </script></li>
        <li><label>登录名：</label><input id="loginName" name="loginName" class="input-medium" type="text" value="" maxlength="50"/></li>
        <li class="clearfix"></li>
        <li><label>所属部门：</label>
            <div class="input-append">
                <input id="officeId" name="office.id" class="input-small" type="hidden" value=""/>
                <input id="officeName" name="office.name" readonly="readonly" type="text" value="" data-msg-required=""
                       class="input-small" style=""/><a id="officeButton" href="javascript:" class="btn  " style="">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
            </div>
            <script type="text/javascript">
                $("#officeButton, #officeName").click(function(){
                    // 是否限制选择，如果限制，设置为disabled
                    if ($("#officeButton").hasClass("disabled")){
                        return true;
                    }
                    // 正常打开	
                    top.$.jBox.open("iframe:/tag/treeselect?url="+encodeURIComponent("/sys/office/treeData?type=2")+"&module=&checked=&extId=&isAll=", "选择部门", 300, 420, {
                        ajaxData:{selectIds: $("#officeId").val()},buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                            if (v=="ok"){
                                var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                                var ids = [], names = [], nodes = [];
                                if ("" == "true"){
                                    nodes = tree.getCheckedNodes(true);
                                }else{
                                    nodes = tree.getSelectedNodes();
                                }
                                for(var i=0; i<nodes.length; i++) {//
                                    if (nodes[i].isParent){
                                        top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
                                        return false;
                                    }//
                                    ids.push(nodes[i].id);
                                    names.push(nodes[i].name);//
                                    break; // 如果为非复选框选择，则返回第一个选择  
                                }
                                $("#officeId").val(ids.join(",").replace(/u_/ig,""));
                                $("#officeName").val(names.join(","));
                            }//
                            else if (v=="clear"){
                                $("#officeId").val("");
                                $("#officeName").val("");
                            }//
                            if(typeof officeTreeselectCallBack == 'function'){
                                officeTreeselectCallBack(v, h, f);
                            }
                        }, loaded:function(h){
                            $(".jbox-content", top.document).css("overflow-y","hidden");
                        }
                    });
                });
            </script></li>
        <li><label>姓&nbsp;&nbsp;&nbsp;名：</label><input id="name" name="name" class="input-medium" type="text" value="" maxlength="50"/></li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>

        <li class="clearfix"></li>
    </ul>
</form>
<script type="text/javascript">top.$.jBox.closeTip();</script>

<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <%--<th>所属公司</th>--%>
        <%--<th>所属部门</th>--%>
        <th class="sort-column login_name">登录名</th>
        <th class="sort-column name">姓名</th>
        <th>电话</th>
        <th>手机</th>
        <th>邮箱</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%--循环接收后台传来的user，将属性依次填入--%>
    <c:forEach items="${userList}" var="user">
        <tr>
            <%--<td>Xoyar总公司</td>--%>
            <%--<td>开发部</td>--%>
            <td><a href="#">${user.loginName}</a></td>
            <td>${user.userName}</td>
            <td>${user.phone}</td>
            <td>${user.mobile}</td>
            <td>${user.email}</td>
            <td>
                <a href="/user/toUserAdd/${user.userId}">修改</a>
                <a href="/user/delUser/${user.userId}/${currPage}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>


    </tbody>
</table>
<div class="pagination"><ul>
    <c:if test="${currPage!=1}">
        <li class="disabled"><a href="/toUserList/<c:out value="${currPage-1}"/>">&#171; 上一页</a></li>
    </c:if>
    <li class="active"><a href="/toUserList/<c:out value="${currPage}"/>"><c:out value="${currPage}"/></a></li>
    <c:if test="${currPage!=totalPage}">
        <li class="disabled"><a href="/toUserList/<c:out value="${currPage+1}"/>">下一页 &#187;</a></li>
    </c:if>
    <li class="disabled controls"><a href="javascript:">当前 <input type="text" value="1" onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(this.value,15,'');" onclick="this.select();"/> / <input type="text" value="15" onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(1,this.value,'');" onclick="this.select();"/> 条，共 <c:out value="${totalPage}"/>条</a></li>
</ul>
    <div style="clear:both;"></div></div>
</body>
</html>