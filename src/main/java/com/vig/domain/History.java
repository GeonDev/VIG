package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class History implements Serializable{
	
	private int historyId;
	private User watchUser;
	private Feed showFeed;
	private Date showDate;
	private String ipAddress;
	//0 = 일반 피드 본것 1 = 숨김피드  2 = 프라임 피드 강제 노출
	private int historyType;

	public History() {
		// TODO Auto-generated constructor stub
	}

}
