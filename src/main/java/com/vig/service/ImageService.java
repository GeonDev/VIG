package com.vig.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.vig.domain.Image;
import com.vig.domain.ImageInfo;
import com.vig.domain.Search;
import com.vig.repository.ImageRepository;
import com.vig.util.CommonUtil;

@Service
public class ImageService  {

	@Autowired
	private ImageRepository imageMapper;	
	
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
		List<Image> ImageList = imageMapper.getImageListFromKeyword(search);
		
		//이미지 순서 섞기 -> 검색결과가 다르게 보이도록
		Collections.shuffle(ImageList);
		
		return ImageList;
	}


	public List<Image> getImageListFromColor(Search search) throws Exception {
		// TODO Auto-generated method stub
		return   imageMapper.getImageListFromColor(search);
	}


	public List<Image> getImageListFromCategory(Search search) throws Exception {
		// TODO Auto-generated method stub
		return  imageMapper.getImageListFromCategory(search);
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
	
	public List<ImageInfo> getImageListNoKeyword(ServletContext context, String  uploadPath, String realPath) throws Exception {
		// TODO Auto-generated method stub
		List<Image> list = imageMapper.getImageListNoKeyword();
		List<ImageInfo> remainImage = new ArrayList<ImageInfo>();
		String path = CommonUtil.getFilePath(context, uploadPath, realPath);
		
		for(Image image : list ) {
			remainImage.add(new ImageInfo(image.getImageId(), path+image.getImageFile() ) );
		}
		return remainImage;
	}

}
