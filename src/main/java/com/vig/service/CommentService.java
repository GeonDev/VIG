package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Comment;
import com.vig.domain.Search;
import com.vig.repository.CommentMapper;

@Service
public class CommentService {
	
	@Autowired
	private CommentMapper commentMapper;
	
	public CommentService() {

	}


	public void addComment(Comment comment) throws Exception {
		// TODO Auto-generated method stub
		commentMapper.addComment(comment);
		
	}


	public void deleteComment(int commentId) throws Exception {
		// TODO Auto-generated method stub
		commentMapper.deleteComment(commentId);
	}

	
	public List<Comment> getCommentFromFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return commentMapper.getCommentFromFeed(feedId);
	}


	public List<Comment> getCommentFromUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return commentMapper.getCommentFromUser(search);
	}


	public Comment getComment(int commentId) throws Exception {
		// TODO Auto-generated method stub
		return commentMapper.getComment(commentId);
	}


	public int getLastCommentId() throws Exception {
		// TODO Auto-generated method stub
		return commentMapper.getLastCommentId();
	}
	
}
