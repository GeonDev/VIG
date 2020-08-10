package com.VIG.mvc.web.search;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.category.CategoryServices;
import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Category;
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.history.HistoryServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.CommonUtil;


@Controller
@RequestMapping("/search/*")
public class SearchController {	
	
	public static final Logger logger = LogManager.getLogger(SearchController.class); 
	

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
		
	
	@Autowired 
	@Qualifier("categoroyServicesImpl")
	private CategoryServices categoryServices;
	
	
	@Autowired 
	@Qualifier("historyServicesImpl")
	private HistoryServices historyServices;
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;
	
	@Value("#{commonProperties['colorRange'] ?: 5}")
	int colorRange;

	
	public SearchController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	@RequestMapping(value = "getSearchList")
	public ModelAndView getSearchList(@RequestParam(value =  "Mode", defaultValue = "Feed") String mode, @RequestParam(value =  "keyword", defaultValue = "") String keyword, @RequestParam(value =  "category", defaultValue = "0") int categoryId, Model model, HttpSession session) throws Exception{
			
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");	
		
		List<Category> categorylist = categoryServices.getSearchCategoryList();
		
		Category delfault = new Category();
		delfault.setCategoryId(0);
		delfault.setCategoryName("All");
		categorylist.add(0, delfault);
		
		model.addAttribute("mode", mode);	
		model.addAttribute("user", user);
		model.addAttribute("keyword", keyword);
		model.addAttribute("categoryId", categoryId);
		model.addAttribute("categorylist", categorylist);
		
		
		return new ModelAndView("forward:/search/getSearchResult.jsp");
	}	
	
	

	//이미지 자세히 보기 최소 세팅 시에만 처리 -> 이후부터는 REST로 페이지 갱신
	@RequestMapping(value = "getSearchImages")
	public ModelAndView getSearchImageList(@RequestParam("imageId") int imageId, HttpSession session, Model model, @CookieValue(value = "searchKeys", defaultValue = "", required = false) String searchKeys ) throws Exception {		
		
		//기준 이미지 선택
		Image image = imageServices.getImageOne(imageId);
	
		model.addAttribute("baseImage", image);
		//model.addAttribute("list", relatedImages);
		return new ModelAndView("forward:/search/getSearchImageResult.jsp");
	}
	
	

}
