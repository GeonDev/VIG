package com.VIG.mvc.service.image;

import java.util.List;

import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.Search;

public interface ImageServices {
	
public void addImage(Image image) throws Exception;
	
	//특정 이미지 번호를 넣어 단일 조회
	public Image getImage(int imageId) throws Exception;
	
	//검색조건을 넣어 이미지 리스트를 출력
	public List<Image> getImageList(Search search) throws Exception;	
	
	public void deleteImage(Image image) throws Exception;

}
