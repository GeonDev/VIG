package com.VIG.mvc.util;

import com.google.cloud.translate.Detection;
import com.google.cloud.translate.Translate;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
import com.google.common.collect.ImmutableList;
import java.util.List;

public class Translater {

	public Translater() {
		// TODO Auto-generated constructor stub
	}
	
	
	private static Translate getTranslateService() {
        return TranslateOptions.getDefaultInstance().getService();
    }

    private static String translate(String text, String source, String target) {
        Translate translate = getTranslateService();

        Translation translation = translate.translate(text,        // 바꾸고자 하는 텍스트
                Translate.TranslateOption.sourceLanguage(source),  // 원본 언어
                Translate.TranslateOption.targetLanguage(target)); // 번역할 언어

        return translation.getTranslatedText();
    }

    // 어떤 언어인지 감지를 해서 언어 코드를 반환합니다 예) 한국어 -> ko
    private static String detectLanguage(String text) {
        Translate translate = getTranslateService();
        List<Detection> detections = translate.detect(ImmutableList.of(text));

        String sourceLanguage = null;
        for (Detection detection : detections) {
            sourceLanguage = detection.getLanguage();
        }

        return sourceLanguage;
    }

    public static String autoDetectTranslate(String text, String target) {
    	String originlang = detectLanguage(text);    	
    	return translate(text, originlang, target);    	
    }
	
        
    public static String autoDetectTranslate(String text) {
    	String originlang = detectLanguage(text);    	
    
    	if(originlang.equals("en")) {
    		return translate(text, originlang, "ko");	
    	}else {
    		return translate(text, originlang, "en");
    	}
    		
    }

}
