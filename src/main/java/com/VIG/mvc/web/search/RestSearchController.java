package com.VIG.mvc.web.search;

import java.util.ArrayList;
import java.util.Collections;
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

	@Value("#{commonProperties['pageSize'] ?: 10}")
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
		
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
		search.setPageSize(pageSize);
		
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		
		//피드 검색
		if(jsonData.get("mode").equals("Feed")) {
			//검색어를 영어로 변역
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
			}else {
				if(CommonUtil.checkNumber(jsonData.get("keyword"))){
					//단순 숫자라면 번역안함
					search.setKeyword(jsonData.get("keyword"));
				}
				
				search.setKeyword(Translater.autoDetectTranslate(jsonData.get("keyword"),"en"));
			}
			
			List<Feed> feedlist = feedServices.getFeedListFromKeyword(search);
			
			//프라임피드를 추가하고 조회수를 늘려준다.
			Feed primeFeed = feedServices.getPrimeFeedOne(search);
			
			if(primeFeed != null) {
				primeFeed.setPrimeFeedViewCount(primeFeed.getPrimeFeedViewCount()+1);
				feedServices.updatePrimeFeedViewCount(primeFeed);
				feedlist.add(primeFeed);				
			}

			
			//숨김피드는 빼준다.
			
			map.put("list", feedlist);
		}		
		
		//이미지 검색
		if(jsonData.get("mode").equals("Image")) {
			//검색어를 영어로 변역
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
			}else {
				if(CommonUtil.checkNumber(jsonData.get("keyword"))){
					//단순 숫자라면 번역안함
					search.setKeyword(jsonData.get("keyword"));
				}
				
				search.setKeyword(Translater.autoDetectTranslate(jsonData.get("keyword"),"en"));
			}
			
			List<Image> imageList = imageServices.getImageListFromKeyword(search);
			
			//선택된 이미지의 순서를 랜덤으로 섞어준다. -> 같은 피드의 이미지가 연속으로 나오지 않게 한다.
			Collections.shuffle(imageList);
			
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
			
			List<Feed> feedlist = new ArrayList<Feed>();
			
			for(User users : userList) {
				Search tempSearch = new Search();
				tempSearch.setKeyword(users.getUserCode());
				
				//페이지는 1페이지로 고정 -> 해당 유저가 작성한 피드의 1페이지만 불러오면 된다
				tempSearch.setCurrentPage(1);
				// 최대 5개의 피드만 가지고 옴
				tempSearch.setPageSize(5);
				
				//검색한 피드리스트를 합친다 - > 화면에서 나누어 준다.
				feedlist.addAll(feedServices.getMyFeedList(tempSearch));
			}						
			
			map.put("list", userList);
			map.put("feeds", feedlist);				
			
		}		

		return map;		
	}
		

	
	
	
	

}
