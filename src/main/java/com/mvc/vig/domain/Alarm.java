package com.mvc.vig.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Alarm {
	private int alarmId;
	private User sendUser;
	private User reciveUser;
	private Feed likefeed;
	private String message;
	// 0 = 확인안함 1 = 확인함
	private int isWatch;
	// 0 = 피드 좋아요, 1= 피드 댓글, 2=팔로우
	private int alarmType;
	private Date addDate;	
}
