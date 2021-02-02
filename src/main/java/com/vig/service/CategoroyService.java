package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import com.vig.domain.Category;
import com.vig.repository.CategoryMapper;

@Service
public class CategoroyService {
	
	@Autowired	  
	private CategoryMapper categoryMapper;

	public CategoroyService() {
		// TODO Auto-generated constructor stub
	}


	public void addCategory(Category category) throws Exception {
		// TODO Auto-generated method stub
		categoryMapper.addCategory(category);
		
	}


	public List<Category> getAllCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return categoryMapper.getAllCategoryList();
	}

	
	public List<Category> getSearchCategoryList() throws Exception {
		
		List<Category> categoryList =  categoryMapper.getAllCategoryList();
		
		//첫 카테고리 = 추천
		categoryList.remove(0);
		
		return categoryList;
	}

}
