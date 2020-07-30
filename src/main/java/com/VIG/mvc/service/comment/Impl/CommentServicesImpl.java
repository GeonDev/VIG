package com.VIG.mvc.service.comment.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.comment.CommentDao;
import com.VIG.mvc.service.comment.CommentServices;
import com.VIG.mvc.service.domain.Comment;
import com.VIG.mvc.service.domain.Search;

@Service("commentServicesImpl")
public class CommentServicesImpl implements CommentServices{
	
	@Autowired
	@Qualifier("commentDaoImpl")
	private CommentDao commentDao;
	
	public CommentServicesImpl() {

	}

	@Override
	public void addComment(Comment comment) throws Exception {
		// TODO Auto-generated method stub
		commentDao.addComment(comment);
		
	}

	@Override
	public void deleteComment(int commentId) throws Exception {
		// TODO Auto-generated method stub
		commentDao.deleteComment(commentId);
	}

	@Override
	public List<Comment> getCommentFromFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.getCommentFromFeed(feedId);
	}

	@Override
	public List<Comment> getCommentFromUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.getCommentFromUser(search);
	}

	@Override
	public Comment getComment(int commentId) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.getComment(commentId);
	}

	@Override
	public int getLastCommentId() throws Exception {
		// TODO Auto-generated method stub
		return commentDao.getLastCommentId();
	}
	
}
