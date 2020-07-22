package com.VIG.mvc.web.follow;


import java.util.HashMap;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.follow.FollowServices;


@Controller
@RequestMapping("/follow/*")
public class FollowController {
	
	
	@Autowired
	@Qualifier("followServicesImpl")
	private FollowServices followServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	
	public FollowController(){
	}
	
	@RequestMapping(value="addFollow", method=RequestMethod.GET)
	public ModelAndView addFollow(@RequestParam("userCode") String userCode, @RequestParam("followerCode") String followerCode) throws Exception {
		
		System.out.println(userCode+":"+followerCode);
		Map<String, Object> follow = new HashMap<String, Object>();
		follow.put("userCode", userCode);
		follow.put("followerCode", followerCode);
		
		followServices.addFollow(follow);

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect:../feed/feedController/getFeed?feedId=20000");
		
		return modelAndView;
		
	}
	

	
	

}
