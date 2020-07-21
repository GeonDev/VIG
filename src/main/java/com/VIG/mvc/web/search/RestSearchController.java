package com.VIG.mvc.web.search;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.CommonUtil;
import com.VIG.mvc.util.Translater;



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
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;


	
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
	
	
	@RequestMapping(value = "json/getSearchResultList")
	public Map<String, Object> getSearchResult(@RequestBody Map<String, String> jsonData, HttpSession session) throws Exception {	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("전달된 키워드 :"+ jsonData.get("keyword"));		
		
		Search search = new Search();		
		
		search.setCurrentPage(Integer.valueOf(jsonData.get("page")));
		search.setPageSize(pageSize);
		
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		
		//피드 검색
		if(jsonData.get("mode").equals("Feed")) {
			//검색어를 영어로 변역
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
			}else {
				search.setKeyword(Translater.autoDetectTranslate(jsonData.get("keyword"),"en"));
			}
			
			List<Feed> feedlist = feedServices.getFeedListFromKeyword(search);
			map.put("list", feedlist);
		}		
		
		//이미지 검색
		if(jsonData.get("mode").equals("Image")) {
			//검색어를 영어로 변역
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
			}else {
				search.setKeyword(Translater.autoDetectTranslate(jsonData.get("keyword"),"en"));
			}
			
			List<Image> imageList = imageServices.getImageListFromKeyword(search);
			map.put("list", imageList);
					
		}
		
		//유저 검색 - 관리자 계정 조회 불가
		if(jsonData.get("mode").equals("Writer")) {
			//유저 검색시 번역없이 검색
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
			}else {
				search.setKeyword(jsonData.get("keyword"));
			}
			
			search.setSearchType(0);
			List<User> userList = userServices.getUserListFromName(search);
			
			map.put("list", userList);
		}		

		return map;		
	}
		

	
	
	
	

}
