package com.vig.config;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;
import com.vig.handler.CertificationInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	/* 로그인 인증 Interceptor 설정 */   
	@Autowired   
	private CertificationInterceptor certificationInterceptor;   
   
	@Value("${checkUrlList}")
	String checkUrls;
	
	@Value("${enableUrlList}")
	String enableUrls;
	
	
	@Override   
	public void addInterceptors(InterceptorRegistry registry) {
		
		//addPathPatterns 해당 패턴에 해당하는 URL을 인터럽트한다.
		//excludePathPatterns 해당 패턴에 해당하는 URL은 인터럽트하지 않는다.
		List<String> addUrlList = new ArrayList<>(Arrays.asList(checkUrls.split(",")));
		
		List<String> excludeUrlList = new ArrayList<>(Arrays.asList(enableUrls.split(",")));
				
		registry.addInterceptor(certificationInterceptor).addPathPatterns(addUrlList).excludePathPatterns(excludeUrlList);
		
		
	}
	
	//Lucy Xss filter 적용	
    @Bean
    public FilterRegistrationBean<XssEscapeServletFilter> getFilterRegistrationBean(){
        FilterRegistrationBean<XssEscapeServletFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new XssEscapeServletFilter());
        registrationBean.setOrder(1);
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }
	
 

}
