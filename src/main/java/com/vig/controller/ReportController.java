package com.vig.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Page;
import com.vig.domain.Report;
import com.vig.domain.Search;
import com.vig.domain.User;
import com.vig.service.ReportService;
import com.vig.service.UserService;


@Controller
@RequestMapping("report/*")
public class ReportController {	
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private UserService userService;

	
	@Value("${currentDate}")
	int currentDate;
	
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;



	
	public ReportController() {
		// TODO Auto-generated constructor stub		
	}	
	
	@RequestMapping("addReport")
	public ModelAndView addReport(@ModelAttribute("report") Report report, HttpSession session ) throws Exception {
		
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			return new ModelAndView("forward:/common/alertView", "message", "로그인후 이용가능합니다..");
		}
		
		report.setReporter(user);
		
		report.setViolator(userService.getUserOne(report.getViolatorCode()));
		reportService.addReport(report);		
		
		return new ModelAndView("forward:/common/alertView", "message", "신고가 접수 되었습니다.");
	}	
	
	
	@RequestMapping("getReportList")
	public ModelAndView getReportList(@ModelAttribute("search") Search search, HttpSession session) throws Exception { 
		
		User admin = (User)session.getAttribute("user");		
		
		if(admin == null) {					
			return new ModelAndView("forward:/common/alertView", "message", "로그인이 필요합니다.");
				
		}else if(!admin.getRole().equals("admin")) {
			return new ModelAndView("forward:/common/alertView", "message", "관리자만 조회 가능합니다.");
		}	
		
		
		// 현재 페이지값이 없으면 첫번째 페이지로 설정
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		//키워드 데이터가 NULL이라면
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		
		search.setCurrentDate(currentDate);
		search.setPageSize(pageSize);
		
		Page resultPage = new Page(search.getCurrentPage(), reportService.getCountReportList(search) , pageUnit, pageSize);
		
		
		ModelAndView modelAndView = new ModelAndView();

		// Model 과 View 연결
		modelAndView.setViewName("forward: reportView/getReportlist");
		modelAndView.addObject("list", reportService.getReportList(search));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		//사이드바 프로필 그리기용 데이터
		modelAndView.addObject("writer", admin);

		return modelAndView;
	}	
	
	@RequestMapping("getReportListFromUser")
	public ModelAndView getReportListFromUser(@ModelAttribute("search") Search search, @RequestParam("userCode") String userCode, HttpSession session) throws Exception { 
		
		
		User admin = (User)session.getAttribute("user");		
		
		if(admin == null) {					
			return new ModelAndView("forward:/common/alertView", "message", "로그인이 필요합니다.");
				
		}else if(!admin.getRole().equals("admin")) {
			return new ModelAndView("forward:/common/alertView", "message", "관리자만 조회 가능합니다.");
		}
		
		
		
		// 현재 페이지값이 없으면 첫번째 페이지로 설정
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		//유저를 세팅
		search.setKeyword(userCode);		
		
		search.setCurrentDate(currentDate);
		search.setPageSize(pageSize);
		
		Page resultPage = new Page(search.getCurrentPage(), reportService.getCountReportListFromUser(search) , pageUnit, pageSize);
		
		
		ModelAndView modelAndView = new ModelAndView();

		// Model 과 View 연결
		modelAndView.setViewName("forward: reportView/getReportlistFromUser");
		modelAndView.addObject("list", reportService.getReportListFromUser(search));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		//사이드바 프로필 그리기용 데이터
		modelAndView.addObject("writer", admin);

		return modelAndView;
	}
	
	@RequestMapping("updateUserBanFromReport")
	public ModelAndView updateUserBanFromReport(@RequestParam("reportId") int reportId, @RequestParam("banType") int banType ) throws Exception { 		
		
		Report updateReport = new Report();
		updateReport.setReportId(reportId);
		updateReport.setBanType(banType);
		
		reportService.updateBanState(updateReport);
		

		return new ModelAndView("forward:/common/alertView", "message", "신고 처리가 완료되었습니다.");
	}


}
