<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/17
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@include file="/WEB-INF/views/include/jstl.jsp"%>

    <!DOCTYPE html>
    <html>
    <head>
    <title>菜单管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/WEB-INF/views/include/header.jsp"%>
    <meta name="renderer" content="webkit">
    <script type="text/javascript">
    $(function() {
        $("#treeTable").treeTable({
            expandLevel : 5
        }).show();
    });

    var menuMgr = {
        delMenu:function(menuId){
            if(confirm("您确定要删除此菜单吗?")){
                $.ajax({
                    type:'post',//请求方式
                    url:'/menu/delMenu',
                    dataType:'json', //有几种格式 xml html json text 等常用
                    //data传值的另外一种方式 form的序列化
                    data: {"menuId":menuId},//传递给服务器的参数
                    success:function(data){//与服务器交互成功调用的回调函数
                    //data就是out.print输出的内容
                        alert(data.result);
                        document.getElementById("menuListForm").submit();
                    }
                });
            }
        }
    };

    </script>
    <body>
    <ul class="nav nav-tabs">
    <li class="active">
    <a href="/menu/menuList">菜单列表</a>
    </li>
    <li>
    <a href="/menu/toMenuEdit?editFlag=1">菜单添加</a>
    </li>
    </ul>
    <form id="menuListForm" method="post">
        <table id="treeTable" class="table table-striped table-bordered table-condensed hide">
            <thead>
                <tr>
                    <th>名称</th>
                    <th>链接</th>
                    <th style="text-align: center;">排序</th>
                    <th>可见</th>
                    <th>权限标识</th>
                    <th>操作</th>
                </tr>
            </thead>
        <tbody>
        <c:forEach items="${menuList}" var="menu">
            <tr id="${menu.id}" pId="${ menu.parentId }">
                <td nowrap>
                    <i class="icon- hide"></i>
                    <a href="#">${ menu.name }</a>
                </td>
                <td title="${ menu.href }">${ menu.href }</td>
                <td style="text-align: center;">
                ${ menu.sort }
                </td>
                <td>
                    <c:choose>
                        <c:when test="${menu.isShow==1}">显示</c:when>
                        <c:otherwise>不显示</c:otherwise>
                    </c:choose>
                </td>
                <td title="${ menu.permission }">${ menu.permission }</td>
                <td nowrap>
                    <a href="/menu/toMenuEdit?editFlag=2&menuId=${menu.id} ">修改</a>
                    <a href="javascript:menuMgr.delMenu(${menu.id})">删除</a>
                    <a href="/menu/toMenuEdit?editFlag=1&parentId=${menu.id}">添加下级菜单</a>
                </td>
            </tr>
        </c:forEach>

        </tbody>
        </table>
    </form>
    </body>
    </html>
