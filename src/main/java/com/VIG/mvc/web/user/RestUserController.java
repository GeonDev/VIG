
package com.VIG.mvc.web.user;



import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
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







@RequestMapping( value = "json/getUser/{userCode}" , method=RequestMethod.GET)
public User getUser(@PathVariable String userCode) throws Exception{
	System.out.println("json get");
	return userServices.getUserOne(userCode);
}

/*
@RequestMapping( value = "json/getUser/{userName}" , method=RequestMethod.GET)
public List<User> getUserListFromName(@PathVariable("userName") String name) throws Exception{
	
	Search search = new Search();
	search.setKeyword(name);
	System.out.println("jsondata!! : "+name);
	return userServices.getUserListFromName(search);
}
*/
//===================

		@RequestMapping(value="json/emailSend",method=RequestMethod.GET)
		public Map emailSend(@RequestParam("email") String email) throws Exception{
			System.out.println(" ---------------------------------------");
			System.out.println("[ /user/json/emailCheck/"+email+" : GET]");
			System.out.println(" ---------------------------------------");
			
			////email보내는 함수 작성
			
			String verCode = mailSender(email);
			
			System.out.println("\n\n[ "+verCode+" ]\n\n");
			
			Map map = new HashMap();
			map.put("verifCode", verCode);
			
			////리턴 값 설정 해주기.
			return map;
		}
		
		public String mailSender(String email) throws AddressException, MessagingException {
			
			String host = "smtp.gmail.com"; 
			final String username = "bitwin98@gmail.com"; //네이버 아이이디 
			final String password = "winwin98!"; //네이버 비번 
			int port=587; 
			String verCode=RestUserController.getAlphaNumericString();
			String recipient = email; //받는 사람 이메일 주소 
			String subject = "이메일 인증입니다."; //메일 제목 
			String body = " 인증코드\n\t\t"+"[ "+ verCode+" ]"; //메일 내용
			Properties props = System.getProperties(); // 메일 제목, 내용을 담을 properties 만들기. 
			
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", host);
			
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un=username; 
				String pw=password; 
				protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
					return new javax.mail.PasswordAuthentication(un, pw);
					} }); 
			session.setDebug(true); //for debug 
			Message messageContent = new MimeMessage(session); 
			//MimeMessage 
				
				String Uemail = "bitwin98@gmail.com";	
				InternetAddress emailAddr = new InternetAddress(Uemail);
				emailAddr.validate();
				messageContent.setFrom(emailAddr); 
				 // 보내기 
			
				//발신자  이메일 세팅
				messageContent.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자 세팅 
				messageContent.setSubject(subject); //제목 세팅 
				messageContent.setText(body); //내용 세팅
				Transport.send(messageContent);	
			//javax.mail.Transport.send() 이용하는 거임
				System.out.println("메일발송됨??");
			return verCode;
		}
		
		
		@RequestMapping(value="json/duplicationCheck",method=RequestMethod.GET)
		public boolean duplicationCheck(@Param("email") String email) throws Exception{
			System.out.println(" ---------------------------------------");
			System.out.println("[ /user/json/duplicationCheck/"+email+" : GET]");
			System.out.println(" ---------------------------------------");
			
			
			boolean	result = userServices.duplicationCheck(email);
		System.out.println("\n\n\n\n"+result+"\n\n\n");
			return result;
		}
		
			///////////////////////////////////////////랜덤 코드 생성기
			static int randomNumber() {
			int rand = (int) (Math.random() * 899999) + 100000; 
			return rand;	
			}
			
			static String getAlphaNumericString() { 
			
			
			int n = 10; //length of the number
			
			
			// chose a Character random from this String 
			String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			  + "0123456789"
			  + "abcdefghijklmnopqrstuvxyz"; 
			
			// create StringBuffer size of AlphaNumericString 
			StringBuilder sb = new StringBuilder(n); 
			
			for (int i = 0; i < n; i++) { 
			// generate a random number between 
			// 0 to AlphaNumericString variable length 
			int index 
			= (int)(AlphaNumericString.length() 
			* Math.random()); 
			
			// add Character one by one in end of sb 
			sb.append(AlphaNumericString.charAt(index)); 
			}
			return sb.toString(); 
			} 


}
