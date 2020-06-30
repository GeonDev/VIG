package com.VIG.mvc.web.test;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.util.Translater;
import com.VIG.mvc.util.VisionInfo;
import com.google.api.client.util.Data;


@Controller
@RequestMapping("/testController/*")
public class TestController {
	
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Autowired
	private ServletContext context;	

	
	public TestController() {
		// TODO Auto-generated constructor stub
		
	}	
	
	@Scheduled(cron="10 * * * *")
	public void TestScheduler() {	
		
		Date now = new Date();
		System.out.println("[SERVER] : Scheduler " + now);		
	}

	
	
	@RequestMapping(value = "trans", method = RequestMethod.POST)
	public ModelAndView trans(@ModelAttribute("Trans") String target ) throws Exception {
		String result = new String("Translate : ");	
		
		result = result + Translater.autoDetectTranslate(target);
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", result);
	}
	
	
	
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public ModelAndView updatefile(@RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
        String path = context.getRealPath("/");        
        path = path.substring(0,path.indexOf("\\.metadata"));         
        path = path +  uploadPath;  
		
        String result = new String("VISION KEY : ");
        List<ImageKeyword> keys = new ArrayList<ImageKeyword>();
        List<ImageColor> colors = new ArrayList<ImageColor>();
        
		if(files !=null) {
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File(path+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);	
	    		
	    		keys = VisionInfo.getKeywordForVision(path+inDate+multipartFile.getOriginalFilename());	    			
	    		colors = VisionInfo.getColorForVision(path+inDate+multipartFile.getOriginalFilename());
			} 			
		}		
		
		if(keys.size() > 1) {
			for(ImageKeyword word : keys) {				
				result +=" "+word.getKeywordEn();
				
			}
		}	
		
		if(colors.size() > 1) {
			for(ImageColor color : colors) {
				result +=" R: "+color.getRed();
				result +=" G: "+color.getGreen();
				result +=" B: "+color.getBlue();
				result +=" Ratio: "+color.getRatio();
				
			}
			
		}	
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", result);
	}
	
	@RequestMapping(value = "chatting")
	public ModelAndView chat(@ModelAttribute("user") User user, HttpSession session) {
		
	
		//사용자 정보 세션 삽입		
		session.setAttribute("user", user);
		
		System.out.println("user name :" + user.getName());	
				
		return new ModelAndView("forward:/ChattingView.jsp", "userid", user.getName());
	}	

}
