package com.VIG.mvc.web.main;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.alarm.AlarmServices;
import com.VIG.mvc.service.category.CategoryServices;
import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Alarm;
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
	
	public static final Logger logger = LogManager.getLogger(mainController.class); 
	
	
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
	@Qualifier("alarmServicesImpl")
	private AlarmServices alarmServices;
	
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
		List<Alarm> alarmList = new ArrayList<Alarm>();
		
		User user = (User)session.getAttribute("user");
		
		if(user !=null) {
			user.setGoogleId("");
			user.setPassword("");

		}		
		
		model.addAttribute("user", user);	
		
		model.addAttribute("eventList", eventList);		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pageSize", pageSize);
		
		return new ModelAndView("forward:/main/main.jsp");
	}
	
	
	
	
	@RequestMapping("setImage")
	public ModelAndView setImageKeyword() throws Exception {		
	
		if(keywordServices.getKeywordAllCount() == 0) {	
		
		String path = context.getRealPath("/");        
	    path = path.substring(0,path.indexOf("\\.metadata"));
	    path = path +  uploadPath; 
		
		List<Image> imagelist = new ArrayList<Image>();		
		//저장되어 있는 모든 이미지를 불러옴		
		imagelist = imageServices.getALLImageList();
		
		//비전 정보 + 쓰레드 동작을 위한 비전 배열
		ArrayList<VisionInfo> visions = new ArrayList<VisionInfo>();
			
		
		List<User>list = userServices.getAllUserList();
		
		logger.debug("회원정보 해쉬 적용 시작");
		
		
		for(User user: list) {			
			String pwdBycrypt = passwordEncoder.encode(user.getPassword());
			user.setPassword(pwdBycrypt);
			userServices.updateUser(user);	
		}	
					
		logger.debug("회원정보 해쉬 적용 완료");
		
		logger.debug("이미지 정보 추출 시작");		
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
		logger.debug("쓰레드 실행 완료 / DB 저장 시작");	
		
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
		logger.debug("이미지 정보 추출 완료 / 총 추출 시간 : " + getTotalWorkTime(Totalstart, Totalend));				
		return new ModelAndView("forward:/common/alertView.jsp", "message", "세팅 완료");
		
		}else {
			return new ModelAndView("forward:/common/alertView.jsp", "message", "데이터가 이미 있습니다.");
		}
	}	
	
	
	//30분에 한번씩 실행 (초, 분, 시, 일, 월, 요일)
	// 일지정지 당한 유저를 확인하고 정지를 풀어준다.
	@Scheduled(cron="0 */30 * * * *")
	public void setScheduled()throws Exception {
	
		logger.debug("START Scheduler");
		
		historyServices.deleteTempHistory();
	
		logger.debug("방문자 히스토리를 삭제를 진행합니다.");
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
						
						logger.debug(user.getUserName() + "를 상태를 '정상'으로 변경했습니다.");
					}
					
				}else if(user.getState() == 2) {
					int banDate = Integer.parseInt(user.getBanDate().toString().replaceAll("-","")) +7;
					
					if(tagetDate > banDate) {
						user.setState(0);
						userServices.updateUser(user);											
				
						logger.debug(user.getUserName() + "를 상태를 '정상'으로 변경했습니다.");
					}
				}				
			}			
		}		
		
		// 생성된지 14일이 지난 알람은 삭제 한다.
		logger.debug("오래된 알람 삭제를 진행합니다.");
		alarmServices.deleteOldAlarm(14);
		
	}
	
	private int getTotalWorkTime(long start, long end) {		
		return (int) ((end - start)/1000);
	}	

}
