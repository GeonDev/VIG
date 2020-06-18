package com.VIG.mvc.web.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/VIG/testController/*")
public class TestController {

	public TestController() {
		// TODO Auto-generated constructor stub
	}	
	
	
	@RequestMapping(value = "trans", method = RequestMethod.POST)
	public void trans() throws Exception {
		
		System.out.println("일단 트랜스에 정상 도착");
	}
	
	
	
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public void updatefile() throws Exception {
		
		System.out.println("일단 업로드에 정상 도착");
	}
	
		

}
