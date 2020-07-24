package com.VIG.mvc.service.domain;


import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class JoinUser implements Serializable{
	
	private int joinerId;
	private User user;	
	private int feedId;
	// 0= 협업자 1= 좋아요한 유저
	private int isLike;
	private Date addDate;
	
	
	public JoinUser() {
		// TODO Auto-generated constructor stub
	}
	
	public User getUser() {
		User user = this.user;
		user.setPassword("");
		user.setGoogleId("");
		return user;
	}

}
