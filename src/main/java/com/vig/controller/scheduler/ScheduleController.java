package com.vig.controller.scheduler;

import java.util.List;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;


import com.vig.domain.ImageInfo;
import com.vig.scheduler.WaitingList;
import com.vig.service.HistoryService;
import com.vig.service.ImageService;
import com.vig.util.VisionInfo;

@Controller
public class ScheduleController {
	
	public static final Logger logger = LoggerFactory.getLogger(ScheduleController.class); 
	
	@Autowired
	private ServletContext context;	
	
	@Autowired
	private ImageService ImageServices;
	
	@Autowired
	private HistoryService HistoryService;
	
	
	@Value("${uploadPath}")
	private String  uploadPath;
	
	@Value("${realPath}")
	private String realPath;
	
	@Value("${limitVisionImageCount}")
	private int limitCount;
	
	
	@Value("${unVision}")
	private String unVision;
	
	
	// 10분에 한번씩 실행되는 스케줄러
	@Scheduled(fixedDelay = 600000)
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
					if(unVision.equals("N") ) {
						logger.info("Start Vision API ImagePath :  "+info.getPath());
						//Vision API에서 이미지 정보를 추출하는 쓰레드 생성
						VisionInfo vision = new VisionInfo(info.getPath(), info.getImageId() );
						vision.start();
					}else {
						logger.info("VISION API SETUP NOT ACTIVE : Please check common.properties ");
					}

				}
			}			
		}else {
			logger.info("no remain waiting image ");
		} 
	}
	
	
	//매일 30분 마다 실행
	@Scheduled(cron="0 0/30 * * * *" )
	@Transactional
	public void setPreferUserCategory() {
		
		try {
			HistoryService.setMaxViewCategory();
			logger.info("UPDATE User Prefer CATEGORY SUCCESS");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.error("[ERROR ] FAIL UPDATE User Prefer CATEGORY");
		}
		
		
	}

}
