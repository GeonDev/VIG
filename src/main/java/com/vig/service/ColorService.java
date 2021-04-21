package com.vig.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.ImageColor;
import com.vig.repository.ColorMapper;

@Service
public class ColorService  {

	
	@Autowired	  
	private ColorMapper colorMapper;
	
	
	public ColorService() {
		// TODO Auto-generated constructor stub
	}

	
	public void addColor(ImageColor color) throws Exception {
		// TODO Auto-generated method stub
		colorMapper.addColor(color);

	}

}
