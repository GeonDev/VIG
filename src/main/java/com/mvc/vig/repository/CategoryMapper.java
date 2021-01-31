package com.mvc.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mvc.vig.domain.Category;


@Mapper
public interface CategoryMapper {
	
	public void addCategory(Category category) throws Exception; 
	
	public List<Category> getAllCategoryList() throws Exception; 

}
