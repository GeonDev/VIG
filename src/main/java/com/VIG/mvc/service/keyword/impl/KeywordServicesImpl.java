package com.VIG.mvc.service.keyword.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.keyword.KeywordDao;
import com.VIG.mvc.service.keyword.KeywordServices;

@Service("keywordServicesImpl")
public class KeywordServicesImpl implements KeywordServices {
	
	@Autowired	  
	@Qualifier("keywordDaoImpl")
	private KeywordDao keywordDao;

	public KeywordServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addKeyword(ImageKeyword keyword) throws Exception {
		keywordDao.addKeyword(keyword);		
	}

	@Override
	public List<ImageKeyword> getTagList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return keywordDao.getTagList(userCode);
	}

	@Override
	public List<ImageKeyword> getKeywordList(int imageId) throws Exception {
		// TODO Auto-generated method stub
		return keywordDao.getKeywordList(imageId);
	}

	@Override
	public void updateSaveTag(int keywordId) throws Exception {
		// TODO Auto-generated method stub
		keywordDao.updateSaveTag(keywordId);
	}

	@Override
	public void addTag(ImageKeyword keyword) throws Exception {
		// TODO Auto-generated method stub
		keywordDao.addTag(keyword);
		
	}

}
