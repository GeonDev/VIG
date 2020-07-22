package com.VIG.mvc.service.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class Image implements Serializable , Comparable<Image>{

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

	@Override
	public int compareTo(Image o) {
		//내림차순 정렬		
		if(this.currentKeywordSameCount > o.currentKeywordSameCount) {
			return -1;
		}else if(this.currentKeywordSameCount < o.currentKeywordSameCount) {
			return 1;
		}		
		
		return 0;
	}

}
