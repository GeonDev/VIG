package com.VIG.mvc.web.chart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.VIG.mvc.service.feed.FeedServices;
//
@Controller
@RequestMapping("/chart/*")
public class ChartController {

@Autowired
@Qualifier("feedServicesImpl")
private FeedServices feedServices;

public ChartController() {
	
}


	//	public ModelAndView get

}
