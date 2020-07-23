package com.VIG.mvc.util;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
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
	
	private void addColorList(ColorInfo color) {
		ImageColor imageColor = new ImageColor();		
		imageColor.setRed(color.getColor().getRed());
		imageColor.setBlue(color.getColor().getBlue());
		imageColor.setGreen(color.getColor().getGreen());
		imageColor.setRatio(color.getPixelFraction());
		imageColor.setImageId(imageId);
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
		
		if (annotation.getScore() > 0.0f) {
			imageKeyword.setKeywordEn(annotation.getDescription());	
			imageKeyword.setScore(annotation.getScore());
			imageKeyword.setImageId(imageId);
			keywords.add(imageKeyword);
		}		
	}
	
	
	private void addColorList(Type type, AnnotateImageResponse res) {	
		DominantColorsAnnotation colors = res.getImagePropertiesAnnotation().getDominantColors();
		for(ColorInfo color : colors.getColorsList()) {
			addColorList(color);
		}
	}

	@Override
	public void run() {		
		getKeywordForVision();
		getColorForVision();		
	}
	
}
