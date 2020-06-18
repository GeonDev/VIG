package com.VIG.mvc.web.Vision;

public class ImageKeyword {

	private String keyword;
	
	private float score;
	
	
	public ImageKeyword() {
		// TODO Auto-generated constructor stub
	}


	public String getKeyword() {
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public float getScore() {
		return score;
	}


	public void setScore(float score) {
		this.score = score;
	}


	@Override
	public String toString() {
		return "ImageKeyword [keyword=" + keyword + ", score=" + score + "]";
	}
}
