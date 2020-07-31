package com.VIG.mvc.web.follow;


import java.util.HashMap;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.follow.FollowServices;


@RestController
@RequestMapping("/follow/*")
public class RestFollowController {
	
	
	@Autowired
	@Qualifier("followServicesImpl")
	private FollowServices followServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	
	public RestFollowController(){
	}
	
	@RequestMapping(value="json/addFollow", method=RequestMethod.GET)
	public void addFollow(@RequestParam("userCode") String userCode, @RequestParam("followerCode") String followerCode) throws Exception {
		
		System.out.println(userCode+":"+followerCode);
		System.out.println("follow함");
		Map<String, Object> follow = new HashMap<String, Object>();
		follow.put("userCode", userCode);
		follow.put("followerCode", followerCode);
		
		followServices.addFollow(follow);
		
	}
	
	@RequestMapping(value="json/deleteFollow", method=RequestMethod.GET)
	public void deleteFollow(@RequestParam("userCode") String userCode, @RequestParam("followerCode") String followerCode) throws Exception {
		
		System.out.println(userCode+":"+followerCode);
		System.out.println("unfollow함");
		Map<String, Object> follow = new HashMap<String, Object>();
		follow.put("userCode", userCode);
		follow.put("followerCode", followerCode);
		
		followServices.deleteFollow(follow);

	}

	
	

}
