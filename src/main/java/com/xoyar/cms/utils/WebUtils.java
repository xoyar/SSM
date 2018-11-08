package com.xoyar.cms.utils;

import com.xoyar.cms.entity.Menu;
import com.xoyar.cms.entity.User;
import com.xoyar.cms.service.MenuService;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Component
public class WebUtils {

    @Autowired
    private MenuService menuService;

    public boolean hasPower(HttpServletRequest request,String permission){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        //获取用户有权限操作的菜单列表
        List<Menu> mlist = menuService.getMenuListByUserId(user.getUserId());
        for (Menu menu:mlist){
            //判断菜单权限是否为空
            if (!isEmpty(menu.getPermission())){
                System.out.println("Menu Permission : "+menu.getPermission());
                //如果拦截器传入的权限（拦截器是获取@Permission的权限）与获取到权限列表中的某个权限相同，返回true
                if (menu.getPermission().equals(permission)){
                    return true;
                }
            }
        }
        return false;
    }

    private static boolean isEmpty(String str){
        if (str == null || str == ""){
            return true;
        }
        return false;
    }
}
