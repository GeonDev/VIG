package com.VIG.mvc.service.feed.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.feed.FeedDao;
import com.VIG.mvc.service.feed.FeedServices;

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
		return feedDao.getFeedListFromCategory(search);
	}

	@Override
	public List<Feed> getFeedListFromKeyword(Search search) throws Exception {
		
		List<Feed> list = feedDao.getFeedListFromKeyword(search);		
		list.addAll(feedDao.getFeedListFromTitle(search));
				
		//중복값 제거 용 HashSET
		HashSet<Feed> tempSet = new HashSet<Feed>(list);		
		list = new ArrayList<Feed>(tempSet);
		
		return list;
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
		return feedDao.getMyFeedList(search);
	}

	@Override
	public Feed getPrimeFeedOne(Search search) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getPrimeFeedOne(search);
	}

	@Override
	public void updatePrimeFeedViewCount(Feed feed) throws Exception {
		// TODO Auto-generated method stub
		feedDao.updatePrimeFeedViewCount(feed);
		
	}

	@Override
	public List<Feed> getHightViewFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getHightViewFeedList(search);
	}


}
