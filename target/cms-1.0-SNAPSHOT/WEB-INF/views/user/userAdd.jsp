<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/16
  Time: 18:56
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
        $(function() {
            $("#userNo").focus();
            $("#inputForm").validate({//对表单inputForm做验证
                rules: {
                    loginName: {
                        remote: {
                            url:"/user/checkUser",
                            type:"get",
                            data:{
                                loginName:function () {
                                    return $("#inputForm input[name='loginName']").val();
                                }
                            }
                        }
                        }

                },
                messages: {
                    loginName: {remote: "用户登录名已存在"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="/user/toUserList/1">用户列表</a></li>
    <li class="active">
        <a href="/user/toUserAdd/0">用户添加</a>
    </li>
</ul><br/>
<%--将数据提交到addUser路径--%>
<form id="inputForm" class="form-horizontal" action="/user/addUser" method="post">
    <input id="id" name="id" type="hidden" value=""/>

    <script type="text/javascript">top.$.jBox.closeTip();</script>
    <div class="control-group">
        <label class="control-label">工号:</label>
        <div class="controls">
            <input id="no" name="userNo" class="required" type="text" value="" maxlength="50"/>
            <span class="help-inline"><span style="color:red">*</span> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">姓名:</label>
        <div class="controls">
            <input id="name" name="userName" class="required" type="text" value="" maxlength="50"/>
            <span class="help-inline"><span style="color:red">*</span> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">登录名:</label>
        <div class="controls">
            <input id="oldLoginName" name="oldLoginName" type="hidden" value="">
            <input id="loginName" name="loginName" class="required userName" type="text" value="" maxlength="50"/>
            <span class="help-inline"><span style="color:red">*</span> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">密码:</label>
        <div class="controls">
            <input id="newPassword" name="password" type="password" value="" maxlength="50" minlength="3" class="required"/>
            <span class="help-inline"><span style="color:red">*</span> </span>

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">确认密码:</label>
        <div class="controls">
            <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
            <span class="help-inline"><span style="color:red">*</span> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">邮箱:</label>
        <div class="controls">
            <input id="email" name="email" class="email" type="text" value="" maxlength="100"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">电话:</label>
        <div class="controls">
            <input id="phone" name="phone" type="text" value="" maxlength="100"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">手机:</label>
        <div class="controls">
            <input id="mobile" name="mobile" type="text" value="" maxlength="100"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">用户角色:</label>
        <div class="controls">
            <c:forEach items="${roleList}" var="role">
                <span>
                    <input id="roleId${role.id}" name="roleIdList" class="required" type="checkbox"
                    <c:if test="${roleCheckMap[role.id] == role.id}">checked</c:if> value="${role.id}">
                    <label for="roleId${role.id}">${role.name}</label>
                </span>
            </c:forEach>
            <span class="help-inline"><span style="color:red">*</span> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <textarea id="remarks" name="remarks" maxlength="200" class="input-xlarge" rows="3"></textarea>
        </div>
    </div>

    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
</html>
