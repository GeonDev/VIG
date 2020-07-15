package com.VIG.mvc.service.event.impl;

import java.util.List;

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
	private EventDao evnetDao;

	@Override
	public void addEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		
	}

	@Override
	public Event getEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Event> getEventList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
