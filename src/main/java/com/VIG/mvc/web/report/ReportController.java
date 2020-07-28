package com.VIG.mvc.web.report;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Report;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.report.ReportServices;
import com.VIG.mvc.service.user.UserServices;



@Controller
@RequestMapping("/report/*")
public class ReportController {	
	
	@Autowired
	@Qualifier("reportServicesImpl")
	private ReportServices reportService;
	
	@Autowired
	@Qualifier("userServicesImpl")
	private UserServices userService;
	

	@Autowired
	private ServletContext context;	
	
	
	@Value("#{commonProperties['currentDate'] ?: 30}")
	int currentDate;
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;



	
	public ReportController() {
		// TODO Auto-generated constructor stub		
	}	
	
	@RequestMapping("addReport")
	public ModelAndView addReport(@ModelAttribute("report") Report report, HttpSession session ) throws Exception {
		
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			return new ModelAndView("forward:/common/alertView.jsp", "message", "로그인후 이용가능합니다..");
		}
		
		report.setReporter(user);
		
		report.setViolator(userService.getUserOne(report.getViolatorCode()));
		reportService.addReport(report);		
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", "신고가 접수 되었습니다.");
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
		
		search.setCurrentDate(currentDate);
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
	
	@RequestMapping("getReportListFromUser")
	public ModelAndView getReportListFromUser(@ModelAttribute("search") Search search, @RequestParam("userCode") String userCode) throws Exception { 
		
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
		modelAndView.setViewName("forward:/report/getReportlistFromUser.jsp");
		modelAndView.addObject("list", reportService.getReportListFromUser(search));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		return modelAndView;
	}
	
	@RequestMapping("updateUserBanFromReport")
	public ModelAndView updateUserBanFromReport(@RequestParam("reportId") int reportId, @RequestParam("banType") int banType ) throws Exception { 		
		
		Report updateReport = new Report();
		updateReport.setReportId(reportId);
		updateReport.setBanType(banType);
		
		reportService.updateBanState(updateReport);
		

		return new ModelAndView("forward:/common/alertView.jsp", "message", "신고 처리가 완료되었습니다.");
	}


}
