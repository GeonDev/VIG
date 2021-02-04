package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.ImageKeyword;


@Mapper
public interface KeywordMapper {
	
	public void addKeyword(ImageKeyword keyword) throws Exception; 	
	
	public void addTag(ImageKeyword keyword) throws Exception; 	
	
	public List<ImageKeyword> getTagList(String userCode) throws Exception; 
	
	public List<ImageKeyword> getKeywordList(int imageId) throws Exception;
	
	public List<ImageKeyword> getFeedKeywordList(int feedId) throws Exception;
	
	public void updateSaveTag(int keywordId) throws Exception;
	
	public int getKeywordAllCount() throws Exception;

}
