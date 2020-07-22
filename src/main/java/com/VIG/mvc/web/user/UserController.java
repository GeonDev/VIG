package com.VIG.mvc.web.user;

import java.util.Properties;
import java.util.Random;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
		System.out.println(this.getClass());
	}
	
//=========회원가입===========================================================//
	
	@RequestMapping(value="addUser", method=RequestMethod.GET)
	public ModelAndView addUser() throws Exception{
		
		System.out.println("addUser(GET):회원가입 페이지로 이동");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/user/addUserView.jsp");
		
		return modelAndView;
	}
		
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser(@ModelAttribute("user") User user ) throws Exception {
		
		System.out.println("addUser(POST):회원가입"+user);
		userServices.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}

//=======로그인===============================================================//
	
	@RequestMapping( value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{
		
		System.out.println("login(GET):로그인 페이지로 이동");
		
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/user/loginView.jsp");		
		return model;
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception{
		
		System.out.println("login(POST):로그인");
		
		User dbUser = userServices.getUserOne(user.getUserCode());
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:../main/main.jsp");
		System.out.println("user:"+user);

		if( user.getPassword().equals(dbUser.getPassword())) {
			session.setAttribute("user", dbUser);
			}	
		return model;
		}	
	
//=======로그아웃===============================================================//
	@RequestMapping( value="logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session) throws Exception{
		System.out.println("logout");
		session.invalidate();
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:../main/main.jsp");
		return model;
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
	
	
//=======get user===========================================================//
	
	public String GetUser(@RequestParam("userCode") String userCode, Model model)throws Exception{
		System.out.println("get user");
		User user = userServices.getUserOne(userCode);
		System.out.println("get/user:"+user);
		model.addAttribute("user", user);
		return "forward:main/main.jsp";
	}
	
	
	@RequestMapping("/loginModal")
	public String loginModal() {
		System.out.println("모달띄우기 나오나요");
		return "VIG/user/loginView.jsp";
	}
}
