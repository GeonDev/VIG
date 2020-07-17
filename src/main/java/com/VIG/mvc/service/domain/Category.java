package com.VIG.mvc.service.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class Category implements Serializable{

	private int categoryId;
	private String categoryName;
	private String categoryImg;
	
	public Category() {
		// TODO Auto-generated constructor stub
	}
}
