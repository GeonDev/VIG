package com.VIG.mvc.service.feed;

import java.util.List;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Search;

public interface FeedDao {
	
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
	
	public List<String> getfeedTitleList(String key) throws Exception;	
	
	public Feed getPrimeFeedOne(Search search) throws Exception;

}
