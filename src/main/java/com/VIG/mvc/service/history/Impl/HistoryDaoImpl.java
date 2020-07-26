package com.VIG.mvc.service.history.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.history.HistoryDao;

public class HistoryDaoImpl implements HistoryDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	@Override
	public List<History> getHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void addHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("HistoryMapper.addHistory", history);
		
	}

}
