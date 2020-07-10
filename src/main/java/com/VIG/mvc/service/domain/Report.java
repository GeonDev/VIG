package com.VIG.mvc.service.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Report {
	
	private int reportId;
	private User violator;
	private User repoter;
	private int reportType;	
	private int reportFeedId;
	private String reportMessage;
	private Date reportDate;
	private int banType;	
	private Date banDate;
	

	public Report() {
		// TODO Auto-generated constructor stub
	}

}
