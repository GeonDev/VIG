package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.Event;
import com.vig.domain.Search;


@Mapper
public interface EventMapper {

	public void addEvent(Event event) throws Exception;
	
	public Event getEvent(int eventId) throws Exception;
	
	public void updateEvent(Event event) throws Exception;
	
	public List<Event> getEventList(Search search) throws Exception;
	
	public List<Event> getLastEventList() throws Exception;
	
	public void deleteEvent(int eventId) throws Exception;
	
	public int getEventCount() throws Exception;
	
}
