package com.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class GoogleProfile implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;L;
	
	private String id;
	private String email;
	private boolean verified_email;
	private String picture;	
}
