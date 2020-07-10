package com.VIG.mvc.service.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class User {
	
	private int userCode;
	private String userName;
	private String password;
	private String role;
	private String profileImg;
	private String selfIntroduce;
	private String sex;
	private int birth;
	private String state;
	private String googleId;
	private String account;
	private int primeCount;
	private String email;
	private String variedCode;
	private Date regDate;
	
	//검색을 편하게 하기 위하여 최근 열람 정보를 별도 저장
	private List<String> currintKeyword;

}
