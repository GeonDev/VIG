package com.VIG.mvc.service.domain;


import lombok.Data;

@Data
public class Likes {
	
	private int likeId;
	private User likeedUser;	
	private int feedId;
	
	
	public Likes() {
		// TODO Auto-generated constructor stub
	}

}
