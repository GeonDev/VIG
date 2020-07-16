package com.VIG.mvc.web.event;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.event.EventServices;
import com.VIG.mvc.util.VisionInfo;

@Controller
@RequestMapping("/event/*")
public class EventController {
	
	
	@Autowired
	@Qualifier("eventServicesImpl")
	private EventServices eventServices;
	
	
	public EventController(){
	}
	
	@RequestMapping(value="addEvent", method=RequestMethod.GET)
	public ModelAndView addEvent() throws Exception {
		
		String message = "이건 ModelAndView 테스트용 메세지";

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("forward:/event/addEventView.jsp");
		modelAndView.addObject("message", message);
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="addEvent", method=RequestMethod.POST)
	public ModelAndView addEvent(@ModelAttribute("event") Event event, @RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
		System.out.println("addEvent : POST");
		
		System.out.println(event);
		
		if(files !=null) {
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File("C:/uploadFiles/"+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);	
			} 			
		}		
		
		

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("forward:/event/addEventView.jsp");
		modelAndView.addObject("event", event);
		
		return modelAndView;
		
	}
	
	

}
