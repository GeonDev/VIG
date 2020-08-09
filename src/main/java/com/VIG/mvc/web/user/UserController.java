
package com.VIG.mvc.web.user;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Date;
import java.util.Properties;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.GoogleProfile;
import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.Token;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.report.ReportServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.CommonUtil;
import com.google.gson.Gson;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
	@Autowired
	@Qualifier("reportServicesImpl")
	private ReportServices reportService;
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	public UserController() {
	}	
	
	
	//구글 로그인 수행	
	@RequestMapping(value="googleLogin")
	public ModelAndView googleLogin( @RequestParam("code") String code, Model model, HttpSession session) throws Exception{
		String query = "code=" + code;
		query += "&client_id=" + "82747934090-ljsrvma8goa9dskv7hchor1mt2atl1ao.apps.googleusercontent.com";
		query += "&client_secret=" + "bTfZRbsjifaPhndVAiFtbFYP";
		query += "&redirect_uri=" + "http://localhost:8080/VIG/user/googleLogin";
		query += "&grant_type=authorization_code";

		String tokenJson = CommonUtil.getHttpConnection("https://accounts.google.com/o/oauth2/token", query);	
		
		Gson gson = new Gson();
		Token token = gson.fromJson(tokenJson, Token.class);
		String ret = CommonUtil.getHttpConnection("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token.getAccess_token());	
		
		GoogleProfile profile = gson.fromJson(ret, GoogleProfile.class);
		
		//로그인된 상테인지 체크		
		String userCode = ((User)session.getAttribute("user")).getUserCode();
		
		if(!CommonUtil.null2str(userCode).equals("")) {		
			
			//이미 같은 정보로 로그인한 기록이 있을 경우
			if(userServices.getGoogleID(profile.getId()) != null) {				
				
				return new ModelAndView("forward:/common/alertView.jsp", "message", "이미 연동된 계정이 있습니다.");
			} 
			
			//로그인된 유저라면 구글 정보를 업데이트 
			User temp = userServices.getUserOne(userCode);
			temp.setGoogleId(profile.getId());
			
			userServices.updateUser(temp);
			
			//세션에 저장된 정보를 업데이트
			session.setAttribute("user", temp);
			
			return new ModelAndView("forward:/main/main.jsp");
			
		}else {
			
			//구글에 연결된 정보가 있다면 정보를 불러옴
			if(userServices.getGoogleID(profile.getId()) != null ) {
				session.setAttribute("user", userServices.getGoogleID(profile.getId()));
				return new ModelAndView("forward:/main/main.jsp");
			}
			
			//구글 연동이 안되어 있으면 가입 화면으로 이동
			User user = new User();
			user.setUserCode("user"+userServices.getLastUserNum());
			user.setEmail(profile.getEmail());
			user.setGoogleId(profile.getId());				
			
			model.addAttribute("user", user);
		}
		
		return new ModelAndView("forward:/user/addUserView.jsp");		
	
	}
	

//=========회원가입===========================================================//    코드 정리하기!
	
	@RequestMapping(value="addUserView", method=RequestMethod.GET)
	public ModelAndView addUser() throws Exception{		
		System.out.println("addUser(GET):회원가입 페이지로 이동");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/user/addUserView.jsp");	
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

//=======로그인=====
		
	@RequestMapping( value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{		
		System.out.println("login(GET):로그인 페이지로 이동");	

		ModelAndView model = new ModelAndView();
		model.setViewName("login");		
		return model;
	}

	@RequestMapping( value="login", method=RequestMethod.POST )
	public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception{
				
		User dbUser = userServices.getUserOne(user.getUserCode());
		ModelAndView mv = new ModelAndView();
		System.out.println("로그인 시도 :"+user.getUserCode());
		System.out.println(dbUser);
			
		SimpleDateFormat format = new SimpleDateFormat ("yyyyMMdd");
		Date date  = new Date();			
		int toDay = Integer.parseInt(format.format(date));
		
		
		if(dbUser == null) {
			mv.setViewName("forward:/user/loginView.jsp");
			mv.addObject("msg", "fail");
			return mv;
			
		} else if (BCrypt.checkpw(user.getPassword(), dbUser.getPassword())){				
			
			if(dbUser.getState() == 0) {
				session.setAttribute("user", dbUser);
				System.out.println("로그인 성공");
				mv.setViewName("redirect:/main/VIG");
				return mv;					
			}else {				
				
				int banDate = Integer.parseInt(dbUser.getBanDate().toString().replaceAll("-",""));	
				
				if(dbUser.getState() == 1) {
					banDate = banDate + 3;
				}else if(dbUser.getState() == 2) {
					banDate = banDate+ 7;
				}  
				
				
				int remainDate = banDate-toDay;
				
				String msg = "접속 금지 상태 입니다.\n \n 남은 기간 : " + remainDate +"일";				
				return new ModelAndView("forward:/common/alertView.jsp", "message", msg);
				
			}			
			

		} else {
			mv.setViewName("forward:/user/loginView.jsp");
			System.out.println("로그인 실패");
			mv.addObject("msg", "fail");
			return mv;
		}
	}


//=======로그아웃
	
	@RequestMapping( value="logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session) throws Exception{
			
			System.out.println("logout");
			session.removeAttribute("login");
			session.invalidate();
			
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/main/VIG");
		return model;
	}

	
	

	//====업데이트 유저 nav
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser(@RequestParam(value="uesrCode", required=false) String userCode, Model model)throws Exception{ 
		System.out.println("/user/updateUser : GEt");
		User user = userServices.getUserOne(userCode);
		model.addAttribute("user",user);
		return "forward:/user/updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser(@RequestParam("uploadFile") List<MultipartFile> files,@ModelAttribute("uesr") User user, Model model, HttpSession session )throws Exception{ 
		
		System.out.println("유저 업데이");
	
		if(files !=null) {
			
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File("C://workspace//"+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);
	    			if(f!=null) {
	    			user.setProfileImg(f.getName());	
	    			}
	    		}
	        }
				
		String pwdBycrypt = passwordEncoder.encode(user.getPassword());
	    user.setPassword(pwdBycrypt);
		userServices.updateUser(user);	
		model.addAttribute("user", user);
	
		/*
		String sessionId=((User)session.getAttribute("user")).getUserCode();
		System.out.println(sessionId);
		if(sessionId.equals(user.getUserCode())){
			session.setAttribute("user", user);
		}
		*/	
		return "redirect:/user/updateUser.jsp";
		
	}
	
	//=====유저 리스트 nav
	/*
	@RequestMapping("getUserList")
	public ModelAndView getUserList(@ModelAttribute("search") Search search) throws Exception{
		// 현재 페이지값이 없으면 첫번째 페이지로 설정
				if (search.getCurrentPage() == 0) {
					search.setCurrentPage(1);
				}
				
				//키워드 데이터가 NULL이라면
				if(search.getKeyword() == null) {
					search.setKeyword("");
				}
				
				search.setPageSize(pageSize);
				
				Page resultPage = new Page(search.getCurrentPage(), userServices.getTotalCount(search) , pageUnit, pageSize);
			
				ModelAndView modelAndView = new ModelAndView();

				// Model 과 View 연결
				modelAndView.setViewName("forward:/user/getUserlist.jsp");
				modelAndView.addObject("list", userServices.getUserList(search));
				modelAndView.addObject("resultPage", resultPage);
				modelAndView.addObject("search", search);

				return modelAndView;
		
	}
	*/
	
	
	
	
	
	@RequestMapping( value="getUserList" )
	public String getUserList( @ModelAttribute("search") Search search ,Model model) throws Exception{
		
		System.out.println("유저리스트 가져오기");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}

		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userServices.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
				model.addAttribute("list", map.get("list"));
				model.addAttribute("resultPage", resultPage);
				model.addAttribute("search", search);
				model.addAttribute("map", map);
				
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

	
	//======모달 계속 수정중==================================//
		@RequestMapping("testForm")
		public String testForm( HttpServletRequest request,@ModelAttribute("user") User user, Model model) throws Exception {
			
			System.out.println("모달띄우기 나오나요");
			return "/VIG/main/VIG";
		}
	//==
		
		
		

}
