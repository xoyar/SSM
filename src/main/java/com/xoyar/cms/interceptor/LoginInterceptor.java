package com.xoyar.cms.interceptor;

import com.xoyar.cms.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
//         先获取登录的URI
        String uri = request.getRequestURI();
//         如果uri中包含login或home，不拦截
        if (uri.indexOf("login") >=0 || uri.indexOf("home") >= 0){
            return true;
        }
//        其余需要session验证
        HttpSession session = request.getSession();
//        获取user对象，如果user不等于null，说明登录过
        User user = (User) session.getAttribute("user");
        if (user != null){
            return true;
        }else {
//            将请求重定向到index.jsp
            try {
                request.getRequestDispatcher("/index.jsp").forward(request,response);
            }catch (IOException e){
                e.printStackTrace();
            }catch (ServletException e){
                e.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {

    }
}
