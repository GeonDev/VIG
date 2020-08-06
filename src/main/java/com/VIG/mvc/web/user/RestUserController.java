package com.VIG.mvc.web.user;



import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.user.UserServices;
	@RestController
	@RequestMapping("/user/*")
public class RestUserController {

	@Autowired
	@Qualifier("userServicesImpl")
private UserServices userServices;


public RestUserController() {
	}


/*
@RequestMapping(value="/json/login", method=RequestMethod.POST)

public User login( @RequestBody User user, HttpSession session) throws Exception{
		System.out.println("json/login");
	User dbUser = userServices.getUserOne(user.getUserCode());
		System.out.println("json/dbUser:"+dbUser);
	if( user.getPassword().equals(dbUser.getPassword())) {
		session.setAttribute("user", dbUser);
	}
	return dbUser;	
}
*/



@RequestMapping( value="json/checkDuplication", method=RequestMethod.POST)
@ResponseBody
public boolean checkDuplication( @RequestParam ("userCode") String userCode ) throws Exception{			
	
	return userServices.checkDuplication(userCode);	
}




//================================================================탈퇴시 비번 확인 //    ajax 테스트 중 ㅠㅠ
/*
@RequestMapping( value="json/checkPw", method=RequestMethod.POST)
@ResponseBody
public boolean checkPw( @RequestParam ("password") String password ) throws Exception{			
	
	return userServices.checkDuplication(password);	
}
*/


/*
@RequestMapping( value="/json/login", method=RequestMethod.POST )
@ResponseBody
public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception{
	
		User dbUser = userServices.getUserOne(user.getUserCode());
				
		if (BCrypt.checkpw(user.getPassword(), dbUser.getPassword())){	
		session.setAttribute("user", dbUser);
		System.out.println("dbUser:"+dbUser);
		System.out.println(session.getAttribute("user"));
		return "id,pw=ok";
		}else {
			return "check your ID or password";
		}
}
*/

@RequestMapping(value="/json/login", method=RequestMethod.POST)
@ResponseBody
public User loginCheck( @RequestBody User user, HttpSession session) throws Exception{
		System.out.println("json/login");
	User dbUser = userServices.getUserOne(user.getUserCode());
		System.out.println("json/dbUser:"+dbUser);
		if (BCrypt.checkpw(user.getPassword(), dbUser.getPassword())) {
		session.setAttribute("user", dbUser);
	}
	return dbUser;	
}
			


///// json TEst용//*
/*@RequestMapping(value="json/jsonTest", method=RequestMethod.POST)
@ResponseBody
public String simpleWithObject(User user) {
    //필요한 로직 처리
    return user.getUserCode();
}
*/
//////=============================================================================







@RequestMapping( value = "json/getUser{userCode}" , method=RequestMethod.POST)
public User getUser(@PathVariable String userCode) throws Exception{
	System.out.println("json get");
	return userServices.getUserOne(userCode);
}

@RequestMapping( value = "json/getUser/{userName}" , method=RequestMethod.GET)
public List<User> getUserListFromName(@PathVariable("userName") String name) throws Exception{
	
	Search search = new Search();
	search.setKeyword(name);
	System.out.println("jsondata!! : "+name);
	return userServices.getUserListFromName(search);
}

//===================

}
