package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="alarm")
public class Alarm implements Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long alarmId;
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
