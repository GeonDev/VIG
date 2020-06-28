package com.VIG.mvc.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.VIG.mvc.service.domain.User;

public class EchoHandler extends TextWebSocketHandler{
    
    //세션을 모두 저장한다.
    //방법 1 :  1:1 채팅
	private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();
    
    //방법 2 : 전체 채팅
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    
    //클라이언트 연결후 진행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	User user = (User)session.getAttributes().get("user");
    	
        //맵을 쓸때 방법
    	sessions.put(user.getName(), session);
    	
    	//전체 세션 저장
        sessionList.add(session);       
        
        
        System.out.println("채팅방 입장자: " + user.getName());
    }
    
    //클라이언트 메세지를 받고 보내기
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
       
    	String split[] = (message.getPayload()).split(",");
    	String name =  ((User)session.getAttributes().get("user")).getName(); 
    	
    	if(split[0].equals("")) {    	
	        //연결된 모든 클라이언트에게 메시지 전송   
	        for(WebSocketSession sess : sessionList){          	
	        	       	    
	        	
	        	//메세지를 전송한다. message.getPayload() => 저장되어 있는 텍스트를 불러옴
	        	sess.sendMessage(new TextMessage(name + " : " +split[1]));
	        }        
    	}else {    		
    		WebSocketSession reqSession = sessions.get(split[0]);
    		
    		reqSession.sendMessage(new TextMessage(name + " : " +split[1]));
    	}
   
    }
    
    //클라이언트와 연결이 끊어졌을 때 
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
       
    	String name =  ((User)session.getAttributes().get("user")).getName();
    	
    	//List 삭제
        sessionList.remove(session);
        
        //Map 삭제
        //sessions.remove(session.getId());              
        
        System.out.println("채팅방 퇴장자: " + name);
    }
 
}
