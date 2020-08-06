package com.VIG.mvc.web.chart;

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
@RequestMapping("/chart/*")
public class ChartController {

@Autowired
@Qualifier("feedServicesImpl")
private FeedServices feedServices;

@Autowired
@Qualifier("likeServicesImpl")
private LikeServices likeServices;

@Autowired
@Qualifier("historyServicesImpl")
private HistoryServices historyServices;

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
	    mav.setViewName("forward:/chart/getChart.jsp");
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
