<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/18
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>角色管理</title>

    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">
    <%@ include file="/WEB-INF/views/include/header.jsp"%>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">
    <script type="text/javascript">
        var roleMgr = {
            delRole:function(roleId){
                if(confirm("您确定要删除此角色吗?")){
                    $.ajax({
                        type:'post',//请求方式
                        url:'/role/delRole',
                        dataType:'json', //有几种格式 xml html json text 等常用
                        //data传值的另外一种方式 form的序列化
                        data: {"roleId":roleId},//传递给服务器的参数
                        success:function(data){//与服务器交互成功调用的回调函数
                            //data就是out.print输出的内容
                            alert(data.result);
                            document.getElementById("roleListForm").submit();
                        }
                    });
                }
            }
        };
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="javascript:void(0);">角色列表</a></li>
    <li><a href="${ctx}/role/gotoRoleEdit?editFlag=1">角色添加</a></li>
</ul>

<form id="roleListForm" method="post" action="${ctx}/role/list">
    <table id="roleListTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>名称</th>
            <th>描述</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${roleList}" var="role">
            <tr>
                <td><a href="/role/gotoRoleEdit?editFlag=2&roleId=${role.id}">${role.name}</a></td>
                <td>${role.remarks}</td>
                <td nowrap>
                    <a href="/role/gotoRoleEdit?editFlag=2&roleId=${role.id}">修改</a>
                    <a href="javascript:roleMgr.delRole(${role.id})">删除</a>
                    <a href="/role/gotoRoleEdit?editFlag=1">添加</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</form>
</body>
</html>


