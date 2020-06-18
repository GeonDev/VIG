package com.VIG.mvc.web.Vision;

import java.util.ArrayList;
import java.util.List;

public class VisionTest {
	
	public static void main(String[] args) {	
		
		try {		
			String imageFilePath = "C:\\workspace\\VIG\\src\\main\\java\\com\\VIG\\mvc\\web\\Vision\\face.jpg"; 
			VisionKeyword vision = new VisionKeyword();
			
			System.out.println("VISION START...");
			List<ImageKeyword> keys = vision.getKeywordForVision(imageFilePath);
			
			
			for(ImageKeyword key : keys) {
				System.out.println(key.getKeyword());
			}		
			System.out.println("end...");

		}catch (Exception e) {
			// TODO: handle exception
		}
	}
}
