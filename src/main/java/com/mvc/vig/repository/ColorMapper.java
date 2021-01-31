package com.mvc.vig.repository;

import org.apache.ibatis.annotations.Mapper;

import com.mvc.vig.domain.ImageColor;

@Mapper
public interface ColorMapper {
	
	public void addColor(ImageColor color) throws Exception; 

}
