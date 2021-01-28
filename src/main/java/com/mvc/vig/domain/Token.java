package com.mvc.vig.domain;

import lombok.Data;

@Data
public class Token {

	private String access_token;
	private int expires_in;
	private String refresh_token;
	private String scope;
	private String token_type;
	private String id_token;	
	
	public Token() {
		// TODO Auto-generated constructor stub
	}

	
}
