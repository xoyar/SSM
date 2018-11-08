package com.xoyar.cms.interceptor;

import com.xoyar.cms.annotation.Permission;
import com.xoyar.cms.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class PermissionHandlerInterceptor implements HandlerInterceptor {

    @Autowired
    private WebUtils webUtils;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {


//        HandlerMethod method = (HandlerMethod) handler;
//        //获取方法注解@Permission的值，如menu：add
//        Permission permission = method.getMethodAnnotation(Permission.class);

        //获取方法注解@Permission的值，如menu：add
        Permission permission = null;
        if(handler instanceof HandlerMethod){
            permission = ((HandlerMethod)handler).getMethodAnnotation(Permission.class);
        }
        //进行权限判断
        if (permission == null){
            return true;
        }
        System.out.println("permission : "+permission.value());

        //验证权限
        if (!webUtils.hasPower(request,permission.value())){
            try {
                response.sendRedirect(request.getContextPath()+"/nop");
            }catch (IOException e){
                e.printStackTrace();
            }
            return false;
        }else {
            return true;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {

    }
}
