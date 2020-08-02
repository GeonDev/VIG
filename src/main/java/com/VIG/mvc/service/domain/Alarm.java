package com.VIG.mvc.service.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Alarm {
	private int alarmId;
	private User sendUser;
	private User reciveUser;
	private Feed likefeed;
	private String message;
	private int isWatch;
	private int alarmType;
	private Date showDate;	
}
