package com.mvc.vig.domain;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class User implements Serializable{
	
	private String userCode;
	private String userName;
	private String password;
	//user, business, curator, admin 
	private String role;
	private String profileImg;
	private String selfIntroduce;

	// 0 = 없음, 1= 3일 접속금지, 2= 7일 금지, 3 = 영구정지 , 4 =탈퇴 회원 
	private int state;
	private String googleId;
	private String account;
	private int primeCount;
	private String email;
	private int variedCode;
	private Date regDate;
	//유저가 벤을 당한 날짜를 저장 - 신고 테이블과 join을 줄이기 위해 추가
	private Date banDate;

	//이메일 전송-제목,내용,받는사람
	private String subject;
    private String content;
    private String receiver;



}
