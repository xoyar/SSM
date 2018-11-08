package com.xoyar.cms.controller;

import com.xoyar.cms.entity.Menu;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.service.MenuService;
import com.xoyar.cms.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class LoginController {

    static Logger logger = Logger.getLogger(LoginController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    /**
     * 登录时根据用户权限，显示对应菜单
     * @return
     */
    @RequestMapping("/home")
    public String home(){

        return "login";
    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(@RequestParam(value = "loginName",required = true) String loginName, String password, Model model, HttpSession session){
        logger.info("登录的用户名是"+loginName);
        if (StringUtils.isNotEmpty(loginName)&&StringUtils.isNotEmpty(password)){
            User user = userService.loginUser(loginName,password);
            if (user!=null){
                logger.info("登陆成功");
//                登录成功后，将user放入session中
                session.setAttribute("user",user);
                return "redirect:/main";
            }else {
                model.addAttribute("loginFlag","请输入正确的账户和密码！");
                return "forward:/WEB-INF/views/login.jsp";
            }
        }else {
            model.addAttribute("loginFlag","请输入账户和密码！");
            return "forward:/WEB-INF/views/login.jsp";
        }
    }

    /**
     * 访问main.jsp
     * @return
     */
    @RequestMapping("/main")
    public String main(HttpSession session,Model model){

        User user = (User) session.getAttribute("user");
        List<Menu> menuList = menuService.getMenuListByUserId(user.getUserId());
        model.addAttribute("menuList",menuList);
        return "main/main";
    }

    /**
     * 登出,销毁session
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "forward:/WEB-INF/views/login.jsp";
    }

    /**
     * 没有权限
     */
    @RequestMapping("/nop")
    public String noPermission(){

        return "main/nopermission";
    }

}
