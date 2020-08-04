package com.VIG.mvc.service.domain;

import java.io.Serializable;
import lombok.Data;

@Data
public class Event implements Serializable{
	
	//field
	public int eventId;
	public String eventTitle;
	public String eventSub; //부제
	public String eventStart; //시작날짜
	public String eventEnd; //종료날짜
	public String eventThumb; //썸네일
	public String eventTags; //참여하기위한 태그
	//이벤트의 내용을 올릴때 사용하는 부분
	public String eventImage;
	//이벤트 배너 이미지
	public String banner;
	public boolean eventType; //false=일반, true=당첨자발표
	
	//constructor
	public Event() {
		
	}
	


}
