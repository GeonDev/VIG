package com.vig;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@MapperScan(basePackageClasses = VigApplication.class)
@SpringBootApplication
@PropertySource("classpath:common.properties")
public class VigApplication {
	
	
	public static void main(String[] args) {
		SpringApplication.run(VigApplication.class, args);
	}

}
