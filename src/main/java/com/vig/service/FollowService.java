package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Follow;
import com.vig.repository.FollowMapper;


@Service
public class FollowService  {

	@Autowired
	private FollowMapper followMapper;
	
	public FollowService() {
		// TODO Auto-generated constructor stub
	}


	public void addFollow(Follow follow) throws Exception {
		// TODO Auto-generated method stub
		
		followMapper.addFollow(follow);

	}


	public void deleteFollow(Follow follow) throws Exception {
		// TODO Auto-generated method stub
		
		followMapper.deleteFollow(follow);

	}


	public List<Follow> getFollowerList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return followMapper.getFollowerList(userCode);
	}


	public List<Follow> getFollowingList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return followMapper.getFollowingList(userCode);
	}
	
	public int getFollow(Follow follow) throws Exception{
		
		return followMapper.getFollow(follow);
		
	}

}
