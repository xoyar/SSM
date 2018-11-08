package com.xoyar.cms.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.xoyar.cms.annotation.Permission;
import com.xoyar.cms.dto.UpdateUser;
import com.xoyar.cms.entity.Role;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.entity.UserToRole;
import com.xoyar.cms.service.RoleService;
import com.xoyar.cms.service.UserService;
import com.xoyar.cms.utils.MD5Utils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UserController {
    static Logger logger = Logger.getLogger(UserController.class);
    private static final Integer PAGE_SIZE = 10;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    /**
     * 通过Id获取user
     * @param id
     * @return
     */
    @RequestMapping("/user/{id}")
    @ResponseBody
    public User getUserById(@PathVariable("id") Integer id){

        return userService.getUserById(id);
    }

    /**
     *  用户信息
     * @return
     */
    @RequestMapping("/userInfo")
    public String userInfo(){

        return "main/userInfo";
    }

    /**
     * 检查登录名是否重复
     * 用Jquery-validate验证时，必须是@ResponseBody，返回true和false
     * flase:表示数据库中已存在相同的登录名
     * true：表示数据库中没有相同的登录名
     * @return
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public boolean checkUser(String loginName){
        logger.info("检查登录名是否重复"+loginName);
        User user = userService.checkUser(loginName);
        if (user != null){
            return false;
        }else {
            return true;
        }

    }
    /**
     * 跳到修改密码
     * @return
     */
    @RequestMapping("/updatepwd")
    public String updatepwd(User user){

        return "main/updatepwd";
    }


    /**
     * 修改密码
     */
    @RequestMapping(value="/changePwd", method=RequestMethod.POST)
    public String changePwd(String oldPassword, String newPassword,
                            HttpSession session, Map<String, Object> map){
        User user = (User) session.getAttribute("user");
        logger.info("用户修改密码 " + newPassword);
        if(!user.getPassword().equals(MD5Utils.getMD5Str(oldPassword))){
            map.put("errorFlag", "修改密码失败，原密码错误");
            return "main/updatepwd";
        }else{
            user.setPassword(MD5Utils.getMD5Str(newPassword));
            userService.updateUserPassword(user.getUserId(), MD5Utils.getMD5Str(newPassword));
            map.put("errorFlag", "修改密码成功");
            return "main/updatepwd";
        }
    }

    /**
     * 跳转到用户列表页,使用分页pageHelper
     */
    @Permission("user:list")
    @RequestMapping("/toUserList/{currPage}")
    public String toUserList(@PathVariable("currPage") Integer currPage, Map<String,Object> map){
        logger.info("用户列表");
        //调用userService的分页功能，并将获得的数据用Map传回页面
        PageInfo<User> pageUser = userService.getUserPage(currPage,PAGE_SIZE);
//        员工的列表数据
        map.put("userList",pageUser.getList());
//        当前页
        map.put("currPage",currPage);
//        总页数
        map.put("totalPage",pageUser.getPages());
        return "user/userList";
    }

    /**
     * 跳转到用户添加或修改
     */
    @Permission(value = "user:update")
    @RequestMapping("/toUserAdd/{userId}")
    public String userAdd(@PathVariable("userId") Integer userId,Map<String,Object> map){

        List<Role> roleList = roleService.getAllRoleList();
        map.put("roleList",roleList);

        if (userId == 0||userId == null){
            return "user/userAdd";
        }else {
            logger.info("来到修改用户界面  " + userId);
            User user = userService.getUserById(userId);
            map.put("user",user);
            //获取此用户拥有的角色信息
            List<UserToRole> userRoleList = userService.getUserRoleByUserId(userId);
            if (userRoleList!=null){
                // 将此用户的userId,roleId放到hashMap中，再put到页面上
                Map<Integer,Integer> roleCheckMap = new HashMap<>();
                for (UserToRole userRole : userRoleList){
                    roleCheckMap.put(userRole.getUserId(),userRole.getRoleId());
                }
                map.put("roleCheckMap",roleCheckMap);
            }
            return "user/userEdit";
        }

    }

    /**
     * 用户修改/user/updateUser
     */
    @Permission(value = "user:update")
    @RequestMapping(value = "/updateUser",method = RequestMethod.POST)
    public String updateUser(User user,HttpSession session){
        User userSession = (User)session.getAttribute("user");
//         改变修改人和修改时间
        UpdateUser updateUser = new UpdateUser();
        updateUser.setUpdateBy(userSession.getUserId().toString());
        updateUser.setUpdateDate(new Date());
        user.setUpdateBy(userSession.getUserId().toString());
        user.setUpdateDate(new Date());
        System.out.println("进入userController，未进去userService，并且updateUser里面的password获取到了吗="+user.getPassword());
        userService.updateUser(user,updateUser);

        return "redirect:/user/toUserList/1";
    }
    /**
     * 用户添加
     */
    @Permission(value = "user:add")
    @RequestMapping(value = "/addUser" ,method = RequestMethod.POST)
    public String addUser(User user,HttpSession session){
        logger.info("添加用户");
        //获取前台传输的user对象取名userSession
        User userSession = (User) session.getAttribute("user");
        UpdateUser updateUser = new UpdateUser();
        //用updateUser将数据传输到后台
        updateUser.setUpdateBy(userSession.getUserId().toString());
        updateUser.setUpdateDate(new Date());
        //**由于前台不会直接传递修改者和修改时间**需要建立数据传输对象进行获取**
        userService.addUser(user,updateUser);
        return "redirect:/user/toUserList/1";
    }

    /**
     * 软删除用户
     */
    @Permission(value = "user:delete")
    @RequestMapping("/delUser/{userId}/{currPage}")
    public String delUser(@PathVariable("userId") Integer userId, @PathVariable("currPage") Integer currPage){
        logger.info("删除用户");
        userService.updateDelFlag(userId);
        return "redirect:/user/toUserList/"+currPage;
    }

}
