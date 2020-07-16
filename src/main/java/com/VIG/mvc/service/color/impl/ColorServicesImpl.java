package com.VIG.mvc.service.color.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.color.ColorDao;
import com.VIG.mvc.service.domain.ImageColor;

@Service("colorServicesImpl")
public class ColorServicesImpl implements com.VIG.mvc.service.color.ColorServices {

	
	@Autowired	  
	@Qualifier("colorDaoImpl")
	private ColorDao colorDao;
	
	
	public ColorServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addColor(ImageColor color) throws Exception {
		// TODO Auto-generated method stub
		colorDao.addColor(color);

	}

}
