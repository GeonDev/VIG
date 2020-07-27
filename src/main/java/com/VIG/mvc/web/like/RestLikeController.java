package com.VIG.mvc.web.like;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.like.LikeServices;
import com.google.gson.JsonObject;

@RestController
@RequestMapping("/like/*")

public class RestLikeController {
	@Autowired
	@Qualifier("likeServicesImpl")
	private LikeServices likeServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	public RestLikeController(){
			}
	
		@RequestMapping(value="json/addLike",method = RequestMethod.POST)
		public boolean addLike(@RequestBody JoinUser joinUser,HttpSession session,int feedId)throws Exception{
			
			
			User user = (User)session.getAttribute("user");
			
			
			
			joinUser.setUser(user);
			joinUser.setIsLike(1);
			joinUser.setFeedId(feedId);
			
			boolean isLike = likeServices.getLikeState(joinUser);
			
			if(isLike ==true) {
						likeServices.addLike(joinUser);
						
			}else {
						likeServices.deleteLike(joinUser);
						
			}
			
			
			
			return isLike;
			
			
		}
	
	
	
	
	
}
