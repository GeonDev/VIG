package com.VIG.mvc.web.search;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.CommonUtil;



@RestController
@RequestMapping("/searchController/*")
public class RestSearchController {	
	

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


	
	public RestSearchController() {
		// TODO Auto-generated constructor stub		
	}	
	

	@RequestMapping(value = "json/getSearchKeyword")
	public List<String> getAutokeyword(@RequestBody Map<String, String> jsonData) throws Exception {	
		
		System.out.println("전달된 값 :"+ jsonData.get("mode"));
		
		//키워드가 비어 있을 경우 종료
		if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
			return null;
		}
		
		//피드의 타이틀을 자동완성
		if(jsonData.get("mode").equals("Feed")) {
			
			return feedServices.getfeedTitleList(jsonData.get("keyword"));
		}
		
		
		//이미지의 키워드를 자동완성
		if(jsonData.get("mode").equals("Image")) {
			return imageServices.getAutoImageKeywordList(jsonData.get("keyword"));
					
		}
		
		//유저의 닉네임을 자동완성
		if(jsonData.get("mode").equals("Writer")) {			
			return userServices.getAutoUserName(jsonData.get("keyword"));
		}
		
		return null;
		
	}	
		

	
	
	
	

}
