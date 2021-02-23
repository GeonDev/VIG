package com.vig.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Feed;
import com.vig.domain.History;
import com.vig.domain.ImageKeyword;
import com.vig.domain.Search;
import com.vig.domain.User;
import com.vig.repository.FeedMapper;
import com.vig.repository.HistoryMapper;
import com.vig.util.CommonUtil;

@Service
public class FeedService {
	
	@Autowired	  
	private FeedMapper feedMapper;
	
	@Autowired
	private HistoryMapper historyMapper;
	

	public FeedService() {	}


	public void addFeed(Feed feed) throws Exception {
		
		feedMapper.addFeed(feed);

	}

	
	public Feed getFeed(int feedId) throws Exception {
		
		return feedMapper.getFeed(feedId);
	}

	
	public void deleteFeed(int feedId) throws Exception {
		
		feedMapper.deleteFeed(feedId);
	}


	public List<Feed> getFeedList(Search search) throws Exception {	
		
		return feedMapper.getFeedList(search);
	}

	
	public Feed getTempFeed(String userCode) throws Exception {
		
		return feedMapper.getTempFeed(userCode);
	}

	
	public int getLastFeedId() throws Exception {
		
		return feedMapper.getLastFeedId();
	}

	
	public List<Feed> getFeedListOnlyTag(String tag) throws Exception {
		
		return feedMapper.getFeedListOnlyTag(tag);
	}

	
	//숨김처리한 피드를 제외하고 출력
	public List<Feed> getFeedListFromCategory(Search search, User user) throws Exception {	
		
		
		List<Feed> feedlist = feedMapper.getFeedListFromCategory(search);
		
		//숨김피드는 빼준다. -> 모든 카테고리 공통
		if(user !=null) {
			Search tempSearch = new Search();
			tempSearch.setKeyword(user.getUserCode());
			tempSearch.setSearchType(1);				
			
			//숨김처리한 모든 피드리스트를 가지고 온다.
			List<History> hidelist = historyMapper.getAllHistoryFromUser(tempSearch);				
			
			if(hidelist.size() > 0) {
				for(History key : hidelist) {					
					feedlist.remove(key.getShowFeed());
				}				
			}
				
		}
		
		return feedlist;
	}
	
	//선택된 카테고리에서 출력
	public List<Feed> getFeedListFromCategory(Search search ) throws Exception {	
		
		return  feedMapper.getFeedListFromCategory(search);
	}


	public List<Feed> getFeedListFromKeyword(Search search) throws Exception {
		
		//검색어의 대소문자를 따지지 않음
		if(!(search.getKeyword()).equals("")) {			
			search.setKeyword((search.getKeyword()).toUpperCase());
		}	
		
		List<Feed> feedlist = feedMapper.getFeedListFromKeyword(search);		
		feedlist.addAll(feedMapper.getFeedListFromTitle(search));			
		
		//피드 중복체크 이후 반환
		return CommonUtil.checkEqualFeed(feedlist);
	}


	public List<Feed> getFeedListFromColor(Search search) throws Exception {
		
		return feedMapper.getFeedListFromColor(search);
	}


	public List<String> getfeedTitleList(String key) throws Exception {
		
		return feedMapper.getFeedTitleList(key);
	}

	
	public List<Feed> getMyFeedList(Search search) throws Exception {
		
		return  feedMapper.getMyFeedList(search);
	}


	public List<Feed> getPrimeFeed(Search search) throws Exception {
		List<Feed> feedList = feedMapper.getPrimeFeedTitle(search);			
		
		//검색어의 대소문자를 따지지 않음
		if(!(search.getKeyword()).equals("")) {			
			search.setKeyword((search.getKeyword()).toUpperCase());
		}				

		//프라임 피드 중 검색어를 타이틀에 포함하고 있는 피드를 포함한다.
		feedList.addAll(feedMapper.getPrimeFeed(search));				
		
		//피드 중복체크 이후 반환
		return CommonUtil.checkEqualFeed(feedList);
	}


	public void updatePrimeFeedViewCount(Feed feed) throws Exception {
		
		feedMapper.updatePrimeFeedViewCount(feed);		
	}

	
	public List<Feed> getHightViewFeedList(Search search) throws Exception {

		return  feedMapper.getHightViewFeedList(search);
	}

	
	public void updateViewCount(int feedId) throws Exception {
		// TODO Auto-generated method stub
		
		feedMapper.updateViewCount(feedId);
		
	}


	public List<Feed> getLikedFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  feedMapper.getLikedFeedList(search);
	}


	public List<Feed> getRecommendFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<ImageKeyword> list = new ArrayList<ImageKeyword>();
		
		for(ImageKeyword keywords :  search.getKeywords()) {
			//대문자로 변환
			keywords.setKeywordEn((keywords.getKeywordEn()).toUpperCase());
			list.add(keywords);
		}
		
		//대문자로 변환한 키워드 리스트 세팅
		search.setKeywords(list);
		
		return  feedMapper.getRecommendFeedList(search);
	}
	
}
