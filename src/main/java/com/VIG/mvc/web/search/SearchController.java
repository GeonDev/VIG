package com.VIG.mvc.web.search;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;


@Controller
@RequestMapping("/searchController/*")
public class SearchController {	
	

	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	

	@Autowired 
	@Qualifier("imageServicesImpl")
	private ImageServices imageServices;
	
	@Autowired 
	@Qualifier("keywordServicesImpl")
	private KeywordServices keywordServices;
	
	@Autowired 
	@Qualifier("colorServicesImpl")
	private ColorServices colorServices;	
	
	@Autowired 
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;	


	
	public SearchController() {
		// TODO Auto-generated constructor stub		
	}	
	

	@RequestMapping(value = "getSearchResult")
	public ModelAndView chat(@ModelAttribute("search") Search search,@RequestParam(value = "mode" ,required=false, defaultValue = "feed") String mode ,HttpSession session) throws Exception {		
		
		User user = (User)session.getAttribute("user");
		
		if(mode.equals("feed")) {
			
		}else if(mode.equals("image")) {
			
			
		}else {
			
			
		}
		
		
		
		
		
		if(user != null) {
			
		}else {
			
			
		}
		
				
		return new ModelAndView("forward:/search/getSearchResult.jsp");
	}	
	
	
	
	

}
