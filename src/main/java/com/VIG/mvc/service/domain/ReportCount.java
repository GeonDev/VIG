package com.VIG.mvc.service.domain;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;

@Data
public class ReportCount implements Serializable{

	private User violator;
	private int currentReportCount;
	private int totalReportCount;

	public ReportCount() {
		// TODO Auto-generated constructor stub
	}

}
