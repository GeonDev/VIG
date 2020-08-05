package com.VIG.mvc.service.domain;

import java.io.Serializable;
import java.util.List;
import lombok.Data;


@Data
public class Follow implements Serializable{
	
	private int followId;
	//로그인한 유저
	private User followingUser; 
	// 팔로우 혹은 언팔로우 할 유저
	private User followedUser; 
	 //나를 팔로우 한 유저
	private List<User> followers;
	//내가 팔로우한 유저
	private List<User> followings; 
	//팔로우한 시간
	private String followDate; 
	
	public Follow() {
		// TODO Auto-generated constructor stub
	}

}
