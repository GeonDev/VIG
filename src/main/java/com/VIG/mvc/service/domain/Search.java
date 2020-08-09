package com.VIG.mvc.service.domain;

import java.util.List;

import lombok.Data;

@Data
public class Search {
		
	//이미지 검색시 입력된 검색어	
	private String keyword;
	
	// 최근 열람 이미지 키워드 또는 연관 이미지 검색시 사용
	private List<ImageKeyword> keywords;

	private int searchType;
	private int currentPage;
	private int pageSize;
	private int colorRange;
	private int currentDate;
	
	//색상값 입력시 매핑
	private ImageColor color;
	
	//검색 옵션 지정시 필요 - ex) 카테고리
	private String searchCondition;

	
	public Search() {
		// TODO Auto-generated constructor stub
	}
	
	//==> Select Query 시 ROWNUM 시작 값
	public int getStartRowNum() {
		return ((this.currentPage - 1) * this.pageSize) +1;
	}
		
	//==> Select Query 시 ROWNUM 마지막 값 
	public int getEndRowNum() {
		return (this.currentPage * this.pageSize);
	}

	public int getStartRed() {
		if((color.getRed()-colorRange) > 0) {
			return (int) (color.getRed()-colorRange);
		}else
			return 0;
	}
	
	public int getEndRed() {
		if((color.getRed()+colorRange) < 255) {
			return (int) (color.getRed()+colorRange);
		}else
			return 255;
	}
	
	public int getStartGreen() {
		if((color.getGreen()-colorRange) > 0) {
			return (int) (color.getGreen()-colorRange);
		}else
			return 0;
	}
	
	public int getEndGreen() {
		if((color.getGreen()+colorRange) < 255) {
			return (int) (color.getGreen()+colorRange);
		}else
			return 255;
	}
	
	public int getStartBlue() {
		if((color.getBlue()-colorRange) > 0) {
			return (int) (color.getBlue()-colorRange);
		}else
			return 0;
	}
	
	public int getEndBlue() {
		if((color.getBlue()+colorRange) < 255) {
			return (int) (color.getBlue()+colorRange);
		}else
			return 255;
	}

}
