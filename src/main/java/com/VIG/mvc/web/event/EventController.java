package com.VIG.mvc.web.event;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.event.EventServices;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Search;


@Controller
@RequestMapping("/event/*")
public class EventController {
	
	public static final Logger logger = LogManager.getLogger(EventController.class); 
	
	@Value("#{commonProperties['otherPath']}")
	String otherPath;
	
	@Autowired
	@Qualifier("eventServicesImpl")
	private EventServices eventServices;
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Autowired
	private ServletContext context;	
	
	
	public EventController(){
	}
	
	@RequestMapping(value="addEvent", method=RequestMethod.GET)
	public ModelAndView addEvent() throws Exception {
		

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("forward:/event/addEventView.jsp");

		return modelAndView;
		
	}
	
	//완료됨
	@RequestMapping(value="addEvent", method=RequestMethod.POST)
	public ModelAndView addEvent(@ModelAttribute("event") Event event, @RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
		
		logger.debug("addEvent시작");
		
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
		
		eventServices.addEvent(event);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect:/event/getEventList");
		
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
		mav.setViewName("forward:/event/getEvent.jsp");
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
		mav.setViewName("forward:/event/getEventList.jsp");
		mav.addObject("list", map.get("list"));
		mav.addObject("resultPage", resultPage);
		
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
	
	@RequestMapping(value="updateEvent", method=RequestMethod.GET)
	public ModelAndView updateEvent(@RequestParam("eventId") int eventId) throws Exception {
		
		System.out.println("updateEventView");
		Event dbEvent = eventServices.getEvent(eventId);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/event/updateEventView.jsp");
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
		
		modelAndView.setViewName("redirect:/event/getEventList");
		
		return modelAndView;
		
	}
	
	

}
