package com.VIG.mvc.web.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.user.UserServices;
	@RestController
	@RequestMapping("/user/*")
public class RestUserController {

	@Autowired
	@Qualifier("userServicesImpl")
private UserServices userServices;

public RestUserController() {
	System.out.println("REST CON");		
	}

@RequestMapping(value="json/login", method=RequestMethod.POST)
public User login( @RequestBody User user, HttpSession session) throws Exception{
	System.out.println("json/login");
	User dbUser = userServices.getUserOne(user.getUserCode());
	System.out.println("json/dbUser:"+dbUser);
	if( user.getPassword().equals(user.getPassword())) {
		session.setAttribute("user", dbUser);
	}
	return dbUser;	
}

@RequestMapping( value = "json/getUser/{userCode}" , method=RequestMethod.GET)
public User getUser(@PathVariable String userCode) throws Exception{
	System.out.println("json get");
	return userServices.getUserOne(userCode);
}

}
