package com.VIG.mvc.service.history.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.history.HistoryDao;
import com.VIG.mvc.service.history.HistoryServices;


@Service("historyServicesImpl")
public class HistoryServicesImpl implements HistoryServices {

	@Autowired
	@Qualifier("historyDaoImpl")
	private HistoryDao historyDao;
	
	
	@Override
	public List<History> getHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return historyDao.getHistoryList(search);
	}

	@Override
	public void addHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		historyDao.addHistory(history);
		
	}

	@Override
	public int getHistoryCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return historyDao.getHistoryCount(search);
	}

	@Override
	public void deleteHistory(int historyId) throws Exception {
		// TODO Auto-generated method stub
		historyDao.deleteHistory(historyId);
		
	}

	@Override
	public List<History> getAllHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return historyDao.getAllHistoryList(search);
	}

}
