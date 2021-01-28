package com.mvc.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class Event implements Serializable{
	
	//field
	private int eventId;
	private String eventTitle;
	private String eventSub; //부제
	private String eventStart; //시작날짜
	private String eventEnd; //종료날짜
	private String eventThumb; //썸네일
	private String eventTags; //참여하기위한 태그
	//이벤트의 내용을 올릴때 사용하는 부분
	private String eventImage;
	//이벤트 배너 이미지
	private String banner;
	private boolean eventType; //false=일반, true=당첨자발표
	
	//constructor
	public Event() {
		
	}
	


}
