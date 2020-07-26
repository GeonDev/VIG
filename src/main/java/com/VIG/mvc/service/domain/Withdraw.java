package com.VIG.mvc.service.domain;

import lombok.Data;

@Data
public class Withdraw {
	
	private int withdrawId;
	private User holder;
	private String withdrawDate;
	
	public Withdraw() {
		// TODO Auto-generated constructor stub
	}

}
