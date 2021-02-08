package com.vig.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebCinfig implements WebMvcConfigurer {
	
	/* 로그인 인증 Interceptor 설정 */   
	@Autowired   
	private CertificationInterceptor certificationInterceptor;   
   
	@Value("${acceptURL}")
	String acceptURL;
	
	
	@Override   
	public void addInterceptors(InterceptorRegistry registry) {
		
		//addPathPatterns 해당 패턴에 해당하는 URL을 인터럽트한다.
		//excludePathPatterns 해당 패턴에 해당하는 URL은 인터럽트하지 않는다.
		List<String> exceptUrlList = new ArrayList<>(Arrays.asList(acceptURL.split(",")));
				
		//registry.addInterceptor(certificationInterceptor).excludePathPatterns(exceptUrlList);
		
		
	}  

}
