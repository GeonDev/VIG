package com.VIG.mvc.service.event.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.event.EventDao;


@Repository
public class EventDaoImpl implements EventDao {

	
	//field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public EventDaoImpl() {
		
	}
	
	@Override
	public void addEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.insert("EventMapper.addEvent", event);
		
	}

	@Override
	public Event getEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		Event event = sqlSession.selectOne("EventMapper.getEvent", eventId);
		return event;
	}

	@Override
	public void updateEvent(Event event) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.update("EventMapper.updateEvent", event);
		
	}

	@Override
	public List<Event> getEventList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<Event> list = sqlSession.selectList("EventMapper.getEvetnList", search);
		
		return list;
	}
	
	@Override
	public void deleteEvent(int eventId) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.delete("EventMapper.deleteEvent", eventId);
		
	}
	

}
