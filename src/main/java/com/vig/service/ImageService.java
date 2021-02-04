package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Image;
import com.vig.domain.Search;
import com.vig.repository.ImageMapper;

@Service
public class ImageService  {

	@Autowired
	private ImageMapper imageMapper;	
	
	
	public ImageService() {
		// TODO Auto-generated constructor stub
	}


	public void addImage(Image image) throws Exception {
		// TODO Auto-generated method stub
		imageMapper.addImage(image);
	}
	
	
	public int getLastImageId() throws Exception {
		// TODO Auto-generated method stub
	return	imageMapper.getLastImageId();
	}


	public Image getImageOne(int imageId) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getImageOne(imageId);
	}


	public void deleteImage(int image) throws Exception {
		// TODO Auto-generated method stub
		imageMapper.deleteImage(image);
	}


	public List<Image> getALLImageList() throws Exception {
		// TODO Auto-generated method stub	 
		
		return  imageMapper.getALLImageList();
	}


	public List<Image> getImageListFromKeyword(Search search) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getImageListFromKeyword(search);
	}


	public List<Image> getImageListFromColor(Search search) throws Exception {
		// TODO Auto-generated method stub
		return   imageMapper.getImageListFromColor(search);
	}


	public List<Image> getImageListFromCategoroy(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  imageMapper.getImageListFromCategoroy(search);
	}


	public List<Image> getImageListFromImage(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  imageMapper.getImageListFromImage(search);
	}


	public List<String> getAutoImageKeywordList(String key) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getAutoImageKeywordList(key);
	}


	public List<Image> getImageListFromImageALLKeys(Search search) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getImageListFromImageALLKeys(search);
	}

}
