package com.vig.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Event;
import com.vig.domain.Feed;
import com.vig.domain.Page;
import com.vig.domain.Search;
import com.vig.service.EventService;
import com.vig.service.FeedService;


@Controller
@RequestMapping("event/*")
public class EventController {
	
	public static final Logger logger = LogManager.getLogger(EventController.class);
	
	private static String OS = System.getProperty("os.name").toLowerCase();
	
	
	@Value("${otherPath}")
	String otherPath;
	
	@Value("${realOtherPath}")
	String realOtherPath;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	
	@Autowired
	private EventService eventServices;
	
	@Autowired
	private FeedService feedServices;
	

	
	@Autowired
	private ServletContext context;	
	
	
	public EventController(){
	}
	
	@RequestMapping(value="addEvent", method=RequestMethod.GET)
	public ModelAndView addEvent() throws Exception {
		

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("forward: eventView/addEventView.jsp");

		return modelAndView;
		
	}
	
	//완료됨
	@RequestMapping(value="addEvent", method=RequestMethod.POST)
	public ModelAndView addEvent(@ModelAttribute("event") Event event, @RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
		logger.debug("addEvent시작");
		
		System.out.println(event);
		
        String path = context.getRealPath("/"); 
        
        
        if(OS.contains("win")) {
        	//워크스페이스 경로를 받아온다.
            path = path.substring(0,path.indexOf("\\.metadata"));         
            path +=  otherPath;           
        }else {
        	//실제 톰켓 데이터가 저장되는 경로를 가리킨다.
        	path =  realOtherPath;
        }
		
		if(files !=null) {
			int i = 0;
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	i++;
	        	System.out.println("index: "+i);
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		
	    		
	    		if(multipartFile.getOriginalFilename()!="") { //multipartFile이 있는지 확인
	    			
	    			File f = null;
		    		//원하는 위치에 파일 저장
	    			
	    			
		    		
		    		if(i == 1) { //본문 이미지면
		    			
		    			f=new File(path+inDate+multipartFile.getOriginalFilename());
		    			multipartFile.transferTo(f);
		    			event.setEventImage(f.getName());	
		    			
		    		}
		    		
		    		if(i == 2) { //썸네일이면
		    			
		    			f=new File(path+inDate+multipartFile.getOriginalFilename());
		    			multipartFile.transferTo(f);
			    		event.setEventThumb(f.getName());
		    			
		    		}
		    		
		    		if(i == 3) { //배너면
		    			
		    			f=new File(path+inDate+multipartFile.getOriginalFilename());
		    			multipartFile.transferTo(f);
			    			event.setBanner(f.getName());
		    			
		    		}
		    		
		    		System.out.println(i+"    "+f.getName());
		    		
				} 	
	        }
		}
		
		
		
		
		System.out.println(event);
		
		eventServices.addEvent(event);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect: eventView/getEventList");
		
		return modelAndView;
		
	}
	//완료됨 키워드로 피드 받아와야함
	@RequestMapping(value="getEvent", method=RequestMethod.GET)
	public ModelAndView getEvent(@RequestParam("eventId") int eventId) throws Exception {
		
		logger.debug("getEvent");
		Event event = eventServices.getEvent(eventId);
		
		logger.debug(event);
		
		//String[] tags = ((event.getEventTags()).split(","));
		String tags = event.getEventTags();
		System.out.println(tags);
		List<Feed> feedList = feedServices.getFeedListOnlyTag(tags);
		System.out.println(feedList);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward: eventView/getEvent");
		mav.addObject("event", event);
		mav.addObject("feedList", feedList);
		
		return mav;
		
	}
	
	@RequestMapping(value="getEventList")
	public ModelAndView getEventList( @ModelAttribute("search") Search search) throws Exception {
		
		logger.debug("getEventList");
		logger.debug(search);
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		if(search.getKeyword() == "" || search.getKeyword() == null) {
			search.setKeyword("0");
		}
		
		search.setPageSize(pageSize);
		
		Map<String , Object> map=eventServices.getEventList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward: eventView/getEventList");
		mav.addObject("list", map.get("list"));
		mav.addObject("resultPage", resultPage);
		
		return mav;
		
	}
	//완료됨
	@RequestMapping(value="deleteEvent", method=RequestMethod.GET)
	public ModelAndView deleteEvent(@RequestParam("eventId") int eventId) throws Exception {
		
		
		
		System.out.println("deleteEvent");
		
		eventServices.deleteEvent(eventId);
		
		ModelAndView mav = new ModelAndView("redirect: eventView/getEventList");
		
		return mav;
	}
	
	@RequestMapping(value="updateEvent", method=RequestMethod.GET)
	public ModelAndView updateEvent(@RequestParam("eventId") int eventId) throws Exception {
		
	
		Event dbEvent = eventServices.getEvent(eventId);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward: eventView/updateEventView");
		mav.addObject("event", dbEvent);
		
		return mav;
		
	}
	
	@RequestMapping(value="updateEvent", method=RequestMethod.POST)
	public ModelAndView updateEvent(@ModelAttribute("event") Event event, @RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
		System.out.println("updateEvent : POST");
		
		System.out.println(event);
		
        String path = context.getRealPath("/");        
        path = path.substring(0,path.indexOf("\\.metadata"));         
        path = path +  otherPath;  
        
        System.out.println(files);
		
		if(files !=null) {
			int i = 0;
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	i++;
	        	System.out.println("index: "+i);
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		
	    		
	    		if(multipartFile.getOriginalFilename()!="") { //multipartFile이 있는지 확인
	    			
	    			File f = null;
		    		//원하는 위치에 파일 저장
	    			
	    			
		    		
		    		if(i == 1) { //본문 이미지면
		    			
		    			f=new File(path+inDate+multipartFile.getOriginalFilename());
		    			multipartFile.transferTo(f);
		    			event.setEventImage(f.getName());	
		    			
		    		}
		    		
		    		if(i == 2) { //썸네일이면
		    			
		    			f=new File(path+inDate+multipartFile.getOriginalFilename());
		    			multipartFile.transferTo(f);
			    			event.setEventThumb(f.getName());
		    			
		    		}
		    		
		    		if(i == 3) { //배너면
		    			
		    			f=new File(path+inDate+multipartFile.getOriginalFilename());
		    			multipartFile.transferTo(f);
			    			event.setBanner(f.getName());
		    			
		    		}
		    		
		    		System.out.println(i+"    "+f.getName());
		    		
				} 	
	        }
		}
		
		
		System.out.println(event);
		
		eventServices.updateEvent(event);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect: eventView/getEventList");
		
		return modelAndView;
		
	}
	
	

}
