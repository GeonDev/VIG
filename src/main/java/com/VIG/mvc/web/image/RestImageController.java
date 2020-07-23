package com.VIG.mvc.web.image;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;


@RestController
@RequestMapping("/imageController/*")
public class RestImageController {
	
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;

	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	

	@Autowired 
	@Qualifier("imageServicesImpl")
	private ImageServices imageServices;
	
	@Autowired 
	@Qualifier("keywordServicesImpl")
	private KeywordServices keywordServices;
	
	@Autowired 
	@Qualifier("colorServicesImpl")
	private ColorServices colorServices;	

	
	public RestImageController() {
		// TODO Auto-generated constructor stub		
	}	
	


	
	
	
	

}
