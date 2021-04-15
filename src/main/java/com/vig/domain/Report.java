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
@Table(name="report")
public class Report implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long reportId;
	
	private User violator;
	private User reporter;
	
	//신고할 유저의 정보를 받아오기 위한 처리
	private String violatorCode;
	
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


}
