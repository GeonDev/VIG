package com.vig.handler;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.User;

/**
 * 
 * @content 로그인이 필요한 화면 인터셉트 수행 
 * @author kada
 * 
 * */
@Component
public class CertificationInterceptor implements HandlerInterceptor{
	
	
	@Value("${requireURLAdmin}")
	private String requireAdmin;
	
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	
    	List<String> urlList = new ArrayList<>(Arrays.asList(requireAdmin.split(",")));    	
    	String uri = request.getRequestURI();
    	
        HttpSession session = request.getSession();
        User loginVO = (User) session.getAttribute("user");
 
        if(ObjectUtils.isEmpty(loginVO)){
            response.sendRedirect("/checkLogin");
         
            return false;
        }else{
        	session.setMaxInactiveInterval(30*60);
        	
        	if(urlList.contains(uri)) {
        		if(!loginVO.getRole().equals("admin")) {
        			response.sendRedirect("/checkAdmin");
        			return false;
        		}
        	} 
            
            return true;
        }
        
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub
        
    }

}
