package com.VIG.mvc.service.like.Impl;

import java.util.ArrayList;
import java.util.HashMap;
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

	@Override
	public List<String> getLikeMouthCount(HashMap<String, String> keys) throws Exception {
		// TODO Auto-generated method stub

		List<String> mouthCout = new ArrayList<String>();
		
		for(int i = 0; i<31; i++) {
			HashMap<String,String> key = new HashMap<String,String>();
			keys.put("userCode", keys.get("userCode"));
		
			String date = keys.get("date");
			
			//maria DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}						
			key.put("date", date);	
		
			System.out.println(key.get("date") );
			
			mouthCout.add(  String.valueOf(likeDao.getLikeDateCount(key)) );
					
		}	
		
		
		return mouthCout;
	}



}
