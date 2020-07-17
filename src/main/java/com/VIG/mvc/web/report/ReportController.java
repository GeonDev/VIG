package com.VIG.mvc.web.report;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.keyword.KeywordServices;



@Controller
@RequestMapping("/reportController/*")
public class ReportController {	
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;

	
	@Autowired 
	@Qualifier("keywordServicesImpl")
	private KeywordServices keywordServices;
	

	@Autowired
	private ServletContext context;	

	
	public ReportController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	
	@RequestMapping("getReportList")
	public ModelAndView getReportList(@ModelAttribute("search") Search search, HttpSession session) throws Exception {      
		
		return new ModelAndView("forward:/report/getReportlist.jsp");
	}	


}
