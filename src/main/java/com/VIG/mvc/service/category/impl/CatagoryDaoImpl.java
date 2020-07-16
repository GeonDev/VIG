package com.VIG.mvc.service.category.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.category.CategoryDao;
import com.VIG.mvc.service.domain.Category;

@Repository("catagoryDaoImpl")
public class CatagoryDaoImpl implements CategoryDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public CatagoryDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addCategory(Category category) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("CategoryMapper.addCategory",category);
		
	}

	@Override
	public List<Category> getAllCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("CategoryMapper.getAllCategoryList");
	}

}
