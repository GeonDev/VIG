package com.VIG.mvc.service.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class User {
	
	
	private int userId;
	private String userName;
	private String password;
	private String role;
	private String profileImg;
	private String selfIntroduce;
	private String sex;
	private int birthYear;
	private String state;
	private String googleId;
	private String account;
	private int prime_count;
	private String email;
	private String variedCode;
	private Date regDate;

}
