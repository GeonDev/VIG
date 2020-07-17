package com.VIG.mvc.web.report;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Report;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.report.ReportServices;



@Controller
@RequestMapping("/reportController/*")
public class ReportController {	
	
	@Autowired
	@Qualifier("reportServicesImpl")
	private ReportServices reportService;	

	@Autowired
	private ServletContext context;	
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;



	
	public ReportController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	
	@RequestMapping("getReportList")
	public ModelAndView getReportList(@ModelAttribute("search") Search search) throws Exception { 
		
		// 현재 페이지값이 없으면 첫번째 페이지로 설정
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		//키워드 데이터가 NULL이라면
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		
		search.setPageSize(pageSize);
		
		Page resultPage = new Page(search.getCurrentPage(), reportService.getCountReportList(search) , pageUnit, pageSize);
		
		
		ModelAndView modelAndView = new ModelAndView();

		// Model 과 View 연결
		modelAndView.setViewName("forward:/report/getReportlist.jsp");
		modelAndView.addObject("list", reportService.getReportList(search));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		return modelAndView;
	}	


}
