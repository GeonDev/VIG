package com.VIG.mvc.web.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.user.UserServices;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
	public UserController() {
		// TODO Auto-generated constructor stub
	}
	
//=========회원가입===========================================================//
	@RequestMapping(value="addUser", method=RequestMethod.GET)
	public ModelAndView addUser() throws Exception{
		
		System.out.println("addUser(GET):회원가입 페이지로 이동");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/user/addUserView.jsp");
		
		return modelAndView;
	}
/*
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		userServices.addUser(user);
		System.out.println("addUser(POST):"+user);
		
		return "redirect:/index.jsp";
	}
*/	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public ModelAndView addUser( User user ) throws Exception {
		
		System.out.println("addUser(POST):회원가입");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/index.jsp");
		
		return modelAndView;
	}
//==========================================================================//

//=======로그인===============================================================//
	
	
}
