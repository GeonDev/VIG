package com.vig.domain;

import lombok.Data;

@Data
public class GoogleProfile {
	
	private String id;
	private String email;
	private boolean verified_email;
	private String picture;	
}
