package com.VIG.mvc.service.alarm.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.alarm.AlarmDao;
import com.VIG.mvc.service.domain.Alarm;

@Repository("alarmDaoImpl")
public class AlarmDaoImpl implements AlarmDao {

	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	

	
	
	public AlarmDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	

	@Override
	public void addAlarm(Alarm alarm) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("AlarmMapper.addAlarm",alarm);
	}

	@Override
	public List<Alarm> unWatchAlarmList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("AlarmMapper.unWatchAlarmList",userCode);
	}

	@Override
	public void deleteOldAlarm(int date) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("AlarmMapper.deleteOldHistory");
	}

}
