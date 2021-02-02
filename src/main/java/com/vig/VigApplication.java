package com.vig;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(basePackageClasses = VigApplication.class)
@SpringBootApplication
public class VigApplication {

	public static void main(String[] args) {
		SpringApplication.run(VigApplication.class, args);
	}

}
