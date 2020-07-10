package com.VIG.mvc.service.domain;

import java.util.List;

import lombok.Data;

@Data
public class Search {
	
	//이미지 검색시 입력된 검색어 + 최근 열람 이미지 키워드도 보냄)
	private List<String> keywords;
	private int r;
	private int g;
	private int b;
	private int searchType;
	private int currentPage;
	private int pageSize;
	private ImageColor color;


	
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

	

}
