package com.VIG.mvc.web.chart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public ModelAndView getChart(HttpSession session,@RequestParam("date") String date)throws Exception{
		
		
		User user = (User)session.getAttribute("user");
		String userCode = user.getUserCode();
		System.out.println(date);
		System.out.println(userCode);
		HashMap<String,String> keys = new HashMap<String,String>();
		// Ex)date : '202008' 형식 
		
		keys.put("userCode", userCode);
		keys.put("date", date);
		
		
		
	    List<String> likeCount = likeServices.getLikeMouthCount(keys);
	    System.out.println(likeCount);
	    List<String> viewCount = historyServices.getfeedHistoryMouthCount(keys);
	    System.out.println(viewCount);
	    List<String> primeCount = historyServices.getfeedHistoryPrimeDateCount(keys);
	    System.out.println(primeCount);
	    
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("forward:/chart/chart.jsp");
	    mav.addObject("likeCount", likeCount);
	    mav.addObject("viewCount",viewCount);
	    mav.addObject("primeCount", primeCount);
	    
	    return mav;
	}

}
