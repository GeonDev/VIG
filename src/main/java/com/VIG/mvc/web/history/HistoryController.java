package com.VIG.mvc.web.history;

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

import com.VIG.mvc.service.comment.CommentServices;
import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.history.HistoryServices;


@Controller
@RequestMapping("/history/*")
public class HistoryController {
	
	
	@Autowired
	private ServletContext context;	
	
	
	@Value("#{commonProperties['currentDate'] ?: 30}")
	int currentDate;	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;

	
	@Autowired
	@Qualifier("historyServicesImpl")
	private HistoryServices historyServices;
	
	@Autowired 
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;	
	
	@Autowired 
	@Qualifier("commentServicesImpl")
	private CommentServices commentServices;
	
	

	public HistoryController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	@RequestMapping("getMyHistoryList")
	public ModelAndView getMyHistory(HttpSession session, @ModelAttribute("search") Search search) throws Exception {		
	
		User user = (User)session.getAttribute("user");
		
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
		
		//유저가 본것만 조회
		search.setSearchType(0);
		
		if(user != null) {
			search.setKeyword(user.getUserCode());
		}else {			
			return new ModelAndView("forward:/common/alertView.jsp", "message", "로그인 후 이용가능합니다.");
		}		

		Page resultPage = new Page(search.getCurrentPage(), historyServices.getHistoryCount(search) , pageUnit, pageSize);
		
		
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("forward:/history/getMyHistory.jsp");
		modelAndView.addObject("historylist", historyServices.getHistoryList(search));
		
		// 유저의 숨김 리스트 출력
		search.setSearchType(1);
		modelAndView.addObject("hidelist", historyServices.getHistoryList(search));
		modelAndView.addObject("commentlist", commentServices.getCommentFromUser(search));
		modelAndView.addObject("likeFeedlist", feedServices.getLikedFeedList(search));
		modelAndView.addObject("writer", user);
		
		modelAndView.addObject("resultPage", resultPage);		
				
		return modelAndView;
	}
	
	@RequestMapping("deleteHistory")
	public ModelAndView deleteHistory(@RequestParam("Id") int historyId) throws Exception {
		
		historyServices.deleteHistory(historyId);
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", "해당 기록이 삭제되었습니다.");
		
		
	}
	
	@RequestMapping("addHideFeed")
	public ModelAndView addHideFeed(@RequestParam("Id") int feedId, HttpSession session) throws Exception {
		
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			return new ModelAndView("forward:/common/alertView.jsp", "message", "로그인 후 이용가능합니다.");
		}
		
		
		History history = new History();
		
		//숨김피드
		history.setHistoryType(1);
		history.setShowFeed(feedServices.getFeed(feedId));
		history.setWatchUser(user);
		historyServices.addHistory(history);
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", "해당 피드가 숨김처리 됬습니다.");
		
		
	}
	
}