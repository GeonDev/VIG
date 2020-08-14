package com.VIG.mvc.service.like;

import java.util.HashMap;
import java.util.List;

import com.VIG.mvc.service.domain.JoinUser;

public interface LikeDao {
	public void addLike (JoinUser joinUser) throws Exception;  // 좋아요누르기
	
	public void deleteLike (JoinUser joinUser) throws Exception;  //좋아요취소
	
	public List<JoinUser> getLikeList(int feedId) throws Exception;   // 해당피드 좋아요누른 JoinUser List
	
	public JoinUser getLikeState(JoinUser joinUser);  //해당피드에 좋아요 눌렀는지 cheak
	
	//특정 일(date : '20200802')에 특정 유저(userCode : 'user01')가 작성한 피드에 좋아요를 누른 수 - 손건
	public int getLikeDateCount(HashMap<String, String> keys)throws Exception;
	
	public int getLikeCount (int feedId) throws Exception;  // 좋아요 수 받아오기
}
