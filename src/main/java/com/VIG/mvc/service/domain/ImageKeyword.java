package com.VIG.mvc.service.domain;

public class ImageKeyword {
	
	private int keywordId;
	private int imageId;
	private int isTag;
	private int userId;
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


	public int getKeywordId() {
		return keywordId;
	}


	public void setKeywordId(int keywordId) {
		this.keywordId = keywordId;
	}


	public int getImageId() {
		return imageId;
	}


	public void setImageId(int imageId) {
		this.imageId = imageId;
	}


	public int getIsTag() {
		return isTag;
	}


	public void setIsTag(int isTag) {
		this.isTag = isTag;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	@Override
	public String toString() {
		return "ImageKeyword [keywordId=" + keywordId + ", imageId=" + imageId + ", isTag=" + isTag + ", userId="
				+ userId + ", keywordEn=" + keywordEn + ", keywordKr=" + keywordKr + ", score=" + score + "]";
	}

}
