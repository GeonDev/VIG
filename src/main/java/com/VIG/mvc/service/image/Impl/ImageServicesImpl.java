package com.VIG.mvc.service.image.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.image.ImageDao;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.util.CommonUtil;

@Service("imageServicesImpl")
public class ImageServicesImpl implements ImageServices {

	@Autowired
	@Qualifier("imageDaoImpl")
	private ImageDao imageDao;	
	
	
	public ImageServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addImage(Image image) throws Exception {
		// TODO Auto-generated method stub
		imageDao.addImage(image);
	}
	
	@Override
	public int getLastImageId() throws Exception {
		// TODO Auto-generated method stub
	return	imageDao.getLastImageId();
	}

	@Override
	public Image getImageOne(int imageId) throws Exception {
		// TODO Auto-generated method stub
		return imageDao.getImageOne(imageId);
	}


	@Override
	public void deleteImage(int image) throws Exception {
		// TODO Auto-generated method stub
		imageDao.deleteImage(image);
	}


	@Override
	public List<Image> getALLImageList() throws Exception {
		// TODO Auto-generated method stub	 
		
		return  imageDao.getALLImageList();
	}

	@Override
	public List<Image> getImageListFromKeyword(Search search) throws Exception {
		// TODO Auto-generated method stub
		return imageDao.getImageListFromKeyword(search);
	}

	@Override
	public List<Image> getImageListFromColor(Search search) throws Exception {
		// TODO Auto-generated method stub
		return   imageDao.getImageListFromColor(search);
	}

	@Override
	public List<Image> getImageListFromCategoroy(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  imageDao.getImageListFromCategoroy(search);
	}

	@Override
	public List<Image> getImageListFromImage(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  imageDao.getImageListFromImage(search);
	}

	@Override
	public List<String> getAutoImageKeywordList(String key) throws Exception {
		// TODO Auto-generated method stub
		return imageDao.getAutoImageKeywordList(key);
	}

}
