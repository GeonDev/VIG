package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.ImageKeyword;
import com.vig.repository.KeywordMapper;

@Service
public class KeywordService {
	
	@Autowired	  
	private KeywordMapper keywordMapper;

	public KeywordService() {
		// TODO Auto-generated constructor stub
	}


	public void addKeyword(ImageKeyword keyword) throws Exception {
		keywordMapper.addKeyword(keyword);		
	}


	public List<ImageKeyword> getTagList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return keywordMapper.getTagList(userCode);
	}


	public List<ImageKeyword> getKeywordList(int imageId) throws Exception {
		// TODO Auto-generated method stub
		return keywordMapper.getKeywordList(imageId);
	}


	public void updateSaveTag(int keywordId) throws Exception {
		// TODO Auto-generated method stub
		keywordMapper.updateSaveTag(keywordId);
	}


	public void addTag(ImageKeyword keyword) throws Exception {
		// TODO Auto-generated method stub
		keywordMapper.addTag(keyword);
		
	}


	public List<ImageKeyword> getFeedKeywordList(int feedId) throws Exception {
		// TODO Auto-generated method stub
		return keywordMapper.getFeedKeywordList(feedId);
	}


	public int getKeywordAllCount() throws Exception {
		// TODO Auto-generated method stub
		return keywordMapper.getKeywordAllCount();
	}

}
