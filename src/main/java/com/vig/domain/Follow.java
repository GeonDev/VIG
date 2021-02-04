package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;


@Data
public class Follow implements Serializable{
	
	private int followId;
	
	private User tagetUser;
	
	private User followUser; 
	
	private Date addDate;
	
	//맞팔로우 상태인지 알려준다
	private String isF4F;
	
	
	public Follow() {
		// TODO Auto-generated constructor stub
	}

}
