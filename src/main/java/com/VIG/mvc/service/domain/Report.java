package com.VIG.mvc.service.domain;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class Report implements Serializable{
	
	private int reportId;
	private User violator;
	private User reporter;
	
	// 0 = 혐오표현, 1 = 음란물, 2 =모욕적인내용, 3= 저작권 침해
	private int reportType;	
	private int reportFeedId;
	private String reportMessage;
	private Date reportDate;
	// 0 = 없음, 1= 3일 접속금지, 2= 7일 금지, 3 = 영구정지 
	private int banType;
	private Date banDate;
	
	//누적 신고 횟수 
	private int totalCount;
	
	//최신 신고 횟수
	private int currentCount;
	
	

	public Report() {
		// TODO Auto-generated constructor stub
	}

}
