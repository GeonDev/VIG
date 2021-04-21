package com.vig.repository;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.ImageColor;

@Mapper
public interface ColorMapper {
	
	public void addColor(ImageColor color) throws Exception; 

}
