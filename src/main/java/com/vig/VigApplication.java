package com.vig;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableAspectJAutoProxy
@EnableScheduling
@SpringBootApplication
@PropertySource("classpath:common.properties")
public class VigApplication {
	
	
	public static void main(String[] args) {
		SpringApplication.run(VigApplication.class, args);
	}

}
