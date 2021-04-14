package com.vig.domain;


import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeUser implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private long likeId;
	private User user;	
	private long feedId;

	private Date addDate;
	
	
	public LikeUser() {
		// TODO Auto-generated constructor stub
	}
	


}
