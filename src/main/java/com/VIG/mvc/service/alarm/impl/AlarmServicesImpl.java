package com.VIG.mvc.service.alarm.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.alarm.AlarmDao;
import com.VIG.mvc.service.alarm.AlarmServices;
import com.VIG.mvc.service.domain.Alarm;

@Service("alarmServicesImpl")
public class AlarmServicesImpl implements AlarmServices {

	@Autowired
	@Qualifier("alarmDaoImpl")
	private AlarmDao alarmDao;
	
	public AlarmServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addAlarm(Alarm alarm) throws Exception {
		// TODO Auto-generated method stub
		alarmDao.addAlarm(alarm);
		
	}

	@Override
	public List<Alarm> unWatchAlarmList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return alarmDao.unWatchAlarmList(userCode);
	}

	@Override
	public void deleteOldAlarm(int date) throws Exception {
		// TODO Auto-generated method stub
		alarmDao.deleteOldAlarm(date);
		
	}

}
