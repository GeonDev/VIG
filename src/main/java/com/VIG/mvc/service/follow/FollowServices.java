package com.VIG.mvc.service.follow;

import java.util.List;
import java.util.Map;

import com.VIG.mvc.service.domain.Follow;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;

public interface FollowServices {
	
	
	public void addFollow(Follow follow) throws Exception;
	
	public void deleteFollow(Follow follow) throws Exception;
	
	//나를 팔로우 한 유저 List
	public List<User> getFollowerList(String userCode) throws Exception;
	
	//내가 팔로우 한 유저 List 
	public List<User> getFollowingList(String userCode) throws Exception;
	
	public int getFollow(Follow follow) throws Exception;

}
