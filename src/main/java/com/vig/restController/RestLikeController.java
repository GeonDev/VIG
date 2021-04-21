package com.vig.restController;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.vig.domain.LikeUser;
import com.vig.domain.User;
import com.vig.service.LikeService;

@RestController
@RequestMapping("like/*")
public class RestLikeController {
	
	@Autowired
	private LikeService likeServices;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	public RestLikeController(){}
	
	@RequestMapping(value="json/addLike/{feedId}", method = RequestMethod.GET)
	public int addLike(HttpSession session, @PathVariable int feedId )throws Exception{
					
		User user = (User)session.getAttribute("user");
		
		LikeUser likeUser = new LikeUser();
		
		likeUser.setUser(user);	
		likeUser.setFeedId(feedId);		
		
		boolean isLike = likeServices.getLikeState(likeUser);
		if(isLike) {
			likeServices.addLike(likeUser);
			System.out.println("좋아요 누름");
		}else {
			likeServices.deleteLike(likeUser);					
			System.out.println("좋아요 취소");
		}		

		
		return likeServices.getLikeCount(feedId);
	}
	
	
	
	
	
}
