package com.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class Token implements Serializable {


	private static final long serialVersionUID = 1236283424582915L;
	
	
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
