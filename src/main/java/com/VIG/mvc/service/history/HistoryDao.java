package com.VIG.mvc.service.history;

import java.util.HashMap;
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
	
	public void deleteTempHistory() throws Exception;
	
	// 특정 유저가 작성한 피드들의 조회수를 일별로 카운트 한다. - > 통계 조회용
	public int getfeedHistoryDateCount(HashMap<String, String> keys)throws Exception;
	
	// 특정유저가 작성한 피드들의 프라임피드 노출 수를 일별로 카운트 한다  - > 통계 조회용
	public int getfeedHistoryPrimeDateCount(HashMap<String, String> keys)throws Exception;
	
}
