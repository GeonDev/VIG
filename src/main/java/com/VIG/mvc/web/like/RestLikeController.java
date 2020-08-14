package com.VIG.mvc.web.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.like.LikeServices;
import com.google.gson.JsonObject;

@RestController
@RequestMapping("/like/*")

public class RestLikeController {
	@Autowired
	@Qualifier("likeServicesImpl")
	
	
	private LikeServices likeServices;
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	public RestLikeController(){
			}
	
		@RequestMapping(value="json/addLike",method = RequestMethod.GET)
		public int addLike(HttpSession session,@RequestParam int feedId)throws Exception{
			
			
			User user = (User)session.getAttribute("user");
			
			JoinUser joinUser = new JoinUser();
			
			joinUser.setUser(user);
			joinUser.setIsLike(1);
			joinUser.setFeedId(feedId);
			
			
			System.out.println("셋팅된 조인유저 : "+joinUser);
			boolean isLike = likeServices.getLikeState(joinUser);
			System.out.println("isLike : "+isLike);
			if(isLike ==true) {
						likeServices.addLike(joinUser);
						System.out.println("좋아요 누름");
			}else {
						likeServices.deleteLike(joinUser);					
						System.out.println("좋아요 취소");
			}
			Feed feed =feedServices.getFeed(feedId);
			int likeSize =feed.getLikes().size();
			System.out.println("좋아요 갯수 : "+likeSize);
			
		//    Map<String, Integer> myMap = new HashMap<String, Integer>();
		//	myMap.put("likeSize",likeSize);
			
			return likeSize;
		}
	
	
	
	
	
}
