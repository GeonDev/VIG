package com.VIG.mvc.service.domain;

public class ImageKeyword {

	private String keywordEn;
	private String keywordKr;
	
	private float score;
	
	
	public ImageKeyword() {
		// TODO Auto-generated constructor stub
	}


	public float getScore() {
		return score;
	}


	public void setScore(float score) {
		this.score = score;
	}


	public String getKeywordEn() {
		return keywordEn;
	}


	public void setKeywordEn(String keywordEn) {
		this.keywordEn = keywordEn;
	}


	public String getKeywordKr() {
		return keywordKr;
	}


	public void setKeywordKr(String keywordKr) {
		this.keywordKr = keywordKr;
	}


	@Override
	public String toString() {
		return "ImageKeyword [keywordEn=" + keywordEn + ", keywordKr=" + keywordKr + ", score=" + score + "]";
	}

	

}
