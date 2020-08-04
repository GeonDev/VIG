package com.VIG.mvc.service.follow;

import java.util.List;
import java.util.Map;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;

public interface FollowDao {
	
	public void addFollow(Map<String, Object> follow) throws Exception;
	
	public void deleteFollow(Map<String, Object> follow) throws Exception;
	
	//나를 팔로우 한 유저 List
	public List<String> getFollowerList(Search search) throws Exception;
	
	//내가 팔로우 한 유저 List 
	public List<User> getFollowingList(Search search) throws Exception;
	
	public int getFollow(Map<String, Object> follow) throws Exception;

}
