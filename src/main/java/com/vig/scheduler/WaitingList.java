package com.vig.scheduler;

import java.util.LinkedList;
import java.util.Queue;

import org.springframework.stereotype.Component;

import com.vig.domain.ImageInfo;

/**
 * 
 * @author kada
 * @content : 대기중인 이미지 리스트/ 여러 쓰레드에서 접근 
 * 
 * 
 * */
@Component
public class WaitingList {

	//추출 대기중인 이미지 큐
	private static Queue<ImageInfo> images = new LinkedList<ImageInfo>();
	
	// 이미지 중복 체크
	// 여러 클라이언트에서 이미지를 넣을수 있다 -> 중복 체크  및 synchronized 처리
	public static synchronized void setWaitImage(ImageInfo info) {
		
		if(!images.contains(info)) {
			images.offer(info);
		}
	}
	
	//이미지 꺼내오기
	public static ImageInfo getWaitImage() {
			return images.poll();
	}
	
	// 이미지 개수 확인
	public static int getWaitSize() {
		return images.size();		
	}
	
}
