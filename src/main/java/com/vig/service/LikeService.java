package com.vig.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.JoinUser;
import com.vig.repository.LikerMapper;

@Service
public class LikeService  {

	@Autowired
	private LikerMapper likeMapper;
	
	public LikeService() {
		
	}
	

	public void addLike(JoinUser joinUser) throws Exception {
		//likeMapper.addLike(joinUser);
	}
	

	public void deleteLike(JoinUser joinUser) throws Exception {
		// TODO Auto-generated method stub
		//likeMapper.deleteLike(joinUser);
	}
	

	public List<JoinUser> getLikeUser(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

	public boolean getLikeState(JoinUser joinUser) {
		
		if(likeMapper.getLikeState(joinUser) == null) {
			return true;
		}
		else {
			return false;
		}
	}


	public HashMap<String,Object> getLikeMouthCount(HashMap<String, String> keys) throws Exception {

		List<String> mouthCout = new ArrayList<String>();
		int totalCount = 0;
		
		for(int i = 0; i<31; i++) {
			HashMap<String,String> dateKey = new HashMap<String,String>();
			
			//유저 코드를 추가
			dateKey.put("userCode", keys.get("userCode"));
		
			String date = keys.get("date");
			
			//maria DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}
			
			//연산된 날짜 추가
			dateKey.put("date", date);	
			//totalCount +=  likeMapper.getLikeDateCount(dateKey);			
			//mouthCout.add( String.valueOf(likeMapper.getLikeDateCount(dateKey)) );						
		}
		
		 HashMap<String,Object> lastKey = new HashMap<String,Object>();
		 lastKey.put("totalCount",totalCount);
		 lastKey.put("mouthCout",mouthCout);
		 
		return lastKey;
	}


	public int getLikeCount(int feedId) throws Exception {
		// TODO Auto-generated method stub
		//return likeMapper.getLikeCount(feedId);
		return 0;
	}



}
