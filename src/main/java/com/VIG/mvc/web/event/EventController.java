package com.VIG.mvc.web.event;

import java.io.File;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.event.EventServices;


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
	
	//완료됨
	@RequestMapping(value="addEvent", method=RequestMethod.POST)
	public ModelAndView addEvent(@ModelAttribute("event") Event event, @RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
		System.out.println("addEvent : POST");
		
		System.out.println(event);
		
		if(files !=null) {
			int i = 0;
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	System.out.println("index: "+ i++);
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File("C://uploadFiles//"+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);
	    		if(i == 1) {
	    			event.setEventImage(f.getName());	
	    		}
	    		
	    		if(i == 2) {
	    			event.setEventThumb(f.getName());
	    		}
	    		
	    		if(i == 3) {
	    			event.setBanner(f.getName());
	    		}
	    		
	    		System.out.println(i+"    "+f.getName());
	    		
			} 			
		}	
		
		
		System.out.println(event);
		
		eventServices.addEvent(event);
		
		ModelAndView modelAndView = new ModelAndView();
		
		String message = "getEventList다";
		modelAndView.setViewName("forward:/event/getEventList.jsp");
		modelAndView.addObject("message", message);
		
		return modelAndView;
		
	}
	//완료됨 키워드로 피드 받아와야함
	@RequestMapping(value="getEvent", method=RequestMethod.GET)
	public ModelAndView getEvent(@RequestParam("eventId") int eventId) throws Exception {
		
		System.out.println("getEvent");
		Event event = eventServices.getEvent(eventId);
		
		System.out.println("getEvent의 event객체 :" +event);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/event/getEvent.jsp");
		mav.addObject("event", event);
		
		return mav;
		
	}
	
	@RequestMapping(value="getEventList", method=RequestMethod.GET)
	public ModelAndView getEventList() throws Exception {
		
		System.out.println("getEventList");
		
		String message = "이벤트 리스트 입니다.";
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/event/getEventList.jsp");
		mav.addObject("message", message);
		
		return mav;
		
	}
	//완료됨
	@RequestMapping(value="deleteEvent", method=RequestMethod.GET)
	public ModelAndView deleteEvent(@RequestParam("eventId") int eventId) throws Exception {
		
		
		
		System.out.println("deleteEvent");
		
		eventServices.deleteEvent(eventId);
		
		ModelAndView mav = new ModelAndView("redirect:/event/getEventList");
		
		return mav;
	}
	
	@RequestMapping(value="updateEvent", method=RequestMethod.POST)
	public ModelAndView updateEvent(@ModelAttribute("event") Event event, @RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
		System.out.println("updateEvent : POST");
		
		System.out.println(event);
		
		
		
		if(files !=null) {
			int i = 0;
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	System.out.println("index: "+ i++);
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File("C://uploadFiles//"+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);
	    		if(i == 1) {
	    			event.setEventImage(f.getName());	
	    		}
	    		
	    		if(i == 2) {
	    			event.setEventThumb(f.getName());
	    		}
	    		
	    		if(i == 3) {
	    			event.setBanner(f.getName());
	    		}
	    		
	    		System.out.println(i+"    "+f.getName());
	    		
			} 			
		}	
		
		
		System.out.println(event);
		
		eventServices.addEvent(event);
		
		ModelAndView modelAndView = new ModelAndView();
		
		String message = "getEventList다";
		modelAndView.setViewName("forward:/event/getEventList.jsp");
		modelAndView.addObject("message", message);
		
		return modelAndView;
		
	}
	
	

}
