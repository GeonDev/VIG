package com.VIG.mvc.service.image;

import java.util.List;

import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.Search;

public interface ImageServices {
	
public void addImage(Image image) throws Exception;
	
	//특정 이미지 번호를 넣어 단일 조회
	public Image getImageOne(int imageId) throws Exception;
	
	//등록된 전체 이미지 받아오기 - 세팅용
	public List<Image> getALLImageList() throws Exception;
	
	//검색조건을 넣어 이미지 리스트를 출력
	public List<Image> getImageList(Search search) throws Exception;	
	
	public List<Image> getImageListfromColor(Search search) throws Exception;
	
	public void deleteImage(String image) throws Exception;

}
