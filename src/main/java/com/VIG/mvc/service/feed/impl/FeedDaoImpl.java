package com.VIG.mvc.service.feed.impl;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.feed.FeedDao;



@Repository("feedDaoImpl")
public class FeedDaoImpl implements FeedDao {
	
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public FeedDaoImpl() {
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
