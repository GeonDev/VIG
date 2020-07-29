package com.VIG.mvc.web.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.comment.CommentServices;
import com.VIG.mvc.service.domain.User;

@Controller
@RequestMapping("/comment/*")

public class CommentController {
	@Autowired
	@Qualifier("commentServicesImpl")
	private CommentServices commentServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;


	public CommentController() {
		
	}
	@RequestMapping(value="deleteComment", method=RequestMethod.GET)
	public void deleteComment(HttpSession session,@RequestParam int commentId,@RequestParam("userCode") String userCode) throws Exception {
		
		User user = (User)session.getAttribute("user");
		
		String aa = user.getUserCode();
		if(aa==userCode) {
			commentServices.deleteComment(commentId);
		}
		
		 
		
		
	}
	
	
}