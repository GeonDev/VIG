package com.vig.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.User;
import com.vig.service.HistoryService;
import com.vig.service.LikeService;
//
@Controller
@RequestMapping("chart/*")
public class ChartController {


@Autowired
private LikeService likeServices;

@Autowired
private HistoryService historyServices;

public ChartController() {
	
}


	@RequestMapping(value = "getChart",method = RequestMethod.GET)
	public ModelAndView getChart(HttpSession session)throws Exception{
				
		User user = (User)session.getAttribute("user");	
	
		
		
		HashMap<String,String> keys = new HashMap<String,String>();
		// Ex)date : '202008' 형식 
		String date ="202008"; 
		keys.put("userCode", user.getUserCode());
		keys.put("date", date);
		
				
		
		HashMap<String,Object> likeCount = likeServices.getLikeMouthCount(keys);
	    
	    HashMap<String,Object> viewCount = historyServices.getfeedHistoryMouthCount(keys);
	    
	    HashMap<String,Object> primeCount = historyServices.getfeedHistoryPrimeDateCount(keys);
	    
	    
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("chartView/getChart");
	    mav.addObject("likeCount", likeCount.get("mouthCout"));			//리스트
	    mav.addObject("likeCount2",likeCount.get("totalCount"));			//총합
	    //좋아요
	    mav.addObject("viewCount",viewCount.get("mouthCout"));
	    mav.addObject("viewCount2",viewCount.get("totalCount"));
	    //뷰카운트
	    mav.addObject("primeCount", primeCount.get("mouthCout"));
	    mav.addObject("primeCount2", primeCount.get("totalCount"));
	    //프라임카운트
	    
	    return mav;
	}

}
