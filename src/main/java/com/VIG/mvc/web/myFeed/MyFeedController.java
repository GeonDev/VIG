package com.VIG.mvc.web.myFeed;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.follow.FollowServices;
import com.VIG.mvc.service.user.UserServices;


@Controller
@RequestMapping("/myfeed/*")
public class MyFeedController {
	
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;
	
	@Autowired
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
	@Autowired
	@Qualifier("followServicesImpl")
	private FollowServices followServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	
	public MyFeedController(){
	}
	
	@RequestMapping(value="getMyFeedList", method=RequestMethod.GET)
	public ModelAndView getMyFeedList(@RequestParam(value="userCode") String userCode) throws Exception {
				
		
		//작성자 정보를 가져옴
		User writer = userServices.getUserOne(userCode);	
		
		
		ModelAndView mav = new ModelAndView();	
		
		mav.setViewName("forward:/myFeed/getMyFeedList.jsp");
		mav.addObject("writer", writer);		
		
		return mav; 
	}
	
	
	// Post 방식 전송 -> 피드 작성후에만 사용
	@RequestMapping(value="getMyFeedList", method=RequestMethod.POST)
	public ModelAndView getMyFeedList(HttpSession session) throws Exception {
		
		User writer = (User)session.getAttribute("user");
					
		ModelAndView mav = new ModelAndView();	
		
		mav.setViewName("forward:/myFeed/getMyFeedList.jsp");
		mav.addObject("writer", writer);	
		mav.addObject("follower", followServices.getFollowerList(writer.getUserCode()));
		mav.addObject("following", followServices.getFollowingList(writer.getUserCode()));		
	
		return mav; 
	}

	@RequestMapping(value="getFollowerList", method=RequestMethod.GET)
	public ModelAndView getFollowerList(@RequestParam(value="userCode") String userCode) throws Exception {
						
		//작성자 정보를 가져옴
		User writer = userServices.getUserOne(userCode);			
		
		ModelAndView mav = new ModelAndView();	
		
		mav.setViewName("forward:/myFeed/getFollowList.jsp");
		mav.addObject("writer", writer);
		mav.addObject("type", "팔로워");
		mav.addObject("follow", followServices.getFollowerList(writer.getUserCode()));	
		
		return mav; 
	}
	
	@RequestMapping(value="getFollowingList", method=RequestMethod.GET)
	public ModelAndView getFollowingList(@RequestParam(value="userCode") String userCode) throws Exception {
						
		//작성자 정보를 가져옴
		User writer = userServices.getUserOne(userCode);			
		
		ModelAndView mav = new ModelAndView();	
		
		mav.setViewName("forward:/myFeed/getFollowList.jsp");
		mav.addObject("writer", writer);
		mav.addObject("type", "팔로잉");
		mav.addObject("follow", followServices.getFollowingList(writer.getUserCode()));

		
		return mav; 
	}
	
	
	

}
