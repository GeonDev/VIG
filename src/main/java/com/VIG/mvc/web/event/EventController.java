package com.VIG.mvc.web.event;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public ModelAndView addEvent(Event event) throws Exception {
		
		String message = "이건 테스트용 메세지";

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("forward:/event/addEventView.jsp");
		modelAndView.addObject("message", message);
		
		return modelAndView;
		
	}
	
	

}
