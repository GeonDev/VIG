package com.vig.domain;


import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class JoinUser implements Serializable{
	
	private int joinId;
	private User user;	
	private int feedId;

	private Date addDate;
	
	
	public JoinUser() {
		// TODO Auto-generated constructor stub
	}
	


}
