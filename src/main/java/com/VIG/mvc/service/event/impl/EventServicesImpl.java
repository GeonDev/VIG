package com.VIG.mvc.service.event.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.event.EventDao;
import com.VIG.mvc.service.event.EventServices;

@Service("eventServicesImpl")
public class EventServicesImpl implements EventServices {
	
	//field
	@Autowired
	@Qualifier("eventDaoImpl")
	private EventDao eventDao;
	
	public EventServicesImpl() {
		
	}

	@Override
	public void addEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		eventDao.addEvent(event);
		
	}

	@Override
	public Event getEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		Event event = eventDao.getEvent(eventId);
		return event;
	}

	@Override
	public void updateEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		eventDao.updateEvent(event);
		
	}

	@Override
	public Map<String, Object> getEventList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<Event> list = eventDao.getEventList(search);
		int totalCount = eventDao.getEventCount();
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);	
		
		return map;
	}
	
	@Override
	public void deleteEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		
		eventDao.deleteEvent(eventId);
		
	}

	@Override
	public List<Event> getLastEventList() throws Exception {
		// TODO Auto-generated method stub
		return eventDao.getLastEventList();
	}

}
