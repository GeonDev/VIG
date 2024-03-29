package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.Image;
import com.vig.domain.Search;


@Mapper
public interface ImageMapper {
	
	public void addImage(Image image) throws Exception;
	
	//특정 이미지 번호를 넣어 단일 조회
	public Image getImageOne(int imageId) throws Exception;
	
	//등록된 전체 이미지 받아오기 - 세팅용
	public List<Image> getALLImageList() throws Exception;
	
	//검색조건을 넣어 이미지 리스트를 출력
	public List<Image> getImageListFromKeyword(Search search) throws Exception;
	
	//색상을 검색조건으로 입력
	public List<Image> getImageListFromColor(Search search) throws Exception;
	
	//카테고리를 검색 조건으로 입력
	public List<Image> getImageListFromCategory(Search search) throws Exception;
	
	//이미지(키워드)를 검색 조건으로 입력
	public List<Image> getImageListFromImage(Search search) throws Exception;	
	
	//주어진 키워드를 모두 일치하는 이미지를 검색
	public List<Image> getImageListFromImageALLKeys(Search search) throws Exception;	
		
	public void deleteImage(int image) throws Exception;
	
	//이미지 키워드 자동완성
	public List<String> getAutoImageKeywordList(String key) throws Exception;
	
	//마지막 이미지의 ID get
	public int getLastImageId() throws Exception;	

	//이미지는 등록되었으나 키워드가 추출되지 않은 리스트 받아오기
	public List<Image> getImageListNoKeyword() throws Exception;
	
}


	



