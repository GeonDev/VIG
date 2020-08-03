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
	
	
	public static final Logger logger = LogManager.getLogger(mainController.class); 	
    
    //세션을 모두 저장한다.
    //방법 1 :  1:1 채팅
	private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();    
    
    
    //클라이언트 연결후 진행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	User user = (User)session.getAttributes().get("user");
    	
        //맵을 쓸때 방법
    	sessions.put(user.getUserCode(), session);
    	
        logger.debug("로그인 유저: " + user.getUserName());
        
      
    }
    
    //클라이언트 메세지를 받고 보내기
    @Override
    protected void handleTextMessage(WebSocketSession wsession, TextMessage message) throws Exception {
    	
    	logger.debug(message);
    	String split[] = (message.getPayload()).split(",");
    	String name =  ((User)wsession.getAttributes().get("user")).getUserName(); 
    	String profile =  ((User)wsession.getAttributes().get("user")).getProfileImg();
    	
     	//메세지를 받을 유저를 찾음	
    	WebSocketSession reqSession = sessions.get(split[0]);
    	
    	if(reqSession == null) {
    		return;
    	}
    		
    	
    	//메세지(알람) 타입에 따라 내용 분류
    	if(split[2].equals("0")) {
    		
    		Feed feed = feedServices.getFeed(Integer.parseInt(split[1]));
    		
    		Image image = new Image();
    		
    		for(Image i :feed.getImages()) {
    			if(i.getIsThumbnail() == 1) {
    				image = i;
    			}
    		}   		    		

    		
    		logger.debug("전달값 : "+ split[1] + ","+ image.getImageFile()+","+name + ","+profile );
    		
    		
    		reqSession.sendMessage(new TextMessage(split[1] + ","+ image.getImageFile()+","+name + ","+profile));
    		
    	}else if(split[2].equals("1")) {
    		
    		reqSession.sendMessage(new TextMessage(name + " : " +split[1]));
    	}else {
    		
    		reqSession.sendMessage(new TextMessage(name + " : " +split[1]));
		}    	
   
    }
    
    //클라이언트와 연결이 끊어졌을 때 
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
       
    	String name =  ((User)session.getAttributes().get("user")).getUserName();    	
   
        //Map 삭제
        sessions.remove(session.getId());                      
 
        logger.debug("로그아웃 유저: " + name);
    }
 
}
