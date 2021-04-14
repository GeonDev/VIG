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
public class Follow implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private long followId;
	
	private User tagetUser;
	
	private User followUser; 
	
	private Date addDate;
	
	//맞팔로우 상태인지 알려준다
	private String isF4F;
	
	
	public Follow() {
		// TODO Auto-generated constructor stub
	}

}
