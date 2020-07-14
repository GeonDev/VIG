package com.VIG.mvc.service.image.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.image.ImageDao;
import com.VIG.mvc.service.image.ImageServices;

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
	public Image getImage(int imageId) throws Exception {
		// TODO Auto-generated method stub
		return imageDao.getImage(imageId);
	}

	@Override
	public List<Image> getImageList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteImage(String image) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Image> getImageListfromColor(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
