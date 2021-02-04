package com.vig.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.LikeUser;

@Mapper
public interface LikerMapper {
	public void addLike (LikeUser likeUser) throws Exception;  // 좋아요누르기
	
	public void deleteLike (LikeUser likeUser) throws Exception;  //좋아요취소
	
	public List<LikeUser> getLikeList(int feedId) throws Exception;   // 해당피드 좋아요누른 LikeUser List
	
	public LikeUser getLikeState(LikeUser likeUser);  //해당피드에 좋아요 눌렀는지 cheak
	
	//특정 일(date : '20200802')에 특정 유저(userCode : 'user01')가 작성한 피드에 좋아요를 누른 수 - 손건
	public int getLikeMounthCount(HashMap<String, String> keys)throws Exception;
	
	public int getLikeUserCount (int feedId) throws Exception;  // 좋아요 수 받아오기
}
