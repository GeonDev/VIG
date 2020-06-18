package com.VIG.mvc.web.Vision;

import java.util.ArrayList;
import java.util.List;

import com.VIG.mvc.web.Translate.TranslateKeyword;
import com.google.api.services.translate.Translate;

public class VisionTest {
	
	public static void main(String[] args) {	
		
		try {		
			String imageFilePath = "C:\\workspace\\VIG\\src\\main\\java\\com\\VIG\\mvc\\web\\Vision\\face.jpg"; 			
			
			System.out.println("VISION START...");
			List<ImageKeyword> keys = VisionKeyword.getKeywordForVision(imageFilePath);			
			
			for(ImageKeyword key : keys) {
				System.out.println(key.getKeyword() +" score : " +key.getScore());
			}		
			System.out.println("VISION END...");
			
			
			System.out.println();
			System.out.println();
			System.out.println();
			
			
			System.out.println("Tanslate START...");
			
			System.out.println(TranslateKeyword.autoDetectTranslate("스마트폰", "en"));
			
			
			System.out.println("Tanslate END...");
			

		}catch (Exception e) {
			// TODO: handle exception
		}
	}
}
