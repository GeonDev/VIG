package com.VIG.mvc.web.main;


import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.category.CategoryServices;
import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Category;
import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.event.EventServices;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;


@Controller
@RequestMapping("/main/*")
public class mainController {
	
	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
		
	@Autowired 
	@Qualifier("categoroyServicesImpl")
	private CategoryServices categoryServices;
	
	@Autowired 
	@Qualifier("eventServicesImpl")
	private EventServices eventServices;
	
	@Value("#{commonProperties['pageUnit'] ?: 10}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Autowired
	private ServletContext context;	
	
	public mainController(){
	}
	
	@RequestMapping("VIG")
	public ModelAndView getMain(Model model ) throws Exception {
		
		List<Category> categoryList = categoryServices.getAllCategoryList();
		List<Event> eventList = eventServices.getLastEventList();
		
		model.addAttribute("eventList", eventList);		
		model.addAttribute("categoryList", categoryList);
		
		return new ModelAndView("forward:/main/main.jsp");
	}
	
	
	
	

}
