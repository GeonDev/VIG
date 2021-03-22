package com.vig.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.LikeUser;
import com.vig.repository.LikerMapper;

@Service
public class LikeService  {

	@Autowired
	private LikerMapper likeMapper;
	
	public LikeService() {	}
	

	public void addLike(LikeUser likeUser) throws Exception {
		likeMapper.addLike(likeUser);
	}
	

	public void deleteLike(LikeUser likeUser) throws Exception {
		// TODO Auto-generated method stub
		likeMapper.deleteLike(likeUser);
	}
	

	public List<LikeUser> getLikeUser(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

	public boolean getLikeState(LikeUser likeUser) {
		
		if(likeMapper.getLikeState(likeUser) == null) {
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
			
			//DB Data_form에 맞추어 날짜 세팅
			if(i+1 <10 ) {
				date += "0"+ String.valueOf(i+1);
			}else {
				date += String.valueOf(i+1);
			}
			
			//연산된 날짜 추가
			dateKey.put("date", date);	
			totalCount +=  likeMapper.getLikeMounthCount(dateKey);			
			mouthCout.add( String.valueOf(likeMapper.getLikeMounthCount(dateKey)) );						
		}
		
		 HashMap<String,Object> lastKey = new HashMap<String,Object>();
		 lastKey.put("totalCount",totalCount);
		 lastKey.put("mouthCout",mouthCout);
		 
		return lastKey;
	}


	public int getLikeCount(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return likeMapper.getLikeUserCount(feedId);	
	}



}
