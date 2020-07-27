package com.VIG.mvc.service.like.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.like.LikeDao;

@Repository("likeDaoImpl")
public class LikeDaoImpl implements LikeDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public LikeDaoImpl() {
		
	}

	@Override
	public void addLike(JoinUser joinUser) throws Exception {
		sqlSession.insert("JoinerMapper.addJoinUser", joinUser);
		
	}

	@Override
	public void deleteLike(JoinUser joinUser) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("JoinerMapper.deleteJoinUser", joinUser);
	}

	@Override
	public List<JoinUser> getLikeList(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public JoinUser getLikeState(JoinUser joinUser) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("JoinerMapper.getLikeState",joinUser);
	}


	
	
}
