package com.VIG.mvc.service.feed.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.feed.FeedDao;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.util.CommonUtil;

@Service("feedServicesImpl")
public class FeedServicesImpl implements FeedServices {
	
	@Autowired	  
	@Qualifier("feedDaoImpl")
	private FeedDao feedDao;

	public FeedServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addFeed(Feed feed) throws Exception {
		feedDao.addFeed(feed);

	}

	@Override
	public Feed getFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getFeed(feedId);
	}

	@Override
	public void deleteFeed(int feedId) throws Exception {
		feedDao.deleteFeed(feedId);
	}

	@Override
	public List<Feed> getFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		
		return feedDao.getFeedList(search);
	}

	@Override
	public Feed getTempFeed(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getTempFeed(userCode);
	}


	@Override
	public int getLastFeedId() throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getLastFeedId();
	}

	@Override
	public List<Feed> getFeedListOnlyTag(String tag) throws Exception {
		// TODO Auto-generated method stub
		
		return feedDao.getFeedListOnlyTag(tag);
	}

	@Override
	public List<Feed> getFeedListFromCategory(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  feedDao.getFeedListFromCategory(search);
	}

	@Override
	public List<Feed> getFeedListFromKeyword(Search search) throws Exception {
		
		//검색어의 대소문자를 따지지 않음
		if(!(search.getKeyword()).equals("")) {			
			search.setKeyword((search.getKeyword()).toUpperCase());
		}	
		
		List<Feed> feedlist = feedDao.getFeedListFromKeyword(search);		
		feedlist.addAll(feedDao.getFeedListFromTitle(search));			
		
		//피드 중복체크 이후 반환
		return CommonUtil.checkEqualFeed(feedlist);
	}

	@Override
	public List<Feed> getFeedListFromColor(Search search) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getFeedListFromColor(search);
	}

	@Override
	public List<String> getfeedTitleList(String key) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getfeedTitleList(key);
	}

	@Override
	public List<Feed> getMyFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  feedDao.getMyFeedList(search);
	}

	@Override
	public List<Feed> getPrimeFeed(Search search) throws Exception {
		// TODO Auto-generated method stub	
		
		List<Feed> feedList = feedDao.getPrimeFeedTitle(search);			
		
		//검색어의 대소문자를 따지지 않음
		if(!(search.getKeyword()).equals("")) {			
			search.setKeyword((search.getKeyword()).toUpperCase());
		}				

		//프라임 피드 중 검색어를 타이틀에 포함하고 있는 피드를 포함한다.
		feedList.addAll(feedDao.getPrimeFeed(search));				
		
		//피드 중복체크 이후 반환
		return CommonUtil.checkEqualFeed(feedList);
	}

	@Override
	public void updatePrimeFeedViewCount(Feed feed) throws Exception {
		// TODO Auto-generated method stub
		feedDao.updatePrimeFeedViewCount(feed);		
	}

	@Override
	public List<Feed> getHightViewFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  feedDao.getHightViewFeedList(search);
	}

	@Override
	public void updateViewCount(int feedId) throws Exception {
		// TODO Auto-generated method stub
		
		feedDao.updateViewCount(feedId);
		
	}

	@Override
	public List<Feed> getLikedFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  feedDao.getLikedFeedList(search);
	}

	@Override
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
		
		return  feedDao.getRecommendFeedList(search);
	}
	
}
