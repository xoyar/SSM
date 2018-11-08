<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/16
  Time: 14:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/include/jstl.jsp"%>
<!DOCTYPE html>
<html style="overflow: hidden;">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CMS内容管理系统</title>
    <%@include file="/WEB-INF/views/include/header.jsp" %>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <style type="text/css">
        #main {
            padding: 0;
            margin: 0;
        }

        #main .container-fluid {
            padding: 0 4px 0 6px;
        }

        #header {
            margin: 0 0 8px;
            position: static;
        }

        #header li {
            font-size: 14px;
            _font-size: 12px;
        }

        #header .brand {
            font-family: Helvetica, Georgia, Arial, sans-serif, 黑体;
            font-size: 26px;
            padding-left: 33px;
        }

        #footer {
            margin: 8px 0 0 0;
            padding: 3px 0 0 0;
            font-size: 11px;
            text-align: center;
            border-top: 2px solid #0663A2;
        }

        #footer, #footer a {
            color: #999;
        }

        #left {
            overflow-x: hidden;
            overflow-y: auto;
        }

        #left .collapse {
            position: static;
        }

        #userControl>li>a { /*color:#fff;*/
            text-shadow: none;
        }

        #userControl>li>a:hover, #user #userControl>li.open>a {
            background: transparent;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {

            // 绑定菜单单击事件
            $("#menu a.menu").click(function(){
                // 一级菜单焦点
                $("#menu li.menu").removeClass("active");
                $(this).parent().addClass("active");
                // 左侧区域隐藏
                if ($(this).attr("target") == "mainFrame"){
                    $("#left,#openClose").hide();
                    wSizeWidth();
                    return true;
                }
                // 左侧区域显示
                $("#left,#openClose").show();
                if(!$("#openClose").hasClass("close")){
                    $("#openClose").click();
                }
                // 显示二级菜单
                var menuId = "#menu-" + $(this).attr("data-id");
                if ($(menuId).length > 0){
                    $("#left .accordion").hide();
                    $(menuId).show();
                    // 初始化点击第一个二级菜单
                    if (!$(menuId + " .accordion-body:first").hasClass('in')){
                        $(menuId + " .accordion-heading:first a").click();
                    }
                    if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")){
                        $(menuId + " .accordion-body a:first i").click();
                    }
                    // 初始化点击第一个三级菜单
                    $(menuId + " .accordion-body li:first li:first a:first i").click();
                }else{
                    // 获取二级菜单数据
                    $.get($(this).attr("data-href"), function(data){
                        if (data.indexOf("id=\"loginForm\"") != -1){
                            alert('未登录或登录超时。请重新登录，谢谢！');
                            top.location = "";
                            return false;
                        }
                        $("#left .accordion").hide();
                        $("#left").append(data);
                        // 链接去掉虚框
                        $(menuId + " a").bind("focus",function() {
                            if(this.blur) {this.blur()};
                        });
                        // 二级标题
                        $(menuId + " .accordion-heading a").click(function(){
                            $(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
                            if(!$($(this).attr('data-href')).hasClass('in')){
                                $(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
                            }
                        });
                        // 二级内容
                        $(menuId + " .accordion-body a").click(function(){
                            $(menuId + " li").removeClass("active");
                            $(menuId + " li i").removeClass("icon-white");
                            $(this).parent().addClass("active");
                            $(this).children("i").addClass("icon-white");
                        });
                        // 展现三级
                        $(menuId + " .accordion-inner a").click(function(){
                            var href = $(this).attr("data-href");
                            if($(href).length > 0){
                                $(href).toggle().parent().toggle();
                                return false;
                            }

                        });
                        // 默认选中第一个菜单
                        $(menuId + " .accordion-body a:first i").click();
                        $(menuId + " .accordion-body li:first li:first a:first i").click();
                    });
                }
                // 大小宽度调整
                wSizeWidth();
                return false;
            });
            // 初始化点击第一个一级菜单
            $("#menu a.menu:first span").click();

            // 鼠标移动到边界自动弹出左侧菜单
            $("#openClose").mouseover(function(){
                if($(this).hasClass("open")){
                    $(this).click();
                }
            });

        });

    </script>
</head>
<body>
<div id="main" style="width: auto;">
    <div id="header" class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="brand">
                <span id="productName">CMS内容管理系统</span>
            </div>
            <%--右侧菜单静态--%>
            <ul id="userControl" class="nav pull-right">
                <li id="userInfo" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好, &nbsp;  ${ user.userName } &nbsp;</a>
                    <ul class="dropdown-menu">
                        <li><a href="/user/userInfo" target="mainFrame"><i
                                class="icon-user"></i>&nbsp; 个人信息</a></li>
                        <li><a href="/user/updatepwd" target="mainFrame"><i
                                class="icon-lock"></i>&nbsp; 修改密码</a></li>
                    </ul></li>
                <li><a href="/logout" title="退出登录">退出</a></li>
                <li>&nbsp;</li>
            </ul>
        </div>
    </div>

    <%--左侧菜单改为动态菜单--%>
    <div class="container-fluid">
        <div id="content" class="row-fluid">

            <!-- begin -->
            <div id="left" style="width: 160px; height: 604px;">
                <div class="accordion" id = "menu-all">

                    <%--parentId=1 : 一级菜单 代表父级菜单为系统设置和个人信息--%>
                    <c:set var="parentId" value="1" />
                    <%--获取此用户所属角色能控制的菜单信息menuList--%>
                    <c:set var="menuList" value="${menuList}" />
                    <c:set var="first" value="true" />


                    <c:forEach items="${menuList}" var="menu">
                        <c:if test="${menu.parentId eq parentId && menu.isShow eq '1'}" >
                            <%-- 此div模块代表一级菜单 --%>
                            <div class="accordion-group">
                                <div class="accordion-heading">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#menu-all"
                                       data-href="#collapse-${menu.id}" href="#collapse-${menu.id}" title="${menu.remarks}">
                                        <i class="icon-chevron-${first ? 'down' : 'right'}"></i>&nbsp;${menu.name}
                                    </a>
                                </div>
                                <div id="collapse-${menu.id}" class="accordion-body ${first ? 'in' : ''} collapse">
                                    <div class="accordion-inner">
                                        <ul class="nav nav-list">

                                            <c:forEach items="${menuList}" var="menu2" >
                                                <c:if test="${menu2.parentId eq menu.id && menu2.isShow eq '1'}">
                                                    <%-- 此模块代表二级菜单 --%>
                                                    <li>
                                                        <a data-href=".menu3-${menu2.id}" href="${ctx}${menu2.href}"
                                                           target="${empty menu2.target ? 'mainFrame' : menu2.target}">
                                                            <i class="icon-${menu2.icon}"></i>&nbsp;${menu2.name}
                                                        </a>
                                                        <%-- 此模块代表三级菜单 --%>
                                                        <ul class="nav nav-list hide" style="margin:0;padding-right:0;">
                                                            <c:forEach items="${menuList}" var="menu3">
                                                                <c:if test="${menu3.parentId eq menu2.id && menu3.isShow eq '1'}">
                                                                    <li class="menu3-${menu3.id} hide">
                                                                        <a data-href=".menu3-${menu3.id}" href="${menu3.href}"
                                                                           target="${empty menu3.target ? 'mainFrame' : menu3.target}">
                                                                            <i class="icon-${menu3.icon}"></i>&nbsp;${menu3.name}
                                                                        </a>
                                                                    </li>
                                                                </c:if>
                                                            </c:forEach>
                                                        </ul>
                                                    </li>
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                                <c:set var="first" value="false" />
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

            </div>
            <!-- end -->

            <div id="openClose" class="close" style="height: 599px;">&nbsp;</div>
            <div id="right" style="height: 604px; width: 1243px;">
                <iframe id="mainFrame" name="mainFrame" src=""
                        style="overflow: visible; height: 604px;" scrolling="yes"
                        frameborder="no" width="100%" height="650"></iframe>
            </div>
        </div>
        <div id="footer" class="row-fluid">
            Copyright © 2015-2015 <a href="http://www.tanzhouedu.com/"
                                     target="_blank">CMS内容管理系统</a> - Powered By tz.java v1.0
        </div>
    </div>
</div>
<script type="text/javascript">
    var leftWidth = 160; // 左侧窗口大小
    var tabTitleHeight = 33; // 页签的高度
    var htmlObj = $("html"), mainObj = $("#main");
    var headerObj = $("#header"), footerObj = $("#footer");
    var frameObj = $("#left, #openClose, #right, #right iframe");
    function wSize() {
        var minHeight = 500, minWidth = 980;
        var strs = getWindowSize().toString().split(",");
        htmlObj.css({
            "overflow-x" : strs[1] < minWidth ? "auto" : "hidden",
            "overflow-y" : strs[0] < minHeight ? "auto" : "hidden"
        });
        mainObj.css("width", strs[1] < minWidth ? minWidth - 10 : "auto");
        frameObj.height((strs[0] < minHeight ? minHeight : strs[0])
            - headerObj.height() - footerObj.height()
            - (strs[1] < minWidth ? 42 : 28));
        $("#openClose").height($("#openClose").height() - 5);
        wSizeWidth();
    }
    function wSizeWidth() {
        if (!$("#openClose").is(":hidden")) {
            var leftWidth = ($("#left").width() < 0 ? 0 : $("#left")
                .width());
            $("#right").width(
                $("#content").width() - leftWidth
                - $("#openClose").width() - 5);
        } else {
            $("#right").width("100%");
        }
    }
</script>
<script src="${ctxJsAndCss}/common/wsize.min.js" type="text/javascript"></script>
