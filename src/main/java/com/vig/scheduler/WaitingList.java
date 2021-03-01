package com.vig.scheduler;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class WaitingList {

	//추출 대기중인 이미지 ID
	public static List<Integer> imageId = null;
	
	//추출 대기중인 이미지 경로
	public static List<String> imageFilePath = null;
	
	public static void setImage(int id, String path) {
			imageId.add(Integer.valueOf(id));
			imageFilePath.add(path);		
	}
	
	public static void deleteImage(int id, String path) {
		imageId.remove(Integer.valueOf(id));
		imageFilePath.remove(path);		
	}
	
}
