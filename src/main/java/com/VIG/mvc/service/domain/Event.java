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
	public String eventImage;
	public String eventRegDate;
	public String banner;
	public boolean eventType;
	
	//constructor
	public Event() {
		
	}
	


}
