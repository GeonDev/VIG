package com.VIG.mvc.service.keyword;

import java.util.List;

import com.VIG.mvc.service.domain.ImageKeyword;

public interface KeywordServices {
	
	public void addKeyword(ImageKeyword keyword) throws Exception; 	
	
	public void addTag(ImageKeyword keyword) throws Exception; 	
	
	public List<ImageKeyword> getTagList(String userCode) throws Exception; 
	
	public List<ImageKeyword> getKeywordList(int imageId) throws Exception;
	
	public List<ImageKeyword> getFeedKeywordList(int feedId) throws Exception;
	
	public void updateSaveTag(int keywordId) throws Exception;

}
