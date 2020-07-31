package com.VIG.mvc.service.history.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.history.HistoryDao;

@Repository("historyDaoImpl")
public class HistoryDaoImpl implements HistoryDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	@Override
	public List<History> getHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HistoryMapper.getHistoryListFormUser", search);
	}


	@Override
	public void addHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("HistoryMapper.addHistory", history);
		
	}


	@Override
	public int getHistoryCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HistoryMapper.getHistoryCount", search);
	}


	@Override
	public void deleteHistory(int historyId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("HistoryMapper.deleteHistory", historyId);
	}


	@Override
	public List<History> getAllHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("HistoryMapper.getAllHistoryFromUser", search);
	}


	@Override
	public int getViewHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HistoryMapper.getViewHistory", history);
	}


	@Override
	public void deleteTempHistory() throws Exception {
		sqlSession.delete("HistoryMapper.deleteTempHistory");		
	}

}
