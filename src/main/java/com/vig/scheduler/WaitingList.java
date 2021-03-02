package com.vig.scheduler;

import java.util.LinkedList;
import java.util.Queue;

import org.springframework.stereotype.Component;

import com.vig.domain.ImageInfo;

@Component
public class WaitingList {

	//추출 대기중인 이미지 큐
	public static Queue<ImageInfo> images = new LinkedList<ImageInfo>();
	
}
