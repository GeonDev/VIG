package com.VIG.mvc.web.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.comment.CommentServices;
import com.VIG.mvc.service.domain.Comment;
import com.VIG.mvc.service.domain.User;

@RestController
@RequestMapping("/comment/*")
public class RestCommentController {
	@Autowired
	@Qualifier("commentServicesImpl")
	private CommentServices commentServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	public RestCommentController() {
		
	}
	@RequestMapping(value="json/addComment", method = RequestMethod.POST)
	public Comment addComment(HttpSession session, @RequestBody Map<String, String> jsonData) throws Exception{
			
		User user = (User)session.getAttribute("user");
		
		Comment comment = new Comment();
		
		comment.setFeedId(Integer.valueOf(jsonData.get("feedId")));
		comment.setUser(user);
	
		comment.setCommentText(jsonData.get("commentText"));
		
		

		commentServices.addComment(comment);
		System.out.println("추가한 댓글 : "+comment);
		
		int commentId = commentServices.getLastCommentId();
		System.out.println("마지막댓글ID : "+commentId);
		
		Comment comment2 = new Comment();
		comment2 = commentServices.getComment(commentId);
		System.out.println("보여줄댓글 :"+comment2);
		
		return comment2;
	}
	
}
