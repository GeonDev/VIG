package com.VIG.mvc.service.history;

import java.util.List;

import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Search;

public interface HistoryDao {
	
	public List<History> getHistoryList(Search search) throws Exception;
	
	public List<History> getAllHistoryList(Search search) throws Exception;
	
	public void addHistory(History history) throws Exception;
	
	public int getHistoryCount(Search search) throws Exception;
	
	public void deleteHistory(int historyId) throws Exception;
	
	public int getViewHistory(History history) throws Exception;
	
}
