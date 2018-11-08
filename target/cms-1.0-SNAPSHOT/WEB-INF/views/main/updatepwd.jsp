<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/16
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/include/jstl.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>修改密码</title>

    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">

    <%@include file="/WEB-INF/views/include/header.jsp"%>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#oldPassword").focus();
            $("#inputForm").validate({
                rules: {
                },
                messages: {
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
    <li><a href="/user/userInfo">个人信息</a></li>
    <li class="active"><a href="/user/changePwd">修改密码</a></li>
</ul><br/>
<form id="inputForm" class="form-horizontal" action="/user/changePwd" method="post">
    <input id="id" name="id" type="hidden" value="${user.userId}"/>
    <script type="text/javascript">top.$.jBox.closeTip();</script>

    <div class="control-group">
        <label class="control-label">旧密码:</label>
        <div class="controls">
            <input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">新密码:</label>
        <div class="controls">
            <input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">确认新密码:</label>
        <div class="controls">
            <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required" equalTo="#newPassword"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"><font color="red">${errorFlag}</font></label>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
    </div>
</form>
</body>
</html>
