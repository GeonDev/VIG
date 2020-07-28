package com.VIG.mvc.service.event;

import java.util.List;
import java.util.Map;

import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.domain.Search;

public interface EventServices {
	
	public void addEvent(Event event) throws Exception;
	
	public Event getEvent(int eventId) throws Exception;
	
	public void updateEvent(Event event) throws Exception;
	
	public Map<String, Object> getEventList(Search search) throws Exception;
	
	public List<Event> getLastEventList() throws Exception;
	
	public void deleteEvent(int eventId) throws Exception;

}
