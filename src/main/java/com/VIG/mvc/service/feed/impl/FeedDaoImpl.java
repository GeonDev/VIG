package com.VIG.mvc.service.feed.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public FeedDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addFeed(Feed feed) throws Exception {
		sqlSession.insert("FeedMapper.insertFeed",feed);
	}

	@Override
	public Feed getFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getFeed",feedId);
	}

	@Override
	public void deleteFeed(int feedId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FeedMapper.deleteFeed", feedId);
	}

	@Override
	public List<Feed> getFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Feed> getMyFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getMyFeedList", search);
	}

	@Override
	public Feed getTempFeed(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getTempFeed",userCode);
	}


	@Override
	public int getLastFeedId() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getlastFeedId");
	}

	@Override
	public List<Feed> getFeedListOnlyTag(String tag) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getFeedListOnlyTag",tag);
	}

	@Override
	public List<Feed> getFeedListFromCategory(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getfeedListFromCategory",search);
	}

	@Override
	public List<Feed> getFeedListFromKeyword(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getfeedListFromKeyword",search);
	}

	@Override
	public List<Feed> getFeedListFromColor(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getfeedListFromColor",search);
	}

	@Override
	public List<String> getfeedTitleList(String key) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getfeedTitleList",key);
	}

	@Override
	public Feed getPrimeFeedOne(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getPrimeFeedOne",search);
	}

	@Override
	public void updatePrimeFeedViewCount(Feed feed) throws Exception {
		sqlSession.update("FeedMapper.updatePrimeFeedViewCount", feed);
		
	}

	@Override
	public List<Feed> getFeedListFromTitle(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getfeedListFromTitle",search);
	}

	@Override
	public List<Feed> getHightViewFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getHightViewFeedList",search);
	}

	@Override
	public void updateViewCount(int feedId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FeedMapper.updateViewCount", feedId);
		
	}

	@Override
	public List<Feed> getLikedFeedList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getLikedFeedList",search);
	}
	

}
