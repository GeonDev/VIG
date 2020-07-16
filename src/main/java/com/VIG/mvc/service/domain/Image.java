package com.VIG.mvc.service.domain;

import java.util.List;

import lombok.Data;

@Data
public class Image {

	private int imageId;
	private int feedId;
	private int feedOrder;
	private int isThumbnail;
	private String imageFile;
	private List<ImageColor> color;
	private List<ImageKeyword> keyword;
	
	//최근 검색 키워드와 겹치는 개수 - 검색시 정렬용으로 사용
	private int currentKeywordSameCount;
	
	public Image() {
		// TODO Auto-generated constructor stub
	}

}
