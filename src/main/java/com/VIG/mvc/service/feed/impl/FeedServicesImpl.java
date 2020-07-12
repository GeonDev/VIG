package com.VIG.mvc.service.feed.impl;

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
	public List<Feed> getMyFeedList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return feedDao.getMyFeedList(userCode);
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

}
