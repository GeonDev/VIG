package com.VIG.mvc.service.history.Impl;

import java.util.HashMap;
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

	@Override
	public int getViewHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		return historyDao.getViewHistory(history);
	}

	@Override
	public void deleteTempHistory() throws Exception {
		historyDao.deleteTempHistory();
		
	}

	@Override
	public int[] getfeedHistoryMouthCount(HashMap<String, String> keys) throws Exception {

		int [] mouthCout = new int[31];
		
		for(int i = 0; i<31; i++) {
			String date = keys.get("date");
			
			//maria DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}						
			keys.replace("date", date);				
			
			mouthCout[i] = historyDao.getfeedHistoryDateCount(keys);		
		}	
		
		
		return mouthCout;
	}

	@Override
	public int[] getfeedHistoryPrimeDateCount(HashMap<String, String> keys) throws Exception {
		
		int [] mouthCout = new int[31];
		
		for(int i = 0; i<31; i++) {
			String date = keys.get("date");
			
			//maria DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}						
			keys.replace("date", date);				
			
			mouthCout[i] = historyDao.getfeedHistoryPrimeDateCount(keys);		
		}	
		
		
		return mouthCout;
	}

}
