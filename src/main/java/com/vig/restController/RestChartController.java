package com.vig.restController;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.vig.domain.User;
import com.vig.service.HistoryService;
import com.vig.service.LikeService;

@RestController
@RequestMapping("chart/*")

public class RestChartController {
	
	@Autowired
	private LikeService likeServices;
	
	@Autowired
	private HistoryService historyServices;
	
	public RestChartController() {
		
	}
	
	@RequestMapping(value="json/getChart",method = RequestMethod.GET)
	public HashMap<String,Object> getChart(HttpSession session,@RequestParam("month") String month,@RequestParam("year") String year)throws Exception{
	
		User user = (User)session.getAttribute("user");	
		
		
		String date = year+month;
		
		HashMap<String,String> keys = new HashMap<String,String>();
		
		
		
		
		keys.put("userCode", user.getUserCode());
		keys.put("date", date);
		
		HashMap<String,Object> likeCount = likeServices.getLikeMouthCount(keys);
	    
	    HashMap<String,Object> viewCount = historyServices.getfeedHistoryMouthCount(keys);
	    
	    HashMap<String,Object> primeCount = historyServices.getfeedHistoryPrimeDateCount(keys);
	    
	    
	    
	    HashMap<String,Object> key1 = new HashMap<String,Object>();
	    key1.put("likeCount",likeCount.get("mouthCout"));
	    key1.put("viewCount",viewCount.get("mouthCout"));
	    key1.put("primeCount", primeCount.get("mouthCout"));
	    
	    key1.put("likeCount2",likeCount.get("totalCount"));
	    key1.put("viewCount2",viewCount.get("totalCount"));
	    key1.put("primeCount2",primeCount.get("totalCount"));
	    
		return key1;
}
	
	}
