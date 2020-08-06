package com.VIG.mvc.web.user;


import java.io.File;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.report.ReportServices;
import com.VIG.mvc.service.user.UserServices;

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
	
//=========회원가입=====
	
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

//=======로그인====
		
	@RequestMapping( value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{		
		System.out.println("login(GET):로그인 페이지로 이동");	
		ModelAndView model = new ModelAndView();
		model.setViewName("forward:/user/loginView.jsp");		
		return model;
	}

	@RequestMapping( value="login", method=RequestMethod.POST )
	public ModelAndView login(@ModelAttribute("user") User user, HttpSession session) throws Exception{
		
		
			User dbUser = userServices.getUserOne(user.getUserCode());
			ModelAndView mv = new ModelAndView();
			System.out.println("로그인:"+user.getUserCode());
			
		if(dbUser == null) {
			mv.setViewName("forward:/user/loginView.jsp");
			mv.addObject("msg", "fail");
			return mv;
			
		} else if (BCrypt.checkpw(user.getPassword(), dbUser.getPassword())){	
			session.setAttribute("user", dbUser);
			System.out.println("로그인 성공");
			mv.setViewName("forward:/main/VIG");
			mv.addObject("msg", "suuccess");
			return mv;
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
			session.invalidate();
			
		ModelAndView model = new ModelAndView();
		model.setViewName("redirect:/main/VIG");
		return model;
	}


	//====업데이트 유저 
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser(@RequestParam(value="uesrCode", required=false) String userCode, Model model)throws Exception{ 
		System.out.println("/user/updateUser : GEt");
		User user = userServices.getUserOne(userCode);
		model.addAttribute("user",user);
		return "forward:/user/updateUser.jsp";
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser(@RequestParam("uploadFile") List<MultipartFile> files,@ModelAttribute("uesr") User user, Model model, HttpSession session )throws Exception{ 
		
		System.out.println("유저 업데트");
	
		if(files !=null) {			
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	        	File f =new File(uploadPath+inDate+multipartFile.getOriginalFilename());
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
		return "forward:/user/updateUser.jsp";	
	}
	
	//=====유저 리스트 

	@RequestMapping(value="getUserList", method=RequestMethod.GET)
	public String getUserList(@ModelAttribute("search") Search search,Model model,HttpServletRequest request) throws Exception{
		
		System.out.println("1");
			// 현재 페이지값이 없으면 첫번째 페이지로 설정
				if (search.getCurrentPage() == 0) {
					search.setCurrentPage(1);
				}				
			//키워드 데이터가 NULL이라면
				if(search.getKeyword() == null) {
					search.setKeyword("");
				}
				
				search.setPageSize(pageSize);
				Map<String, Object> map = userServices.getUserList(search);
				Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue() , pageUnit, pageSize);
					System.out.println("resultPage:"+resultPage);
					System.out.println(map.get("list"));
				// Model 과 View 연결
					model.addAttribute("list", map.get("list"));
					model.addAttribute("resultPage", resultPage);
					model.addAttribute("search", search);
					
				return "forward:/user/getUserList.jsp";	
			}

	
	

}