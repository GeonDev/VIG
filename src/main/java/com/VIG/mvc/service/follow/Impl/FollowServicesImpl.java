package com.VIG.mvc.service.follow.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Follow;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.follow.FollowDao;
import com.VIG.mvc.service.follow.FollowServices;


@Service("followServicesImpl")
public class FollowServicesImpl implements FollowServices {

	@Autowired
	@Qualifier("followDaoImpl")
	private FollowDao followDao;
	
	public FollowServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addFollow(Follow follow) throws Exception {
		// TODO Auto-generated method stub
		
		followDao.addFollow(follow);

	}

	@Override
	public void deleteFollow(Follow follow) throws Exception {
		// TODO Auto-generated method stub
		
		followDao.deleteFollow(follow);

	}

	@Override
	public List<Follow> getFollowerList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return followDao.getFollowerList(userCode);
	}

	@Override
	public List<Follow> getFollowingList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return followDao.getFollowingList(userCode);
	}
	
	public int getFollow(Follow follow) throws Exception{
		
		return followDao.getFollow(follow);
		
	}

}
