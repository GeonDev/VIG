package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Alarm;
import com.vig.repository.AlarmRepository;


@Service
public class AlarmService  {

	@Autowired	
	private AlarmRepository alarmMapper;
	
	public AlarmService() {
		// TODO Auto-generated constructor stub
	}


	public void addAlarm(Alarm alarm) throws Exception {
		// TODO Auto-generated method stub
		alarmMapper.addAlarm(alarm);
		
	}


	public List<Alarm> unWatchAlarmList(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return alarmMapper.unWatchAlarmList(userCode);
	}


	public void deleteOldAlarm(int date) throws Exception {
		// TODO Auto-generated method stub
		alarmMapper.deleteOldAlarm(date);
		
	}

	
	public int getLastAlarmId() throws Exception {
		// TODO Auto-generated method stub
		return alarmMapper.getLastAlarmId();
	}


	public void updateAlarmView(int id) throws Exception {
		// TODO Auto-generated method stub
		alarmMapper.updateAlarmView(id);
	}

}
