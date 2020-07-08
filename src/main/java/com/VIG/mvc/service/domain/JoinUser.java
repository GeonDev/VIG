package com.VIG.mvc.service.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class JoinUser {
	
	private int joinerId;
	private User user;	
	private int feedId;
	private int isLike;
	private Date addDate;
	
	
	public JoinUser() {
		// TODO Auto-generated constructor stub
	}

}
