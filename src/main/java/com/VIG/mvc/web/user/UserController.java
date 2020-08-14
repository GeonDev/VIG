
package com.VIG.mvc.web.user;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import com.VIG.mvc.web.event.EventController;
import com.google.gson.Gson;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	public static final Logger logger = LogManager.getLogger(EventController.class); 
	
	private static String OS = System.getProperty("os.name").toLowerCase();
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private ServletContext context;	
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
	@Autowired
	@Qualifier("reportServicesImpl")
	private ReportServices reportService; 
		
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Value("#{commonProperties['realPath']}")
	String realPath;
	
	@Value("#{commonProperties['otherPath']}")
	String otherPath;
	
	
	
	@Value("#{commonProperties['currentDate'] ?: 30}")
	int currentDate;
	
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
		
		//서버 os가 윈도우라면 로컬로 판단
		if(OS.contains("win")) {
			query += "&redirect_uri=" + "http://localhost:8080/VIG/user/googleLogin";	
		}else {
			query += "&redirect_uri=" + "http://ec2-13-125-196-55.ap-northeast-2.compute.amazonaws.com:8080/VIG/user/googleLogin";
		}		
		
		query += "&grant_type=authorization_code";

		String tokenJson = CommonUtil.getHttpConnection("https://accounts.google.com/o/oauth2/token", query);	
		
		Gson gson = new Gson();
		Token token = gson.fromJson(tokenJson, Token.class);
		String ret = CommonUtil.getHttpConnection("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token.getAccess_token());	
		
		GoogleProfile profile = gson.fromJson(ret, GoogleProfile.class);
		
		//로그인된 상태인지 체크		
		User checkUser = ((User)session.getAttribute("user"));
		
		if(checkUser != null) {		
			
			//이미 같은 정보로 로그인한 기록이 있을 경우
			if(userServices.getGoogleID(profile.getId()) != null) {				
				
				return new ModelAndView("forward:/common/alertView.jsp", "message", "이미 연동된 계정이 있습니다.");
			} 
			
			//로그인된 유저라면 구글 정보를 업데이트 -> 세션에는 비밀번호가 없어 DB에서 전체 정보를 다시 받음			
			User userTemp = userServices.getUserOne(checkUser.getUserCode());
			
			userTemp.setGoogleId(profile.getId());
			
			userServices.updateUser(userTemp);
			
			//세션에 저장된 정보를 업데이트
			session.setAttribute("user", userTemp);
			
			return new ModelAndView("redirect:/main/VIG");
			
		}else {
			
			//구글에 연결된 정보가 있다면 정보를 불러옴
			if(userServices.getGoogleID(profile.getId()) != null ) {
				
				User user =  userServices.getGoogleID(profile.getId());				
				
				if(user.getState() == 0 ) {
					session.setAttribute("user",user);							
					return new ModelAndView("redirect:/main/VIG");
					
				}else if(user.getState() == 3 || user.getState() == 4){		
					String msg = "사용할 수 없는 아이디입니다";				
					return new ModelAndView("forward:/common/alertView.jsp", "message", msg);
				}else {
					
					int banDate = Integer.parseInt(user.getBanDate().toString().replaceAll("-",""));	
					
					if(user.getState() == 1) {
						banDate = banDate + 3;
					}else if(user.getState() == 2) {
						banDate = banDate+ 7;
					}  
					
					SimpleDateFormat format = new SimpleDateFormat ("yyyyMMdd");
					Date date  = new Date();			
					int toDay = Integer.parseInt(format.format(date));
					
					int remainDate = banDate-toDay;
					
					String msg = "접속 금지 상태 입니다.\n \n 남은 기간 : " + remainDate +"일";				
					return new ModelAndView("forward:/common/alertView.jsp", "message", msg);						
					
				}		

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

		SimpleDateFormat format = new SimpleDateFormat ("yyyyMMdd");
		Date date  = new Date();			
		int toDay = Integer.parseInt(format.format(date));
		
		if(dbUser == null) {
			String msg = "가입되어 있지 않은 아이디입니다.";				
			return new ModelAndView("forward:/common/alertView.jsp", "message", msg);
		}
		
		if (BCrypt.checkpw(user.getPassword(), dbUser.getPassword())){				
			
			if(dbUser.getState() == 0) {
				session.setAttribute("user", dbUser);
				System.out.println("로그인 성공");
				mv.setViewName("redirect:/main/VIG");
						System.out.println("로그인후db비번:"+user.getPassword());
				return mv;					
			}else if(dbUser.getState() == 3 || dbUser.getState() == 4){		
				String msg = "사용할 수 없는 아이디입니다";				
				return new ModelAndView("forward:/common/alertView.jsp", "message", msg);
			}
				
				int banDate = Integer.parseInt(dbUser.getBanDate().toString().replaceAll("-",""));	
				
				if(dbUser.getState() == 1) {
					banDate = banDate + 3;
				}else if(dbUser.getState() == 2) {
					banDate = banDate+ 7;
				}  
				
				
				int remainDate = banDate-toDay;
				
				String msg = "접속 금지 상태 입니다.\n \n 남은 기간 : " + remainDate +"일";				
				return new ModelAndView("forward:/common/alertView.jsp", "message", msg);
				
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
	public ModelAndView updateUser(@RequestParam(value="uesrCode", required=false) String userCode,HttpSession session, User user)throws Exception{ 
		
		System.out.println("/user/updateUser : GEt");
	
		User writer = userServices.getUserOne(user.getUserCode());
		session.setAttribute("writer", writer);
				System.out.println(writer.getUserCode());
		ModelAndView mv = new ModelAndView();
		mv.setViewName("forward:/user/updateUser.jsp");
		mv.addObject("user", writer);
		return mv;
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public ModelAndView updateUser(@ModelAttribute("user") User user, @RequestParam("uploadFile") MultipartFile file, HttpSession session )throws Exception{ 
		
		logger.debug("유저 업데이트");	
		
        String path = context.getRealPath("/");  

        System.out.println(path);
        
        User dbuser = userServices.getUserOne(user.getUserCode());
        
        if(OS.contains("win")) {
        	//워크스페이스 경로를 받아온다.
            path = path.substring(0,path.indexOf("\\.metadata"));         
            path +=  uploadPath;           
        }else {
        	//실제 톰켓 데이터가 저장되는 경로를 가리킨다.
        	path +=  realPath;
        }
        System.out.println(file);
		System.out.println(file.getOriginalFilename());	
		if(!file.isEmpty()) {
			
        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.	        	
        	String inDate = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());		
      	       	
        	File f=new File(path+inDate+file.getOriginalFilename());
        	file.transferTo(f);
			user.setProfileImg(f.getName());	        	
	        
		}else {
			
			user.setProfileImg(dbuser.getProfileImg());
			
		}
		//비밀번호는 필수 입력
		if(user.getPassword()!= null || user.getPassword()!="") {
			
			String pwdBycrypt = passwordEncoder.encode(user.getPassword());
		    user.setPassword(pwdBycrypt);
			
		}
		
		userServices.updateUser(user);	
		session.setAttribute("user", userServices.getUserOne(user.getUserCode()));

		ModelAndView mv = new ModelAndView();
		mv.addObject("user", userServices.getUserOne(user.getUserCode()));
		mv.setViewName("redirect:/user/updateUser?userCode="+user.getUserCode());
		
		return mv;
	        
	}
	
	
	
	
	
	
	//
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userCode") String userCode , Model model ) throws Exception {
		
		System.out.println("getUser GET");	
		User user = userServices.getUserOne(userCode);
		model.addAttribute("user", user);		
		return "forward:/user/getUser.jsp";
	}
	
	//=====유저 리스트 nav
	

	@RequestMapping(value="getUserList" )
	public String getUserList( @ModelAttribute("search") Search search ,Model model) throws Exception{
		
		System.out.println("유저리스트 가져오기");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		search.setCurrentDate(currentDate);
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
	
	
	
	
	//======탈퇴==================================//
		
		@RequestMapping(value = "deleteUser", method = RequestMethod.GET)
		public ModelAndView deleteUser(HttpSession session) throws Exception {
			
			User user = userServices.getUserOne(((User)session.getAttribute("user")).getUserCode());
			
			ModelAndView mv = new ModelAndView();
			System.out.println("탈퇴페이지로 이동");
			mv.addObject("user", user);
			mv.setViewName("forward:/user/deleteUser.jsp");
			
			return mv;
		}
		
	
		@RequestMapping (value="deleteUser", method = {RequestMethod.GET, RequestMethod.POST})
		public ModelAndView deleteUser(User user,HttpSession session) throws Exception{
			
			
		System.out.println("모르겟숴....");
			ModelAndView mv = new ModelAndView();
			userServices.deleteUser(user);
			session.invalidate();
			mv.setViewName("redirect:/");
			return mv;
		}	
		

}
