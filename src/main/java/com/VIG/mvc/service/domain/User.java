package com.VIG.mvc.service.domain;

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
	private String sex;
	private String birth;
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
	
	//검색을 편하게 하기 위하여 최근 열람 정보를 별도 저장
	private List<String> currintKeyword;

}
