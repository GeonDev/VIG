package com.vig.restController;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.vig.domain.Alarm;
import com.vig.domain.Image;
import com.vig.domain.User;
import com.vig.service.AlarmService;

@RestController
@RequestMapping("/alarm/*")
public class RestAlarmController {	
	
	@Autowired
	private AlarmService alarmServices;
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
		
	
	public RestAlarmController(){
	}
	
	@RequestMapping(value="json/getAlarmList",method = RequestMethod.GET)
	public List<String> getAlarmList(HttpSession session) throws Exception{
		
		User user = (User)session.getAttribute("user");
		List<String> alarmData = new ArrayList<String>();
		
		if(user!=null) {	
				
		List<Alarm> alarmList = alarmServices.unWatchAlarmList( user.getUserCode());
		
			if(alarmList !=null) {			
				for(Alarm alarm : alarmList) {
					String temp = "";
					
					if(alarm.getLikefeed() != null) {
						temp = String.valueOf(alarm.getLikefeed().getFeedId());
					}					
					
					temp += ",";
					temp += alarm.getSendUser().getProfileImg();
					temp += ",";
					temp += alarm.getSendUser().getUserName();
					temp += ",";
					
					if(alarm.getLikefeed() != null) {
						for(Image tempImage : alarm.getLikefeed().getImages()) {
							if(tempImage.getIsThumbnail()==1) {
								temp += tempImage.getImageFile();
								temp += ",";
							}					
						}
					}else {
						temp += ",";
					}
					
					temp += alarm.getAlarmType();
					temp += ",";
					temp += alarm.getSendUser().getUserCode();
					temp += ",";
					temp += alarm.getAlarmId();
					
					alarmData.add(temp);				
				}		
				
			}		
		}
		return alarmData;
	}
	
	@RequestMapping(value="json/getCheckAlarms/{id}",method = RequestMethod.GET)
	public boolean getCheckAlarm(@PathVariable int id ) throws Exception{		
	
		alarmServices.updateAlarmView(id);
		
		return true;
	}
	
	
	
	
}
