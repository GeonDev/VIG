package com.VIG.mvc.service.feed.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.feed.FeedServices;

@Service("feedServicesImpl")
public class FeedServicesImpl implements FeedServices {

	public FeedServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addFeed(Feed feed) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public Feed getFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Feed> getFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Feed> getmyFeedList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Feed getTempFeed(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertFeed(Feed feed) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getLastFeedId() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
