package com.VIG.mvc.web.chat;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.history.HistoryServices;
import com.VIG.mvc.service.like.LikeServices;
//
@Controller
@RequestMapping("/chat/*")
public class ChatController {

public ChatController() {
	
}


	@RequestMapping(value = "getChat",method = RequestMethod.GET)
	public ModelAndView getChat(HttpSession session, @RequestParam(value="receiver", required=false) String receiver)throws Exception{
		
		System.out.println("getChatList");
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("forward:../chat/getChat.jsp");
	    if(receiver != null || receiver != "") {
	    mav.addObject("receiver", receiver);
	    }
	    
	    return mav;
	}

}
