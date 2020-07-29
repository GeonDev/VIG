package com.VIG.mvc.service.domain;

import java.io.Serializable;
import lombok.Data;

@Data
public class Event implements Serializable{
	
	//field
	public int eventId;
	public String eventTitle;
	public String eventSub;
	public String eventStart;
	public String eventEnd;
	public String eventThumb;
	public String eventTags;
	//이벤트의 내용을 올릴때 사용하는 부분
	public String eventImage;
	//이벤트 배너 이미지
	public String banner;
	public boolean eventType;
	
	//constructor
	public Event() {
		
	}
	


}
