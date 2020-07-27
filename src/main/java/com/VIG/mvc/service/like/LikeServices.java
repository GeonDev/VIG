package com.VIG.mvc.service.like;


import java.util.List;
import java.util.Map;

import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.domain.User;

public interface LikeServices {
	public void addLike (JoinUser joinUser) throws Exception;  // 좋아요 
	
	public void deleteLike(JoinUser joinUser) throws Exception; //좋아요 취소
	
	public List<JoinUser> getLikeUser(int feedId) throws Exception;   // 해당피드 좋아요누른 조이너리스트
	
	boolean getLikeState(JoinUser joinUser);  //해당피드에 좋아요 눌렀는지 cheak
	

}
