package com.VIG.mvc.web.user;

import java.util.Properties;
import java.util.Random;


import javax.servlet.http.HttpSession;

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
		userServices.addUser(user);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/main/main.jsp");
		
		return modelAndView;
	}

//=======로그인===============================================================//
	
	@RequestMapping( value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{
		
		System.out.println("login(GET):로그인 페이지로 이동");
		
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/user/loginView.jsp");		
		return model;
	}
	
	public String login(User user, HttpSession session) throws Exception{
		
		System.out.println("login(POST):로그인");
		
		User dbUser = userServices.getUserOne(user.getUserCode());
		if( user.getPassword().equals(dbUser.getPassword())) {
			session.setAttribute("user", dbUser);
		}	
		return "redirect:/main/main.jsp";
	}

//=======이메일 보내기============================================================//
	
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
		/*	//  maven 추가하기
			Session session = Session.getInstance(pr, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, password);
				}
			});		
			Message mes = new Message(session);
			mes.setFrom(new InternetAddress(fromEmail));
			
			System.out.println("sendEmail: toEmail="+toEmail);
			
			mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
			mess.setSubject("subject"); //메일 제목
			mess.setText("text:"+user.getCode()); //메일 내용+인증 코드
			
			Transport.send(mess);			
			test=true;
		*/	
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return test;
	}

//=======인증코드생성===========================================================//
	
	public String getRandom() {
		Random rnd = new Random();
		int number = rnd.nextInt(999999);			
		System.out.println("number="+number);
		
		return String.format("%06d", number);		
	}
	
}
