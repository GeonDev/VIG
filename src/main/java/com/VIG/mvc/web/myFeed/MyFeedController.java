package com.VIG.mvc.web.myFeed;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.feed.FeedServices;


@Controller
@RequestMapping("/myfeed/*")
public class MyFeedController {
	
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	
	public MyFeedController(){
	}
	
	@RequestMapping(value="getMyFeedList", method=RequestMethod.GET)
	public ModelAndView getMyFeedList(@RequestParam("userCode") String userCode) throws Exception {
		
		System.out.println("getMyFeedList");
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/myFeed/myFeed.jsp");
		
		return mav; 
	}
	
	
	
	

}
