package com.VIG.mvc.service.follow.Impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.follow.FollowDao;
import com.VIG.mvc.service.follow.FollowServices;

@Service("followServiceImpl")
public class FollowServicesImpl implements FollowServices {

	@Autowired
	@Qualifier("followDaoImpl")
	private FollowDao followDao;
	
	public FollowServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addFollow(Map<String, Object> follow) throws Exception {
		// TODO Auto-generated method stub
		
		followDao.addFollow(follow);

	}

	@Override
	public void deleteFollow(Map<String, Object> follow) throws Exception {
		// TODO Auto-generated method stub
		
		followDao.deleteFollow(follow);

	}

	@Override
	public List<User> getFollowList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getFollowingList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
