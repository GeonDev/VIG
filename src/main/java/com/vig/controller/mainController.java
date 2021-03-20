package com.vig.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Category;
import com.vig.domain.Event;
import com.vig.domain.ImageInfo;
import com.vig.domain.User;
import com.vig.scheduler.WaitingList;
import com.vig.service.CategoryService;
import com.vig.service.ColorService;
import com.vig.service.EventService;
import com.vig.service.ImageService;
import com.vig.service.KeywordService;
import com.vig.util.VisionInfo;

@Controller
public class mainController {
	
	public static final Logger logger = LoggerFactory.getLogger(mainController.class); 	
	
	@Value("${limitVisionImageCount}")
	private int limitCount;
	
	@Value("${uploadPath}")
	private String  uploadPath;
	
	@Value("${realPath}")
	private String realPath;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	@Autowired
	private ServletContext context;	
	
	@Autowired
	private CategoryService categoryServices;

	@Autowired
	private EventService eventServices;
	
	@Autowired
	private ImageService ImageServices;
	




	public mainController() {	}

	@GetMapping
	public ModelAndView getMain(Model model, HttpSession session) throws Exception {

		List<Category> categoryList = categoryServices.getAllCategoryList();
		List<Event> eventList = eventServices.getLastEventList();

		User user = (User) session.getAttribute("user");		

		model.addAttribute("user", user);

		model.addAttribute("eventList", eventList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("pageSize", pageSize);
		
		return new ModelAndView("mainView/main");
	}

	
	@GetMapping("checkLogin")
	public ModelAndView setAlertPopup() {		
		String msg = "로그인이 필요합니다.";				
		return new ModelAndView("common/alertView", "message", msg);
		
	}
	
	@GetMapping("checkAdmin")
	public ModelAndView setAlertAdminPopup() {		
		String msg = "관리자 권한이 필요합니다	.";				
		return new ModelAndView("common/alertView", "message", msg);
		
	}
	
	
	// 5분에 한번씩 실행되는 스케줄러
	@Scheduled(fixedDelay = 300000)
	@Transactional
	public void scheduleFixedRateTask() {
		
		//이미지는 업로드 되었으나 아직 키워드가 추출되지 않은 이미지를 불러옴
		try {
			List<ImageInfo> imagelist = ImageServices.getImageListNoKeyword(context, uploadPath, realPath );
			
			if (!imagelist.isEmpty()) {
				for(ImageInfo info : imagelist) {
					WaitingList.setWaitImage(info);
				}
			}			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//VISION API의 1분당 최대 처리량 이하로 요청하기 위해 이미지 수 체크
		int currentSize = WaitingList.getWaitSize();
		
		
		if(currentSize > 0) {	
			for(int i =0; i< limitCount; i++) {				
				ImageInfo info = WaitingList.getWaitImage();
				if(info != null) {
					logger.info("Start Vision API ImagePath :  "+info.getPath());
					//Vision API에서 이미지 정보를 추출하는 쓰레드 생성
					VisionInfo vision = new VisionInfo(info.getPath(), info.getImageId());
					vision.start();	
				}
			}			
		}else {
			logger.info("no remain waiting image ");
		} 
	}
}
