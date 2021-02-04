package com.vig.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.History;
import com.vig.domain.Search;
import com.vig.repository.HistoryMapper;


@Service
public class HistoryService {

	@Autowired
	private HistoryMapper historyMapper;
	
	

	public List<History> getHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return historyMapper.getHistoryList(search);
	}


	public void addHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		
		//일반 피드 열람 시 
		if(history.getHistoryType() == 0 && history.getWatchUser() != null) {
		
			History check =  historyMapper.checkHistory(history);
			
			//이전에 같은 피드를 본 기록이 있다면 삭제
			if(check != null) {
				historyMapper.deleteHistory(check.getHistoryId());
			}			
			
		}
		
		//새로운 히스토리 기록으로 갱신
		historyMapper.addHistory(history);
		
	}


	public int getHistoryCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return historyMapper.getHistoryCount(search);
	}


	public void deleteHistory(int historyId) throws Exception {
		// TODO Auto-generated method stub
		historyMapper.deleteHistory(historyId);
		
	}


	public List<History> getAllHistoryList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return historyMapper.getAllHistoryList(search);
	}


	public int getViewHistory(History history) throws Exception {
		// TODO Auto-generated method stub
		return historyMapper.getViewHistory(history);
	}


	public void deleteTempHistory() throws Exception {
		historyMapper.deleteTempHistory();
		
	}


	public HashMap<String,Object> getfeedHistoryMouthCount(HashMap<String, String> keys) throws Exception {

		List<String> mouthCout = new ArrayList<String>();
		int totalCount = 0;
		for(int i = 0; i<31; i++) {
			HashMap<String, String> dateKey = new HashMap<String, String>();
			dateKey.put("userCode", keys.get("userCode"));
			
			String date = keys.get("date");
			
			//maria DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}						
			dateKey.put("date", date);		
			
			totalCount +=  historyMapper.getfeedHistoryDateCount(dateKey);
			mouthCout.add(String.valueOf(historyMapper.getfeedHistoryDateCount(dateKey)) );
		}	
		HashMap<String,Object> lastKey = new HashMap<String,Object>();
		 lastKey.put("totalCount",totalCount);
		 lastKey.put("mouthCout",mouthCout);
		
		return lastKey;
	}


	public HashMap<String,Object> getfeedHistoryPrimeDateCount(HashMap<String, String> keys) throws Exception {
		
		List<String> mouthCout = new ArrayList<String>();
		int totalCount = 0;
		
		for(int i = 0; i<31; i++) {
			HashMap<String, String> dateKey = new HashMap<String, String>();
			
			dateKey.put("userCode", keys.get("userCode"));
			
			String date = keys.get("date");
			
			//maria DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}
			
			dateKey.put("date", date);				
			totalCount +=  historyMapper.getfeedHistoryPrimeDateCount(dateKey);
			mouthCout.add( String.valueOf(historyMapper.getfeedHistoryPrimeDateCount(dateKey)) );	
		}	
		HashMap<String,Object> lastKey = new HashMap<String,Object>();
		 lastKey.put("totalCount",totalCount);
		 lastKey.put("mouthCout",mouthCout);
		
		return lastKey;
	}

}
