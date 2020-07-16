package com.VIG.mvc.service.category;

import java.util.List;

import com.VIG.mvc.service.domain.Category;

public interface CategoryServices {
	
	public void addCategory(Category category) throws Exception; 
	
	public List<Category> getAllCategoryList() throws Exception; 

}
