package com.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class Category implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;

	private int categoryId;
	private String categoryName;
	private String categoryImg;
	
	public Category() {
		// TODO Auto-generated constructor stub
	}
}
