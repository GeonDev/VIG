package com.mvc.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mvc.vig.domain.Follow;


@Mapper
public interface FollowMapper {
	
	public void addFollow(Follow follow) throws Exception;
	
	public void deleteFollow(Follow follow) throws Exception;
	
	//나를 팔로우 한 유저 List
	public List<Follow> getFollowerList(String userCode) throws Exception;
	
	//내가 팔로우 한 유저 List 
	public List<Follow> getFollowingList(String userCode) throws Exception;
	
	public int getFollow(Follow follow) throws Exception;

}
