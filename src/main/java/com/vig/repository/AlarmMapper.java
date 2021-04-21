package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.Alarm;


@Mapper
public interface AlarmMapper {
	
	public void addAlarm(Alarm alarm) throws Exception; 
	
	public List<Alarm> unWatchAlarmList(String userCode) throws Exception; 
		
	public void deleteOldAlarm(int date) throws Exception;
	
	public int getLastAlarmId() throws Exception;	
	
	public void updateAlarmView(int id) throws Exception;

}
