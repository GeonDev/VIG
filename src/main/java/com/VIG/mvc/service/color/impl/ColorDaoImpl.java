package com.VIG.mvc.service.color.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.color.ColorDao;
import com.VIG.mvc.service.domain.ImageColor;

@Repository("colorDaoImpl")
public class ColorDaoImpl implements ColorDao {
	
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public ColorDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addColor(ImageColor color) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("ColorMapper.addColor", color);
	}

}
