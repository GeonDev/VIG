package com.VIG.mvc.service.category.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.category.CategoryDao;
import com.VIG.mvc.service.category.CategoryServices;
import com.VIG.mvc.service.domain.Category;

@Service("categoroyServicesImpl")
public class CategoroyServicesImpl implements CategoryServices{
	
	@Autowired	  
	@Qualifier("catagoryDaoImpl")
	private CategoryDao categoryDao;

	public CategoroyServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addCategory(Category category) throws Exception {
		// TODO Auto-generated method stub
		categoryDao.addCategory(category);
		
	}

	@Override
	public List<Category> getAllCategoryList() throws Exception {
		// TODO Auto-generated method stub
		return categoryDao.getAllCategoryList();
	}

}
