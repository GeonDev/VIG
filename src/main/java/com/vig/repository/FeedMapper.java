package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.Feed;
import com.vig.domain.Search;


@Mapper
public interface FeedMapper {
	
	public void addFeed(Feed feed) throws Exception; 
	
	public Feed getFeed(int feedId) throws Exception;
	
	public void deleteFeed(int feedId) throws Exception;
	
	public List<Feed> getFeedList(Search search) throws Exception;	
	
	public List<Feed> getMyFeedList(Search search) throws Exception;	
	
	public Feed getTempFeed(String userCode) throws Exception;	
	
	public int getLastFeedId() throws Exception;
	
	public List<Feed> getFeedListOnlyTag(String tag) throws Exception;
	
	public List<Feed> getFeedListFromCategory(Search search) throws Exception;	
	
	public List<Feed> getFeedListFromKeyword(Search search) throws Exception;	
	
	public List<Feed> getFeedListFromColor(Search search) throws Exception;	
	
	public List<String> getFeedTitleList(String key) throws Exception;	
	
	public List<Feed> getPrimeFeed(Search search) throws Exception;
	
	public List<Feed> getHightViewFeedList(Search search) throws Exception;	
	
	public List<Feed> getLikedFeedList(Search search) throws Exception;	
	
	public List<Feed> getRecommendFeedList(Search search) throws Exception;	
	
	public void updatePrimeFeedViewCount(Feed feed) throws Exception;
	
	
	
	public void updateViewCount(int feedId) throws Exception;
	

}
