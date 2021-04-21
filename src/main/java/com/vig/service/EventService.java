package com.vig.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Event;
import com.vig.domain.Search;
import com.vig.repository.EventRepository;

@Service
public class EventService {
	
	
	@Autowired
	private EventRepository eventMapper;
	
	public EventService() {
		
	}


	public void addEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		eventMapper.addEvent(event);
		
	}


	public Event getEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		Event event = eventMapper.getEvent(eventId);
		return event;
	}


	public void updateEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		eventMapper.updateEvent(event);
		
	}

	
	public Map<String, Object> getEventList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<Event> list = eventMapper.getEventList(search);
		int totalCount = eventMapper.getEventCount();
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);	
		
		return map;
	}
	

	public void deleteEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		
		eventMapper.deleteEvent(eventId);
		
	}

	
	public List<Event> getLastEventList() throws Exception {
		// TODO Auto-generated method stub
		return eventMapper.getLastEventList();
	}

}
