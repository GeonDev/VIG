package com.VIG.mvc.service.like;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.domain.User;

public interface LikeServices {
	public void addLike (JoinUser joinUser) throws Exception;  // 좋아요 
	
	public void deleteLike(JoinUser joinUser) throws Exception; //좋아요 취소
	
	public List<JoinUser> getLikeUser(int feedId) throws Exception;   // 해당피드 좋아요누른 조이너리스트
	
	boolean getLikeState(JoinUser joinUser);  //해당피드에 좋아요 눌렀는지 cheak
	
	//특정 월(date : '202008')에 특정 유저(userCode : 'user01')가 작성한 피드에 좋아요를 누른 수 - 손건
	public HashMap<String,Object> getLikeMouthCount(HashMap<String, String> keys)throws Exception;
	
	public int getLikeCount (int feedId) throws Exception;  // 좋아요 수 받아오기
}
