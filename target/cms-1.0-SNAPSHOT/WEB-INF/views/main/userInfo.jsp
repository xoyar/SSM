<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/16
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/include/jstl.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>个人信息</title>

    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">
    <%@include file="/WEB-INF/views/include/header.jsp"%>
    <script type="text/javascript">
        $(function() {
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在保存');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("messageBox什么？？？");
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
    <li class="active"><a href="/user/userInfo">个人信息</a></li>
    <li><a href="/user/updatepwd">修改密码</a></li>
</ul><br/>
<form id="inputForm" class="form-horizontal" action="#" method="post">
    <script type="text/javascript">top.$.jBox.closeTip();</script>

    <div class="control-group">
        <label class="control-label">所属公司:</label>
        <div class="controls">
            <label class="lbl">湖南省总公司</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所属部门:</label>
        <div class="controls">
            <label class="lbl">公司领导</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">姓名:</label>
        <div class="controls">
            <input id="name" name="name" class="required" readonly="readonly" type="text" value="系统超级管理员" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">邮箱:</label>
        <div class="controls">
            <input id="email" name="email" class="email" type="text" value="colin@163.com" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">电话:</label>
        <div class="controls">
            <input id="phone" name="phone" type="text" value="" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">手机:</label>
        <div class="controls">
            <input id="mobile" name="mobile" type="text" value="18888888888" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <textarea id="remarks" name="remarks" maxlength="200" class="input-xlarge" rows="3">最高管理员</textarea>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">用户角色:</label>
        <div class="controls">
            <label class="lbl">公司管理员,系统管理员</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">上次登录:</label>
        <div class="controls">
            <label class="lbl">IP: 0:0:0:0:0:0:0:1&nbsp;&nbsp;&nbsp;&nbsp;时间：2018年710月16日 星期一 19:35:28</label>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
    </div>
</form>
</body>
</html>