package com.vig.restController;


import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.vig.domain.Follow;
import com.vig.service.FollowService;
import com.vig.service.UserService;


@RestController
@RequestMapping("/follow/*")
public class RestFollowController {
	
	public static final Logger logger = LogManager.getLogger(RestFollowController.class); 
	
	@Autowired
	private FollowService followServices;
	
	@Autowired
	private UserService userServices;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	
	public RestFollowController(){
	}
	
	@RequestMapping(value="json/addFollow", method=RequestMethod.GET)
	public void addFollow(@RequestParam("userCode") String userCode, @RequestParam("followerCode") String followerCode) throws Exception {
		
		if(userCode != followerCode) {
		Follow follow = new Follow();
	
		follow.setTagetUser(userServices.getUserOne(userCode));

		follow.setFollowUser(userServices.getUserOne(followerCode));
		
		
		followServices.addFollow(follow);
		}
		
	}
	
	@RequestMapping(value="json/deleteFollow", method=RequestMethod.GET)
	public void deleteFollow(@RequestParam("userCode") String userCode, @RequestParam("followerCode") String followerCode) throws Exception {
		
		Follow follow = new Follow();		
		
		follow.setTagetUser(userServices.getUserOne(userCode));
		follow.setFollowUser(userServices.getUserOne(followerCode));
		
		followServices.deleteFollow(follow);

	}
	
	//나를 팔로우 하는 사람들
	@RequestMapping(value="json/getFollowerList", method=RequestMethod.GET)
	public List<Follow> getFollowList(@RequestParam("userCode") String userCode) throws Exception {
				
		
		logger.debug(userCode);
			
		List<Follow> follower = followServices.getFollowerList(userCode); 
		
		logger.debug(follower);
		
		
		
		return follower;
	}
	
	//내가 팔로우 하는 사람들
	@RequestMapping(value="json/getFollowingList", method=RequestMethod.GET)
	public List<Follow> getFollowingList(@RequestParam("userCode") String userCode) throws Exception {
		
		
		logger.debug(userCode);
		
		
		List<Follow> following = followServices.getFollowingList(userCode); 
		
		logger.debug(following);
		
		
		
		return following;
	}
	
	

}
