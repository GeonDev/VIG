package com.VIG.mvc.service.domain;

import lombok.Data;

@Data
public class ImageKeyword {
	
	private int keywordId;
	private int imageId;
	private int isTag;
	private int userCode;
	private String keywordEn;
	private String keywordOrigin;	
	private float score;
	
	
	public ImageKeyword() {
		// TODO Auto-generated constructor stub
	}


}
