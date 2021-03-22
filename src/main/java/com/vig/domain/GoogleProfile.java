package com.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class GoogleProfile implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private String id;
	private String email;
	private boolean verified_email;
	private String picture;	
}
