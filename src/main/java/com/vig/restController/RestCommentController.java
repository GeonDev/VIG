package com.vig.restController;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.vig.domain.Comment;
import com.vig.domain.User;
import com.vig.service.CommentService;

@RestController
@RequestMapping("comment/*")
public class RestCommentController {
	
	@Autowired
	private CommentService commentServices;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
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
		
		
		//추가한 댓글
		commentServices.addComment(comment);
		
		//보여줄 댓글
		int commentId = commentServices.getLastCommentId();	
		Comment comment2 = new Comment();
		comment2 = commentServices.getComment(commentId);

		
		return comment2;
	}
	@RequestMapping(value="json/deleteComment", method = RequestMethod.GET)
	public void deleteComment(HttpSession session, @RequestParam("commentId") int commentId, @RequestParam("userCode") String userCode, @RequestParam("feedId") int feedId) throws Exception {
		
		commentServices.deleteComment(commentId);
	}
}
