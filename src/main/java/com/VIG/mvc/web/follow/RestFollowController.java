package com.VIG.mvc.web.follow;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.follow.FollowServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.web.event.EventController;
import com.VIG.mvc.service.domain.Follow;
import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;


@RestController
@RequestMapping("/follow/*")
public class RestFollowController {
	
	public static final Logger logger = LogManager.getLogger(RestFollowController.class); 
	
	@Autowired
	@Qualifier("followServicesImpl")
	private FollowServices followServices;
	
	@Autowired
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
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
		Follow follow = new Follow();
		User followingUser = userServices.getUserOne(userCode);
		follow.setFollowingUser(followingUser);
		
		User followedUser = userServices.getUserOne(followerCode);
		follow.setFollowedUser(followedUser);
		
		
		//followServices.addFollow(follow);
		
	}
	
	@RequestMapping(value="json/deleteFollow", method=RequestMethod.GET)
	public void deleteFollow(@RequestParam("userCode") String userCode, @RequestParam("followerCode") String followerCode) throws Exception {
		
		System.out.println(userCode+":"+followerCode);
		System.out.println("unfollow함");
		Follow follow = new Follow();
		User followingUser = userServices.getUserOne(userCode);
		follow.setFollowingUser(followingUser);
		
		User followedUser = userServices.getUserOne(followerCode);
		follow.setFollowedUser(followedUser);
		
		followServices.deleteFollow(follow);

	}
	
	@RequestMapping(value="json/getFollowerList", method=RequestMethod.GET)
	public List<User> getFollowList(HttpSession session) throws Exception {
		
		
		User user = (User)session.getAttribute("user");
		
		logger.debug(user);
		
		
		List<User> follower = followServices.getFollowerList(user.getUserCode()); 
		
		logger.debug(follower);
		
		
		
		return follower;
	}

	
	

}
