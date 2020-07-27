package com.VIG.mvc.service.like;

import java.util.List;

import com.VIG.mvc.service.domain.JoinUser;

public interface LikeDao {
	public void addLike (JoinUser joinUser) throws Exception;  // 좋아요누르기
	
	public void deleteLike (JoinUser joinUser) throws Exception;  //좋아요취소
	
	public List<JoinUser> getLikeList(int feedId) throws Exception;   // 해당피드 좋아요누른 JoinUser List
	
	public JoinUser  getLikeState(JoinUser joinUser);  //해당피드에 좋아요 눌렀는지 cheak
}
