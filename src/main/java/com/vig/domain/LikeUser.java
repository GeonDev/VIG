package com.vig.domain;


import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class LikeUser implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private int likeId;
	private User user;	
	private int feedId;

	private Date addDate;
	
	
	public LikeUser() {
		// TODO Auto-generated constructor stub
	}
	


}
