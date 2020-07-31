package com.VIG.mvc.web.main;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.category.CategoryServices;
import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Category;
import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.event.EventServices;
import com.VIG.mvc.service.history.HistoryServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.VisionInfo;


@Controller
@RequestMapping("/main/*")
public class mainController {
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
		
	@Autowired 
	@Qualifier("categoroyServicesImpl")
	private CategoryServices categoryServices;
	
	@Autowired 
	@Qualifier("eventServicesImpl")
	private EventServices eventServices;	
	
	@Autowired 
	@Qualifier("imageServicesImpl")
	private ImageServices imageServices;
	
	@Autowired 
	@Qualifier("keywordServicesImpl")
	private KeywordServices keywordServices;
	
	@Autowired 
	@Qualifier("colorServicesImpl")
	private ColorServices colorServices;
	
	@Autowired 
	@Qualifier("historyServicesImpl")
	private HistoryServices historyServices;
	
	
	

	@Autowired
	private ServletContext context;	
	
	
	
	@Value("#{commonProperties['pageUnit'] ?: 10}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	

	
	public mainController(){
	}
	
	@RequestMapping("VIG")
	public ModelAndView getMain(Model model, HttpSession session) throws Exception {
		
		List<Category> categoryList = categoryServices.getAllCategoryList();
		List<Event> eventList = eventServices.getLastEventList();			
		
		User user = (User)session.getAttribute("user");
		
		if(user !=null) {
			user.setGoogleId("");
			user.setPassword("");
		}
		
		model.addAttribute("user", user);	
		
		model.addAttribute("eventList", eventList);		
		model.addAttribute("categoryList", categoryList);			
		
		return new ModelAndView("forward:/main/main.jsp");
	}
	
	
	
	
	@RequestMapping("setImage")
	public ModelAndView setImageKeyword() throws Exception {		
		
		String path = context.getRealPath("/");        
	    path = path.substring(0,path.indexOf("\\.metadata"));
	    path = path +  uploadPath; 
		
		List<Image> imagelist = new ArrayList<Image>();		
		//저장되어 있는 모든 이미지를 불러옴		
		imagelist = imageServices.getALLImageList();
		
		//비전 정보 + 쓰레드 동작을 위한 비전 배열
		ArrayList<VisionInfo> visions = new ArrayList<VisionInfo>();
			
		
		List<User>list = userServices.getAllUserList();
		
		System.out.println("[SERVER] : 회원정보 해쉬 적용 시작");
		
		for(User user: list) {			
			String pwdBycrypt = passwordEncoder.encode(user.getPassword());
			user.setPassword(pwdBycrypt);
			userServices.updateUser(user);	
		}	
		
		System.out.println("[SERVER] : 회원정보 해쉬 적용 완료");		
		
		
		System.out.println("[SERVER] : 이미지 정보 추출 시작");
		long Totalstart = System.currentTimeMillis();
				
		for(Image image :imagelist) {					
			VisionInfo vision = new VisionInfo(path + image.getImageFile(), image.getImageId());
			vision.start();			
			visions.add(vision);
		}
		
		//생성된 쓰래드를 연결하여 모든 쓰레드가 완료 될때 까지 기다림
		for (VisionInfo vision : visions) {			
			vision.join();
		}		
		
		//쓰래드 실행이 완료 된 이후 DB에 데이터 삽입
		for (VisionInfo vision : visions) {			
			for(ImageKeyword keyword : vision.getKeywords()) {
				keywordServices.addKeyword(keyword);
			}
			
			for(ImageColor color : vision.getColors()) {
				colorServices.addColor(color);
			}			
		}
		
		long Totalend = System.currentTimeMillis();
		System.out.println("[SERVER] : 이미지 정보 추출 완료 / 총 추출 시간 : "+(Totalend - Totalstart)/1000.0);
					
		return new ModelAndView("forward:/common/alertView.jsp", "message", "세팅 완료");
	}	
	
	
	//30분에 한번씩 실행 (초, 분, 시, 일, 월, 요일)
	// 일지정지 당한 유저를 확인하고 정지를 풀어준다.
	@Scheduled(cron="0 */30 * * * *")
	public void setScheduled()throws Exception {
		
		System.out.println("[SERVER] : START Scheduler");
								
		historyServices.deleteTempHistory();
		System.out.println("[SERVER] : 방문자 히스토리를 삭제했습니다.");
		
		List<User> userList = userServices.getBanUserList();
		
		//일시정지 당한 유저가 있을 경우
		if(userList.size() > 0) {
			SimpleDateFormat format = new SimpleDateFormat ("yyyyMMdd");
			Date date  = new Date();			
			int tagetDate = Integer.parseInt(format.format(date));
			
			for(User user : userList) {
				
				if(user.getState() == 1) {					
					int banDate = Integer.parseInt(user.getBanDate().toString().replaceAll("-","")) +3;	
					
					if(tagetDate > banDate) {
						user.setState(0);
						userServices.updateUser(user);
						System.out.println("[SERVER] : "+ user.getUserName() + " 를 상태를 '정상'으로 변경했습니다.");
					}
					
				}else if(user.getState() == 2) {
					int banDate = Integer.parseInt(user.getBanDate().toString().replaceAll("-","")) +7;
					
					if(tagetDate > banDate) {
						user.setState(0);
						userServices.updateUser(user);	
						System.out.println("[SERVER] : "+ user.getUserName() + " 를 상태를 '정상'으로 변경했습니다.");
					}
				}				
			}
			
			
			
		}
		
		
		
		
	}
	
	
	

}
