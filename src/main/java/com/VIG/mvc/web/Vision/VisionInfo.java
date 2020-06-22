package com.VIG.mvc.web.Vision;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.web.Translate.Translater;
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
public class VisionInfo { 			
		
	
	//중복값이 저장되는 것을 막기위하여 set 사용
	private static HashSet<ImageKeyword> kewordResult = new HashSet<ImageKeyword>();			
	
	private static List<ImageColor> colorResult = new ArrayList<ImageColor>();
	
	
	public VisionInfo() {}	
	
	//이미지의 키워드를 추출하는 함수
	public static List<ImageKeyword> getKeywordForVision(String imageFilePath) {	
		
		kewordResult.clear();
		
		requestVision(imageFilePath, Type.TEXT_DETECTION);
		//requestVision(imageFilePath, Type.LABEL_DETECTION);
		//requestVision(imageFilePath, Type.LANDMARK_DETECTION);
		//requestVision(imageFilePath, Type.LOGO_DETECTION);
		
		//최종 결과값 전달 - 간단하게 형태인 LIST로 변환
		return new ArrayList<ImageKeyword>(kewordResult);
	}
	
	
	
	//이미지의 색상정보를 추출하는 함수
	public static List<ImageColor> getColorForVision(String imageFilePath) {		
		
		colorResult.clear();
		
		requestVision(imageFilePath, Type.IMAGE_PROPERTIES);		
		
		return colorResult;
	}
	
	
	private static void requestVision(String imageFilePath, Type type) {		
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
			    	
			    	// 공용으로 분류를 사용하기 위하여 키워드, 컬러 인자값 2개를 전달
			    	// 실제 사용은 둘중 1개만 한다.
			    	addKeywordList(type, res, kewordResult, colorResult);		    	
			    }		    
		
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
				
	}	
	
	
	private static void addkeywoadhash(EntityAnnotation annotation, HashSet<ImageKeyword> result) {
		ImageKeyword imageKeyword = new ImageKeyword();
		
		if (annotation.getScore() > 0.0f) {
			imageKeyword.setKeywordEn(annotation.getDescription());
			//한국어 ko, 일본어 ja, 영어 en
			imageKeyword.setKeywordKr(Translater.autoDetectTranslate(annotation.getDescription(), "ko"));
			imageKeyword.setScore(annotation.getScore());
			result.add(imageKeyword);
		}		
	}	
	
	
	
	private static void addColorList(ColorInfo color, List<ImageColor> result) {
		ImageColor imageColor = new ImageColor();		
		imageColor.setRed(color.getColor().getRed());
		imageColor.setBlue(color.getColor().getBlue());
		imageColor.setGreen(color.getColor().getGreen());
		imageColor.setRatio(color.getPixelFraction());
		result.add(imageColor);
	}
	
	
	
	private static void addKeywordList(Type type, AnnotateImageResponse res, HashSet<ImageKeyword> keyResult, List<ImageColor> colorResult) {

		if (type == Type.TEXT_DETECTION) {
			for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
				addkeywoadhash(annotation, keyResult);
			}
		} else if (type == Type.LABEL_DETECTION) {
			for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
				addkeywoadhash(annotation, keyResult);
			}
		} else if (type == Type.LANDMARK_DETECTION) {
			for (EntityAnnotation annotation : res.getLandmarkAnnotationsList()) {
				addkeywoadhash(annotation, keyResult);
			}
		} else if (type == Type.LOGO_DETECTION) {
			for (EntityAnnotation annotation : res.getLogoAnnotationsList()) {
				addkeywoadhash(annotation, keyResult);
			}
		}else if(type == Type.IMAGE_PROPERTIES) {
			DominantColorsAnnotation colors = res.getImagePropertiesAnnotation().getDominantColors();
			for(ColorInfo color : colors.getColorsList()) {
				addColorList(color, colorResult);
			}			
		}
	}
}
