package com.VIG.mvc.service.keyword.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.keyword.KeywordDao;

@Repository("keywordDaoImpl")
public class KeywordDaoImpl implements KeywordDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public KeywordDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addKeyword(ImageKeyword keyword) throws Exception {
		sqlSession.insert("KeywordMapper.addkeyword", keyword);		
	}

	@Override
	public List<ImageKeyword> getTagList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("KeywordMapper.getTagList", userCode);
	}

	@Override
	public List<ImageKeyword> getKeywordList(int imageId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("KeywordMapper.getKeywordList", imageId);
	}

	@Override
	public void updateSaveTag(int keywordId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("KeywordMapper.updateSaveTag", keywordId);
	}

}
