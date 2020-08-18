package com.VIG.mvc.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.VIG.mvc.service.alarm.AlarmServices;
import com.VIG.mvc.service.domain.Alarm;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.web.main.mainController;

public class EchoHandler extends TextWebSocketHandler{
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	
	@Autowired 
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;
	
	@Autowired 
	@Qualifier("alarmServicesImpl")
	private AlarmServices alarmServices;
	
	
	public static final Logger logger = LogManager.getLogger(mainController.class); 	
    
    //세션을 모두 저장한다. -> 연결된 유저를 찾기 위하여  
	private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();    
    
    
    //클라이언트 연결후 진행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	User user = (User)session.getAttributes().get("user");
    	
    	if(user !=null) {
        //맵을 쓸때 방법
    	sessions.put(user.getUserCode(), session);
    	
        logger.debug("연결된 유저: " + user.getUserName());
        
    	}
    }
    
    //클라이언트 메세지를 받고 보내기
    @Override
    protected void handleTextMessage(WebSocketSession wsession, TextMessage message) throws Exception {
    	
    	logger.debug(message);
    	String split[] = (message.getPayload()).split(",");
    	String sendUserName =  ((User)wsession.getAttributes().get("user")).getUserName(); 
    	String sendUserCode =  ((User)wsession.getAttributes().get("user")).getUserName(); 
    	String profile =  ((User)wsession.getAttributes().get("user")).getProfileImg();
    	
    	Alarm alarm = new Alarm();		
		alarm.setAlarmType(Integer.parseInt(split[2]));
		alarm.setSendUser((User)wsession.getAttributes().get("user"));
		alarm.setReciveUser(userServices.getUserOne(split[0]));
		alarm.setIsWatch(0);
    	
     	//메세지를 받을 유저를 찾음	
    	WebSocketSession reqSession = sessions.get(split[0]);
    	
    	
    	//메세지(알람) 타입에 따라 내용 분류 (좋아요 또는 댓글)
    	if(split[2].equals("0") || split[2].equals("1") ) {
    		
    		Feed feed = feedServices.getFeed(Integer.parseInt(split[1]));
    		alarm.setLikefeed(feed);
    		
    		Image image = new Image();
    		
    		for(Image i :feed.getImages()) {
    			if(i.getIsThumbnail() == 1) {
    				image = i;
    			}
    		} 
    		
    		alarmServices.addAlarm(alarm);
    		
        	if(reqSession != null && reqSession.isOpen()) {
        		System.out.println("좋아요 댓글 알람 출력/ 타입 : "+split[2]);
        		
        		//피드 ID/ 보낸 유저 프로필/ 보낸 유저 이름/ 썸네일 이미지/ 알람타입/ 보낸 유저코드/ 알람ID  
          		reqSession.sendMessage(new TextMessage(split[1] + "," + profile+ "," + sendUserName + "," + image.getImageFile() + "," + split[2] + ","+ sendUserCode + ","+alarmServices.getLastAlarmId()));
          	  	
        	}
    	
    	//팔로우 알림
    	}else if(split[2].equals("2")) {
    		
    		
    		alarmServices.addAlarm(alarm);
    		
    		if(reqSession != null && reqSession.isOpen()) {
    			
    			System.out.println("팔로우 알람 출력/ 타입 : "+split[2]);
    			//피드 ID/ 보낸 유저 프로필/ 보낸 유저 이름/ 썸네일 이미지/ 알람타입/ 보낸 유저코드/ 알람ID
    			reqSession.sendMessage(new TextMessage(split[1] + "," + profile+ "," + sendUserName + "," + "0" + "," + split[2] + ","+ sendUserCode + ","+alarmServices.getLastAlarmId()));
    		}
    	}   	
   
    }
    
    //클라이언트와 연결이 끊어졌을 때 
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
       
    	String name =  ((User)session.getAttributes().get("user")).getUserName();    	
   
        //Map 삭제
        sessions.remove(session.getId());                      
 
        logger.debug("연결 끊김: " + name);
    }
 
}
