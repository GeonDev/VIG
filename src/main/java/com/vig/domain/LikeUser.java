package com.vig.domain;


import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class LikeUser implements Serializable{
	
	private int likeId;
	private User user;	
	private int feedId;

	private Date addDate;
	
	
	public LikeUser() {
		// TODO Auto-generated constructor stub
	}
	


}
