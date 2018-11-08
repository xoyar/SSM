<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/16
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/include/jstl.jsp"%>
<!DOCTYPE html>
<!-- saved from url=(0075)http://localhost:8080/login;JSESSIONID=8c063142-ef1d-4b1d-ab15-fb0ecf1e6488 -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CMS内容管理系统 登录</title>
    <%@include file="/WEB-INF/views/include/header.jsp"%>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">

    <style type="text/css">
        html,body,table{background-color:#f5f5f5;width:100%;text-align:center;}
        .form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;margin-bottom:20px;color:#0663a2;}
        .form-signin{position:relative;text-align:left;width:300px;padding:25px 29px 29px;margin:0 auto 20px;background-color:#fff;border:1px solid #e5e5e5;
            -webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
        .form-signin .checkbox{margin-bottom:10px;color:#0663a2;} .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
        .form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
        .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
        .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
        .header{height:80px;padding-top:20px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
        label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#loginForm").validate({
                messages: {
                    loginName: {required: "请填写用户名."},
                    password: {required: "请填写密码."}
                },
                errorLabelContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    error.appendTo($("#loginError").parent());
                }
            });
        });
        // 如果在框架或在对话框中，则弹出提示并跳转到首页
        if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
            alert('未登录或登录超时。请重新登录，谢谢！');
            top.location = "";
        }
    </script>
</head>
<body>
<!--[if lte IE 6]>
<br/>
<div class='alert alert-block' style="text-align:left;padding-bottom:10px;">
    <a class="close" data-dismiss="alert">x</a>
    <h4>温馨提示：</h4>
    <p>你使用的浏览器版本过低。为了获得更好的浏览体验，强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a>
        到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p>
</div>
<![endif]-->
<div class="header">
    <div id="messageBox" class="alert alert-error hide">
        <button data-dismiss="alert" class="close">×</button>
        <label id="loginError" class="error"></label>
    </div>

    <div id="messageBoxLogin" class="alert alert-error ${empty loginFlag ? 'hide' : ''}">
        <button data-dismiss="alert" class="close">×</button>
        <label id="loginErrorCus" class="error">${loginFlag}</label>
    </div>
</div>

<h1 class="form-signin-heading">CMS内容管理系统</h1>
<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
    <label class="input-label" for="loginName">登录名</label>
    <input type="text" id="loginName" name="loginName" class="input-block-level required" value="">
    <label class="input-label" for="password">密码</label>
    <input type="password" id="password" name="password" class="input-block-level required">
    <input class="btn btn-large btn-primary" type="submit" value="登 录">&nbsp;&nbsp;
    <label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe"> 记住我</label>
</form>

<div class="footer">
    Copyright © 2018.10.14-2018 <a href="http://www.google.com/" target="_blank">CMS内容管理系统</a> - Powered By Xoyar V0.0.1
</div>

