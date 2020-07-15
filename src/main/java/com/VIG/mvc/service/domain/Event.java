package com.VIG.mvc.service.domain;

import java.util.Date;
import lombok.Data;

@Data
public class Event {
	
	//field
	public int eventId;
	public String eventTitle;
	public String eventSub;
	public Date eventStart;
	public Date eventEnd;
	public String eventThumb;
	public String eventTags;
	public String eventImage;
	public Date eventRegDate;
	public String banner;
	public boolean eventType;
	
	//constructor
	public Event() {
		
	}
	


}
