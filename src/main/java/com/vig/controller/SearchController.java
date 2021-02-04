package com.vig.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Category;
import com.vig.domain.Image;
import com.vig.domain.User;
import com.vig.service.CategoryService;
import com.vig.service.ImageService;


@Controller
@RequestMapping("/search/*")
public class SearchController {	
	
	public static final Logger logger = LogManager.getLogger(SearchController.class); 
	

	@Autowired 
	private ImageService imageServices;	

	
	@Autowired 
	private CategoryService categoryServices;	

	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	@Value("${colorRange}")
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
		model.addAttribute("pageSize", pageSize);
		
		return new ModelAndView("forward:/search/getSearchResult.jsp");
	}	
	
	

	//이미지 자세히 보기 최소 세팅 시에만 처리 -> 이후부터는 REST로 페이지 갱신
	@RequestMapping(value = "getSearchImages")
	public ModelAndView getSearchImageList(@RequestParam("imageId") int imageId, Model model ) throws Exception {		
		
		//기준 이미지 선택
		Image image = imageServices.getImageOne(imageId);					
				
		model.addAttribute("baseImage", image);		
		model.addAttribute("pageSize", pageSize);
		return new ModelAndView("forward:/search/getSearchImageResult.jsp");
	}
	
	

}
