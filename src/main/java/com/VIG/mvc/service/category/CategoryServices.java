package com.VIG.mvc.service.category;

import java.util.List;

import com.VIG.mvc.service.domain.Category;

public interface CategoryServices {
	
	public void addCategory(Category category) throws Exception; 
	
	public List<Category> getAllCategoryList() throws Exception; 
	
	// 검색 페이지에서 표기할 카테고리 (추천 제거)
	public List<Category> getSearchCategoryList() throws Exception; 


}
