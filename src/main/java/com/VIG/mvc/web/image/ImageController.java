package com.VIG.mvc.web.image;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;


@Controller
@RequestMapping("/imageController/*")
public class ImageController {
	
	
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

	
	public ImageController() {
		// TODO Auto-generated constructor stub		
	}	
	

	@RequestMapping(value = "chatting")
	public ModelAndView chat(@ModelAttribute("user") User user, HttpSession session) throws Exception {		
	
		user.setUserName("temp");
		userServices.addUser(user);
		
		//사용자 정보 세션 삽입				
		session.setAttribute("user", user);
		
		System.out.println("user name :" + user.getUserName());	
				
		return new ModelAndView("forward:/ChattingView.jsp", "userid", user.getUserName());
	}	
	
	
	
	

}
