package com.xoyar.cms.controller;

import com.xoyar.cms.annotation.Permission;
import com.xoyar.cms.dto.RoleDto;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.Menu;
import com.xoyar.cms.entity.Role;
import com.xoyar.cms.entity.RoleToMenu;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.service.MenuService;
import com.xoyar.cms.service.RoleService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.swing.text.StyledEditorKit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("role")
public class RoleController {

    static Logger logger = Logger.getLogger(RoleController.class);

    @Autowired
    private RoleService roleService;
    @Autowired
    private MenuService menuService;

    /**
     * 角色列表
     * @param model
     * @return
     */
    @Permission(value = "role:list")
    @RequestMapping("/roleList")
    public String roleList(Model model){

        List<Role> list =  roleService.getAllRoleList();
        model.addAttribute("roleList",list);
        return "/role/roleList";
    }


    /**
     * ModelAttribute提前获取editFlag，判断进入编辑还是修改页面
     * 从model、url和form表单中获取，这里用的是从url中获取值
     * @param editFlag
     * @return
     */
    @Permission(value = "role:update")
    @RequestMapping("/gotoRoleEdit")
    public String gotoRoleEdit(@ModelAttribute("editFlag") int editFlag,Integer roleId,Model model){
        //无论是添加还是修改角色，都需要获取全部菜单列表
        List<Menu> menus = menuService.getAllMenuList();
        model.addAttribute("menuList",menus);
        //如果是修改角色，那么首先获取此角色可以操作的菜单信息
        if (editFlag == 2){
            List<RoleToMenu> roleMenuList = roleService.getMenuListByRoleId(roleId);
            model.addAttribute("roleMenuList",roleMenuList);

            Role role = roleService.getRoleById(roleId);
            model.addAttribute("role",role);
        }
        return "role/roleEdit";
    }

    /**
     * Responsebody 注解表示该方法的返回的结果直接写入 HTTP 响应正文（ResponseBody）中，
     * 一般在异步获取数据时使用，通常是在使用 @RequestMapping 后，返回值通常解析为跳转路径，
     * 加上 @Responsebody 后返回结果不会被解析为跳转路径，而是直接写入HTTP 响应正文中
     * **使用时机：
     * 返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；
     * @param roleDto
     * @param session
     * session 通过session.getAttribute获取user对象，进而获取userId，设置修改人
     */
    @Permission(value = "role:update")
    @RequestMapping("/saveRole")
    @ResponseBody
    public Map<String,Object> saveRole(@RequestBody RoleDto roleDto, HttpSession session){
        //requestBody : 将ajax（datas）发出的请求写入 User 对象中,对上面注解
        //resultMap仅仅是用来返回添加或修改成功失败的反馈
        Map<String,Object> resultMap = new HashMap<>();

        User userSession = (User)session.getAttribute("user");
        UpdateUser updateUser = new UpdateUser();
        updateUser.setUpdateBy(userSession.getUserId().toString());
        updateUser.setUpdateDate(new Date());
        try {
            //判断是添加还是修改
            if (roleDto != null && roleDto.getRole()!=null && roleDto.getRole().getId()!=null){
                roleService.updateRole(roleDto,updateUser);
                resultMap.put("result","修改角色成功");
            }else {
                roleService.addRole(roleDto,updateUser);
                resultMap.put("result","添加角色成功");
            }
        }catch (Exception e){
            resultMap.put("result","添加角色失败");
        }
        // 这样就不会再被解析为跳转路径，而是直接将user对象写入 HTTP 响应正文中
        return resultMap;
    }


}
