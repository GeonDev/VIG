package com.VIG.mvc.service.domain;

import lombok.Data;

@Data
public class Coworker {

	private int coworkerId;
	private int feedId;	
	private User user; 	
	
	
	public Coworker() {
		// TODO Auto-generated constructor stub
	}

}
