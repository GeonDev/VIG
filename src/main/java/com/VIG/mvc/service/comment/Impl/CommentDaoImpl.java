package com.VIG.mvc.service.comment.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.comment.CommentDao;
import com.VIG.mvc.service.domain.Comment;
import com.VIG.mvc.service.domain.Search;

@Repository("commentDaoImpl")
public class CommentDaoImpl implements CommentDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

public CommentDaoImpl() {

}

@Override
public void addComment(Comment comment) throws Exception {
	sqlSession.insert("CommentMapper.addComment",comment);
	// TODO Auto-generated method stub
	
}

@Override
public void deleteComment(int commentId) throws Exception {
	// TODO Auto-generated method stub
	sqlSession.delete("CommentMapper.deleteComment",commentId);
	
}

@Override
public List<Comment> getCommentFromFeed(int feedId) throws Exception {
	// TODO Auto-generated method stub
	
	return sqlSession.selectList("CommentMapper.getCommentFromFeed",feedId);
}

@Override
public List<Comment> getCommentFromUser(Search search) throws Exception {
	// TODO Auto-generated method stub
	
	return sqlSession.selectList("CommentMapper.getCommentFromUser",search);
}

@Override
public Comment getComment(int commentId) throws Exception {
	// TODO Auto-generated method stub
	return sqlSession.selectOne("CommentMapper.getComment",commentId);
}

@Override
public int getLastCommentId() throws Exception {
	// TODO Auto-generated method stub
	return sqlSession.selectOne("CommentMapper.getLastCommentId");
}
}