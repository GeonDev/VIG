package com.VIG.mvc.web.test;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;




@Controller
@RequestMapping("/VIG/testController/*")
public class TestController {
	
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Autowired
	private ServletContext context;

	public TestController() {
		// TODO Auto-generated constructor stub
	}	
	
	
	@RequestMapping(value = "trans", method = RequestMethod.POST)
	public void trans() throws Exception {
		
		System.out.println("일단 트랜스에 정상 도착");
	}
	
	
	
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public ModelAndView updatefile(@RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
        String path = context.getRealPath("/");        
        path = path.substring(0,path.indexOf("\\.metadata"));         
        path = path +  uploadPath;  
		
		if(files !=null) {
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File(path+inDate+multipartFile.getOriginalFilename());
	    		
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);	    		
	    	
	    			    	
			} 			
		}
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", "임시기능.");
	}
	
		

}
