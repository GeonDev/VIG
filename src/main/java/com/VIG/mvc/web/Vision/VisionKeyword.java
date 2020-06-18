package com.VIG.mvc.web.Vision;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Vector;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.protobuf.ByteString;



// 작동을 위해서는 API 키를 적용하야 합니다.
// Run As - Run Configurations - Environment - New 
public class VisionKeyword { 			
		
	public VisionKeyword() {}	
	
	//private static final Type typeColor = Type.IMAGE_PROPERTIES;		
	
	
	public  List<ImageKeyword> getKeywordForVision(String imageFilePath) {
		
		//중복값이 저장되는 것을 막기위하여 set 사용
		HashSet<ImageKeyword> result = new HashSet<ImageKeyword>();	
		
		
		requestVision(imageFilePath, Type.TEXT_DETECTION, result);
		requestVision(imageFilePath, Type.LABEL_DETECTION, result);
		requestVision(imageFilePath, Type.LANDMARK_DETECTION, result );
		requestVision(imageFilePath, Type.LOGO_DETECTION, result);
		
		//최종 결과값 전달 - 간단하게 형태인 LIST로 변환
		return new ArrayList<ImageKeyword>(result);
	}
	
	private  void requestVision(String imageFilePath, Type type, HashSet<ImageKeyword> list) {		
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
			    	addKeywordList(type, res, list);		    	
			    }		    
		
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
				
	}	
	
	
	private void addKeywordList(Type type, AnnotateImageResponse res, HashSet<ImageKeyword> result) {		
		
		if(type ==  Type.TEXT_DETECTION) {
		      for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
		    	  ImageKeyword imageKeyword = new ImageKeyword();
		    	  
		    	  imageKeyword.setKeyword(annotation.getDescription());
		    	  imageKeyword.setScore(annotation.getScore());		    	  
		    	  
		           result.add(imageKeyword);
		        }			
		}else if(type ==  Type.LABEL_DETECTION) {
		      for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
		    	  ImageKeyword imageKeyword = new ImageKeyword();
		    	  
		    	  imageKeyword.setKeyword(annotation.getDescription());
		    	  imageKeyword.setScore(annotation.getScore());
		    	 
		           result.add(imageKeyword);
		        }
		}else if(type ==  Type.LANDMARK_DETECTION) {			
			for (EntityAnnotation annotation : res.getLandmarkAnnotationsList()) {
				  ImageKeyword imageKeyword = new ImageKeyword();
				  
		    	  imageKeyword.setKeyword(annotation.getDescription());
		    	  imageKeyword.setScore(annotation.getScore());
		    	  
		           result.add(imageKeyword);
		      }
		}else if(type ==  Type.LOGO_DETECTION) {
	          for (EntityAnnotation annotation : res.getLogoAnnotationsList()) {
	        	  ImageKeyword imageKeyword = new ImageKeyword();
	        	  
		    	  imageKeyword.setKeyword(annotation.getDescription());
		    	  imageKeyword.setScore(annotation.getScore());
		    	  
		           result.add(imageKeyword);
	            }
		}
		
	}
}
