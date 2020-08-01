package com.VIG.mvc.web.user;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.user.UserServices;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
	public UserController() {
	}
	
//=========회원가입===========================================================//    코드 정리하기!
	
	@RequestMapping(value="addUserView", method=RequestMethod.GET)
	public ModelAndView addUser() throws Exception{		
		System.out.println("addUser(GET):회원가입 페이지로 이동");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/user/addUserView.jsp");	
		return modelAndView;
	}

	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser(@ModelAttribute("user") User user, HttpSession session ) throws Exception {
		
		user.setBirth(user.getBirth().replaceAll("-", ""));
		System.out.println("addUser(POST):회원가입");
		
		String pwdBycrypt = passwordEncoder.encode(user.getPassword());
	    user.setPassword(pwdBycrypt);
		userServices.addUser(user);		
		//User userInfo = userServices.getUserOne(user.getUserCode());
		session.setAttribute("userInfo", userServices.getUserOne(user.getUserCode()));
		System.out.println(pwdBycrypt);
		return "redirect:/main/VIG";
	}
			
//====id 체크 =====
	
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userCode") String userCode , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userServices.checkDuplication(userCode);
		// Model 과 View 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userCode", userCode);

		return "forward:/user/checkDuplication.jsp";
	}

//=======로그인===============================================================//
		
	@RequestMapping( value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{		
		System.out.println("login(GET):로그인 페이지로 이동");	
		ModelAndView model = new ModelAndView();
		model.setViewName("forward:../user/loginView.jsp");		
		return model;
	}
	

	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user, HttpSession session ) throws Exception{
		
			User dbUser = userServices.getUserOne(user.getUserCode());
		
		if(dbUser == null) {
			System.out.println("1");
			return "redirect:/user/loginView.jsp";
			
		} else if (BCrypt.checkpw(user.getPassword(), dbUser.getPassword())){	
			dbUser.setPassword(null);
			session.setAttribute("user", dbUser);
			System.out.println("2");
			return "redirect:/main/VIG";
		} else {
			System.out.println("3");
			return "redirect:/user/loginView.jsp";
		}
	}


//=======로그아웃===============================================================//
	@RequestMapping( value="logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session) throws Exception{
			
			System.out.println("logout");
			session.invalidate();
			
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/main/VIG");
		return model;
	}

	
//=======get user===========================================================//
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser(@RequestParam("userCode") String userCode, Model model)throws Exception{
		System.out.println("get user");
		User user = userServices.getUserOne(userCode);
		model.addAttribute("user", user);
		return "forward:../main/main.jsp";
	}
	

	//=============업데이트 유저
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser(@RequestParam("uesrCode") String userCode, Model model)throws Exception{ 
		System.out.println("/user/updateUser : GEt");
		User user = userServices.getUserOne(userCode);
		model.addAttribute("user",user);
		return "forward:/user/updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser(@ModelAttribute("uesr") User user, Model model, HttpSession session )throws Exception{ 
		System.out.println("/user/updateUser : POST");
			
		userServices.updateUser(user);	
		
		String sessionId=((User)session.getAttribute("user")).getUserCode();
		System.out.println(sessionId);
		if(sessionId.equals(user.getUserCode())){
			session.setAttribute("user", user);
		}
		return "redirect:/user/updateUser.jsp";
		//return "redirect:/user/getUser?userCode="+user.getUserCode();
	}
	
	//=================유저 리스트 가져오기
	
	//@RequestMapping( value="listUser" )
	@RequestMapping( value="getUserList" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("유저리스트 가져오기");
		
		
		
		return "forward:/user/getUserList.jsp";
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

	//=======인증코드생성===========================================================//
		@RequestMapping(value="email")
		public String getRandom() {
			Random rnd = new Random();
			int number = rnd.nextInt(999999);			
			System.out.println("number="+number);
			
			return String.format("%06d", number);		
		}
		
	
	//======모달 계속 수정중==================================//
		@RequestMapping("followModal")
		public String followModal() {
			System.out.println("모달띄우기 나오나요");
			return "VIG/myFeed/followTest.jsp";
		}
	//==

}