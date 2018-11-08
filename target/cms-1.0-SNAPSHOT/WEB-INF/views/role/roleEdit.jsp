<%--
  Created by IntelliJ IDEA.
  User: 赵
  Date: 2018/10/19
  Time: 9:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/include/jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>角色编辑</title>
    <%@include file="/WEB-INF/views/include/header.jsp" %>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit">
    <script type="text/javascript">
        $(document).ready(function(){

            $(function() {
                $("#name").focus();
                $("#roleEditForm").validate({
                    submitHandler: function(form){
                        loading('正在提交，请稍等...');
                        var editFlag = ${editFlag};
                        //获取字典修改后的信息数据,组装成json字符串
                        var formObject = {};
                        var formArray =$("#roleEditForm").serializeArray();
                        $.each(formArray, function(i, item){
                            formObject[item.name]=item.value;
                        });

                        var roleDto = {};
                        roleDto["role"]=formObject;
                        //获取菜单树被选中的节点
                        var menuObj = {};
                        var menuNodes = menuTree.getCheckedNodes(true);
                        $.each(menuNodes, function(i, item){
                            menuObj[item.id]=item.id;
                        });
                        roleDto["menuIds"]=menuObj;

                        console.info(JSON.stringify(roleDto));
                        loading('正在提交，请稍等...');
                        $.ajax({
                            type:'post',//请求方式
                            url:'/role/saveRole',
                            dataType:'json', //返回数据的几种格式 xml html json text 等常用
                            contentType :"application/json;charset=UTF-8",
                            //data传值的另外一种方式 form的序列化
                            //data: {"role":role,"menuIds":menuIds,"deptIds":deptIds,"areaIds":areaIds},//传递给服务器的参数
                            data:JSON.stringify(roleDto),
                            success:function(data){//与服务器交互成功调用的回调函数
                                //后台返回则关掉提示
                                top.$.jBox.closeTip();
                                alert(data.result);
                                //history.go(-1);
                                document.location.href = "/role/roleList";
                            }
                        });
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

            //菜单资源树
            var menuSetting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false},
                data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
                        menuTree.checkNode(node, !node.checked, true, true);
                        return false;
                    }}};

            // 用户-菜单
            var menuZNodes=[
                <c:forEach items="${menuList}" var="menu">
                {
                    id: "${menu.id}",
                    pId: "${menu.parentId}",
                    name: "${menu.name}"
                },
                </c:forEach>
            ];
            // 初始化树结构
            var menuTree = $.fn.zTree.init($("#menuTree"), menuSetting, menuZNodes);
            //进入修改页面的时候 ，选中已经拥有资源的节点
            <c:forEach items="${roleMenuList}" var="roleMenu">
            //在js中使用el表达式需要使用双引号
                var node = menuTree.getNodeByParam("id", "${roleMenu.menuId}");
                menuTree.checkNode(node,true,false);
            </c:forEach>

            //默认展开全部节点
            menuTree.expandAll(true);
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="/role/roleList">角色列表</a></li>
    <li class="active">
        <a href="javascript:void(0);">角色
            <c:choose>
                <c:when test="${editFlag==1}">添加
                </c:when>
                <c:otherwise>修改</c:otherwise>
            </c:choose>
        </a></li>
</ul><br/>
<form id="roleEditForm" class="form-horizontal" action="#" method="post">
    <input id="id" name="id" type="hidden" value="${role.id}"/>
    <div class="control-group">
        <label class="control-label">名称:</label>
        <div class="controls">
            <input id="name" name="name" class="required input-xlarge" type="text" value="${role.name}" maxlength="50"/>
            <span class="help-inline"><span style="color:red">*</span> </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <textarea id="remarks" name="remarks" maxlength="200" class="input-xxlarge" rows="3">${role.remarks}</textarea>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">角色授权:</label>
        <div class="controls">
            <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
            <!-- <div id="deptTree" class="ztree" style="margin-left:50px;margin-top:3px;float:left;"></div>
            <div id="areaTree" class="ztree" style="margin-left:50px;margin-top:3px;float:left;"></div> -->
        </div>
    </div>


    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
</html>