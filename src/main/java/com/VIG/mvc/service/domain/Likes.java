package com.VIG.mvc.service.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class Likes {
	
	private int likeId;
	private User likeedUser;	
	private int feedId;
	private Date likeDate;
	
	
	public Likes() {
		// TODO Auto-generated constructor stub
	}

}
