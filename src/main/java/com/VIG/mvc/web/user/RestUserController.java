package com.VIG.mvc.web.user;

import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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



@RequestMapping(value="json/login", method=RequestMethod.POST)
public User login( @RequestBody User user, HttpSession session) throws Exception{
		System.out.println("json/login");
	User dbUser = userServices.getUserOne(user.getUserCode());
		System.out.println("json/dbUser:"+dbUser);
	if( user.getPassword().equals(dbUser.getPassword())) {
		session.setAttribute("user", dbUser);
	}
	return dbUser;	
}

@RequestMapping( value="json/getCode{userCode}", method=RequestMethod.POST )
public User getCode( @PathVariable String userCode ) throws Exception{
	
	System.out.println("/user/json/getUser : GET");
		return userServices.getCode(userCode);
}

/*
@RequestMapping(value="json/checkId", method=RequestMethod.POST)
public User checkId( @RequestBody User user, HttpSession session) throws Exception{
		System.out.println("json/checkId");
	User dbUser = userServices.getUserOne(user.getUserCode());
		System.out.println("json/dbUser:"+dbUser);
	if( user.getUserCode().equals(user.getUserCode())) {
		session.setAttribute("user", dbUser);
	}
	return dbUser;	
}
*/





@RequestMapping( value = "json/getUser" , method=RequestMethod.POST)
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

//=======이메일 보내기============================================================//

@RequestMapping( value="json/sendEmail", method=RequestMethod.POST )
		public boolean sendEmail(User user) {
			boolean test=false;
			
			String toEmail = user.getEmail(); //받을 이메일 주소
			String fromEmail = "win98@gmail.com"; //보내는 메일 주소
			String ePassword = "win98";
			
			try {
				Properties pr = new Properties();
				pr.put("mail.smtp.auth" , "true");
				pr.put("mail.smtp.starttls.enable" , "true");
				pr.put("mail.smtp.host" , "smtp.gmail.com");
				pr.put("mail.smtp.port" , "587");
				//  maven 추가하기
				Session session = Session.getInstance(pr, new Authenticator() {
					@Override
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(fromEmail, ePassword);
					}
				});		
				Message mess = new MimeMessage(session);
				mess.setFrom(new InternetAddress(fromEmail));
				
				System.out.println("sendEmail: toEmail="+toEmail);
				
				mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
				mess.setSubject("subject"); //메일 제목
				mess.setText("text:"+user.getVariedCode()); //메일 내용+인증 코드
				
				Transport.send(mess);			
				test=true;
				
			} catch (Exception e) {
				e.printStackTrace();
			}		
			return test;
		}

}