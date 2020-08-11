package com.VIG.mvc.util;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;

import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.web.feed.FeedController;
import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.ColorInfo;
import com.google.cloud.vision.v1.DominantColorsAnnotation;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.protobuf.ByteString;


// 작동을 위해서는 API 키를 적용하야 합니다.
// Run As - Run Configurations - Environment - New 
public class VisionInfo extends Thread {	
	
	public static final Logger logger = LogManager.getLogger(VisionInfo.class); 
	
	private static final float targetScore = 0.01f;
	
	private static final int colorRange = 30;
	
	private String imageFilePath;
	private List<ImageKeyword> keywords;
	private List<ImageColor> colors;
	private int imageId;
	
	
	public VisionInfo() {}	
	
	public VisionInfo(String imageFilePath, int imageId) {
		this.imageFilePath = imageFilePath;	
		this.imageId = imageId;
		colors = new ArrayList<ImageColor>();
		keywords = new ArrayList<ImageKeyword>();
	}	
	
	public List<ImageKeyword> getKeywords(){
		return keywords;
	}
	
	public List<ImageColor> getColors(){
		return colors;
	}
	
	
	//이미지의 키워드를 추출하는 함수
	private void getKeywordForVision() {			
		requestVision(Type.TEXT_DETECTION);
		requestVision(Type.LABEL_DETECTION);
		requestVision(Type.LANDMARK_DETECTION);
		requestVision(Type.LOGO_DETECTION);		
	}	
	
	//이미지의 색상정보를 추출하는 함수
	private void getColorForVision() {				
		requestVision(Type.IMAGE_PROPERTIES);		
	}
	

	private void requestVision(Type type) {		
		try {		
			
			List<AnnotateImageRequest> requests = new ArrayList<>();
		
			ByteString imgBytes = ByteString.readFrom(new FileInputStream(imageFilePath));
		
			Image img = Image.newBuilder().setContent(imgBytes).build();
		
			Feature feat = Feature.newBuilder().setType(type).build();
			
			AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
			requests.add(request);
		
			try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
				
				BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			    List<AnnotateImageResponse> responses = response.getResponsesList();
		
			    for (AnnotateImageResponse res : responses) {
			    	if (res.hasError()) {
			    		System.out.printf("Error: %s\n", res.getError().getMessage());			    		
			    		return;
			    	}		    	
			    	if(type == Type.IMAGE_PROPERTIES) {				    		
			    		addColorList(type, res);
			    	}else {
			    		addKeywordList(type, res);	
			    	}
			    			    	
			    }		    
		
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
				
	}	
	
	private void addColorDataList(ColorInfo color) {
		ImageColor imageColor = new ImageColor();	
		
		imageColor.setImageId(imageId);
		
		imageColor.setRed((int) (color.getColor().getRed()/colorRange)*colorRange);		
		imageColor.setGreen((int)(color.getColor().getGreen()/colorRange)*colorRange);
		imageColor.setBlue((int)(color.getColor().getBlue()/colorRange)*colorRange);
		imageColor.setRatio(color.getPixelFraction());		
		
		String haxcode ="#";		
		haxcode += getHaxcode((int) (color.getColor().getRed()/colorRange)*colorRange);
		haxcode += getHaxcode((int) (color.getColor().getGreen()/colorRange)*colorRange);
		haxcode += getHaxcode((int) (color.getColor().getBlue()/colorRange)*colorRange);		
		
		imageColor.setHaxcode(haxcode);
		
		colors.add(imageColor);
	}
	
	
	
	private void addKeywordList(Type type, AnnotateImageResponse res) {

		if (type == Type.TEXT_DETECTION) {
			for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
				addkeywoad(annotation);
			}
		} else if (type == Type.LABEL_DETECTION) {
			for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
				addkeywoad(annotation);
			}
		} else if (type == Type.LANDMARK_DETECTION) {
			for (EntityAnnotation annotation : res.getLandmarkAnnotationsList()) {
				addkeywoad(annotation);
			}
		} else if (type == Type.LOGO_DETECTION) {
			for (EntityAnnotation annotation : res.getLogoAnnotationsList()) {
				addkeywoad(annotation);
			}
		}
	}
	
	private  void addkeywoad(EntityAnnotation annotation) {
		ImageKeyword imageKeyword = new ImageKeyword();		
		
		if ((annotation.getScore()) > targetScore) {
			imageKeyword.setKeywordEn(annotation.getDescription());	
			imageKeyword.setScore(annotation.getScore());
			imageKeyword.setImageId(imageId);
			keywords.add(imageKeyword);
		}
		
		logger.debug(imageId +" 키워드 세팅완료" );
	}
	
	
	private void addColorList(Type type, AnnotateImageResponse res) {	
		DominantColorsAnnotation colorList = res.getImagePropertiesAnnotation().getDominantColors();
		for(ColorInfo color : colorList.getColorsList()) {
			if((color.getPixelFraction()) > targetScore) {
				addColorDataList(color);
			}			
		}
		
		logger.debug(imageId +" 색상 세팅완료" );
	}
	
	private String getHaxcode(int num) {		
		
		String hax = Integer.toHexString(num);
		if(hax.length() == 1) {
			String temp = "0";
			temp += hax;
			hax = temp; 
		}
		
		return hax;
	}
	
	

	@Override
	public void run() {		
		getKeywordForVision();
		getColorForVision();	
		
	}
	
	
	public void setVisionData() {		
		getKeywordForVision();
		getColorForVision();	
		
	}
	

	
}
