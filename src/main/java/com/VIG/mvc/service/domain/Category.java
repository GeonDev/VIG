package com.VIG.mvc.service.domain;

public class Category {

	private int categoryId;
	private String categoryName;
	private String categoryImg;
	
	public Category() {
		// TODO Auto-generated constructor stub
	}

	
	
	public int getCategoryId() {
		return categoryId;
	}



	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}



	public String getCategoryName() {
		return categoryName;
	}



	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}



	public String getCategoryImg() {
		return categoryImg;
	}



	public void setCategoryImg(String categoryImg) {
		this.categoryImg = categoryImg;
	}



	@Override
	public String toString() {
		return "Category [categoryId=" + categoryId + ", categoryName=" + categoryName + ", categoryImg=" + categoryImg
				+ "]";
	}
	
	

}
