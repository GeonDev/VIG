package com.VIG.mvc.service.alarm;

import java.util.List;

import com.VIG.mvc.service.domain.Alarm;

public interface AlarmDao {
	
	public void addAlarm(Alarm alarm) throws Exception; 
	
	public List<Alarm> unWatchAlarmList(String userCode) throws Exception; 
		
	public void deleteOldAlarm(int date) throws Exception;
	
	public int getLastAlarmId() throws Exception;	
	
	public void updateAlarmView(int id) throws Exception;

}
