package com.VIG.mvc.service.history;

import java.util.List;

import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Search;

public interface HistoryDao {
	
	public List<History> getHistoryList(Search search) throws Exception;
	
	public void addHistory(History history) throws Exception;
	
}
