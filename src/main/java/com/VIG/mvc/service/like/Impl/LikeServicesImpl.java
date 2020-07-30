package com.VIG.mvc.service.like.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.like.LikeDao;
import com.VIG.mvc.service.like.LikeServices;

@Service("likeServicesImpl")
public class LikeServicesImpl implements LikeServices {

	@Autowired
	@Qualifier("likeDaoImpl")
	private LikeDao likeDao;
	
	public LikeServicesImpl() {
		
	}
	
	@Override
	public void addLike(JoinUser joinUser) throws Exception {
		likeDao.addLike(joinUser);
	}
	
	@Override
	public void deleteLike(JoinUser joinUser) throws Exception {
		// TODO Auto-generated method stub
		likeDao.deleteLike(joinUser);
	}
	
	@Override
	public List<JoinUser> getLikeUser(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public boolean getLikeState(JoinUser joinUser) {
		
		if(likeDao.getLikeState(joinUser) == null) {
			return true;
		}
		else {
			return false;
		}
	}



}
