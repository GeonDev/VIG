package com.VIG.mvc.web.search;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.history.HistoryServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.CommonUtil;
import com.VIG.mvc.util.Translater;
import com.VIG.mvc.web.main.mainController;



@RestController
@RequestMapping("/search/*")
public class RestSearchController {	

	public static final Logger logger = LogManager.getLogger(RestSearchController.class); 
	
	
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
	@Qualifier("historyServicesImpl")
	private HistoryServices historyServices;
	
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;
	
	@Value("#{commonProperties['colorRange'] ?: 5}")
	int colorRange;


	
	public RestSearchController() {
		// TODO Auto-generated constructor stub		
	}	
	

	@RequestMapping(value = "json/getSearchKeyword")
	public List<String> getAutokeyword(@RequestBody Map<String, String> jsonData) throws Exception {			
	
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
	
	
	
	//선택된 유저가 작성한 피드 리스트를 반환한다.
	@RequestMapping(value = "json/getSearchUserFeedResult")
	public Map<String, Object> getSearchUserFeedResult(@RequestBody Map<String, String> jsonData) throws Exception {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();		
		
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
		search.setPageSize(pageSize);		
				
		search.setKeyword(jsonData.get("userCode"));
		
		List<Feed> feedlist = new ArrayList<Feed>();		
		feedlist = feedServices.getMyFeedList(search);
		
		map.put("list",feedlist);
		
		return map;	
		
	}
		
	
	//선택된 카테고리에 해당하는 피드를 리턴한다.
	@RequestMapping(value = "json/getSearchCategoryResult")
	public Map<String, Object> getSearchCategoryResult(@RequestBody Map<String, String> jsonData, HttpSession session) throws Exception {
				
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();		
		
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
		search.setPageSize(pageSize);
		search.setKeyword(jsonData.get("category"));
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		List<Feed> feedlist = new ArrayList<Feed>();
		
		
		//선택된 카테고리가 사용자 추천인지 체크
		if(search.getKeyword().equals("RECOMMEND") && jsonData.get("currentPage").equals("1") ) {
			
			//로그인 하지 않았다면 조회수가 가장 많은 피드를 추천
			if(user == null) {
				feedlist = feedServices.getHightViewFeedList(search);
				
			}else {
			// 로그인 한 유저에게 피드를 추천한다.------------------------------------------------------//					
				
				Search tempSearch = new Search();
				tempSearch.setKeyword(user.getUserCode());
				tempSearch.setPageSize(pageSize);
				
				tempSearch.setSearchType(0);
				//첫페이지 양만 가지고 옴
				tempSearch.setCurrentPage(1);				
				
				//최근 본 피드정보를 가지고 온다.
				List<History> historyList =	historyServices.getHistoryList(tempSearch);					
				
				if(historyList.size() > 0) {					
					List<ImageKeyword> keywordList = new ArrayList<ImageKeyword>();
					
					//최근 본 피드의 썸네일 키워드 리스트를 가지고 온다.
					for(History history : historyList) {						
						keywordList.addAll(history.getShowFeed().getKeywords());
					}		
					tempSearch.setKeywords(keywordList);
					
					feedlist = feedServices.getRecommendFeedList(tempSearch);				
					
					if(feedlist.size() > 0) {					
						
						for(Feed feed : feedlist) {					
							for(ImageKeyword keyword : keywordList) {
								if(feed.getKeywords().contains(keyword)) {
									feed.setCurrentKeywordSameCount(feed.getCurrentKeywordSameCount()+1);
								}
							}
						}
						
						//피드 리스트를 소팅한다.
						Collections.sort(feedlist);					
					}
					
				//다른 피드를 본 기록이 없는 유저	
				}else {
					// 조회수가 가장 많은 피드를 추천
					feedlist = feedServices.getHightViewFeedList(search);
				}					
			}
				
			
		//추천 카테고리를 선택하지 않은 경우 - 카테고리에 해당하는 이미지를 출력	
		}else {
			feedlist = feedServices.getFeedListFromCategory(search);
		}		
		
		
		//숨김피드는 빼준다. -> 모든 카테고리 공통
		if(user !=null) {
			Search tempSearch = new Search();
			tempSearch.setKeyword(user.getUserCode());
			tempSearch.setSearchType(1);				
			
			//숨김처리한 모든 피드리스트를 가지고 온다.
			List<History> hidelist = historyServices.getAllHistoryList(tempSearch);				
			
			if(hidelist.size() > 0) {
				for(History key : hidelist) {					
					feedlist.remove(key.getShowFeed());
				}				
			}
				
		}		
		
		map.put("list",feedlist);
		
		return map;	
		
	}
		
	
	
	//피드 검색 결과를 반환
	@RequestMapping(value = "json/getSearchResultList")
	public Map<String, Object> getSearchResult(@RequestBody Map<String, String> jsonData, HttpSession session, HttpServletRequest request) throws Exception {	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();		
		
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
		search.setPageSize(pageSize);
		
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		logger.debug("전달된 키워드 : "+ jsonData.get("keyword") );
		
		
		//피드 검색
		if(jsonData.get("mode").equals("Feed")) {
			
			//리턴시킬 피드 리스트를 초기화
			List<Feed> feedlist = new ArrayList<Feed>();
			List<Feed> primeFeed = new ArrayList<Feed>();
			
			
			//검색어가 비어있는 경우
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
				//일반 피드 부르기				
				feedlist = feedServices.getFeedListFromKeyword(search);
				//프라임 피드 부르기
				primeFeed = feedServices.getPrimeFeed(search);
				
			}else {
				//단순 숫자라면 번역 하지 않고 바로 적용
				if(CommonUtil.checkNumber(jsonData.get("keyword"))){					
					search.setKeyword(jsonData.get("keyword"));
					feedlist = feedServices.getFeedListFromKeyword(search);
					primeFeed = feedServices.getPrimeFeed(search);
					
				//첫글자가 #이라면 RGB로 바꾸어 본다.	
				}else if( jsonData.get("keyword").charAt(0) == '#' ) {
					
					search.setKeyword(jsonData.get("keyword"));
					search = CommonUtil.getHaxtoRGB(search, colorRange);					
					
					//해쉬코드형식으로 정확하게 도착했다면
					if(search !=null) {
						//색상 기반으로 검색
						feedlist = feedServices.getFeedListFromColor(search);
					}
					
				//검색어를 영어로 변역
				}else {
					search.setKeyword(Translater.autoDetectTranslate(jsonData.get("keyword"),"en"));
					feedlist = feedServices.getFeedListFromKeyword(search);
					primeFeed = feedServices.getPrimeFeed(search);
				}				
				
			}			
			

			
			//프라임 피드는 2개 출력한다.
			if(feedlist.size() > 1  && primeFeed.size() > 1 ) {					
				//선택된 프라임 피드를 히스토리에 저장
				setPrimeHistory(primeFeed, user, CommonUtil.getUserIp(request));					
				
				//추천한 프라임피드가 이미 리스트에 있다면 삭제하고 최상위로 배치	
				feedlist = setFeedOrder(feedlist, primeFeed.get(0), 0);
				
				//추천한 프라임피드가 이미 리스트에 있다면 삭제하고 페이지 뒤로 배치
				feedlist = setFeedOrder(feedlist, primeFeed.get(1), feedlist.size()-1);				
				
			}	
			
			//숨김피드는 빼준다.
			if(user !=null) {
				Search tempSearch = new Search();
				tempSearch.setKeyword(user.getUserCode());
				tempSearch.setSearchType(1);				
				
				List<History> hidelist = historyServices.getAllHistoryList(tempSearch);				
				
				for(History key : hidelist) {					
					feedlist.remove(key.getShowFeed());
				}				
			}					
	
			//피드 중복체크 후 반환
			map.put("list", CommonUtil.checkEqualFeed(feedlist));
			
		}		
		
		//이미지 검색
		if(jsonData.get("mode").equals("Image")) {
			
			//결과를 리턴할 이미지 객체
			List<Image> imageList = new ArrayList<Image>();
			
			//검색어를 영어로 변역
			if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
				search.setKeyword("");
				imageList = imageServices.getImageListFromKeyword(search);
			}else {
				
				if(CommonUtil.checkNumber(jsonData.get("keyword"))){
					//단순 숫자라면 번역안함
					search.setKeyword(jsonData.get("keyword"));
					imageList = imageServices.getImageListFromKeyword(search);
				}else if(jsonData.get("keyword").charAt(0) == '#') {
					//첫글자가 #이라면 RGB로 바꾸어 본다.
					search.setKeyword(jsonData.get("keyword"));
					search = CommonUtil.getHaxtoRGB(search, colorRange);
					
					if(search != null) {
						//색상 기반으로 검색
						imageList = imageServices.getImageListFromColor(search);
					}
					
				}else {
					search.setKeyword(Translater.autoDetectTranslate(jsonData.get("keyword"),"en"));
					imageList = imageServices.getImageListFromKeyword(search);
				}			
			}			
			
			
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
	
	
	//특정 피드를 원하는 위치로 이동
	private List<Feed> setFeedOrder(List<Feed> base, Feed prime, int index){			
		
		int deleteIndex = 0;	
		
		for(int i = 0; i<base.size(); i++ ) {
			if(base.get(i).getFeedId() == prime.getFeedId()) {
				deleteIndex = i;
				break;
			}			
		}		
		base.remove(deleteIndex);
		
		//원하는 위치에 삽입
		base.add(index, prime);
		
		return base;
	}
	
	
	//프라임피드 히스토리 기록
	private void setPrimeHistory(List<Feed> primeFeed, User user, String IP) throws Exception {		
		for(Feed f : primeFeed ) {
			History primeHistory = new History();
			
			//해당 피드의 작성자를 불러옴
			User writer = userServices.getUserOne(f.getWriter().getUserCode());
			
			//프라임 피드 카운트를 깎음
			if((writer.getPrimeCount()-1) < 0) {
				writer.setPrimeCount(0);
			}else {
				writer.setPrimeCount(writer.getPrimeCount()-1);
			} 	
			
			//작성자 정보 업데이트 
			userServices.updateUser(writer);
			
			
			//히스토리 타입 - 프라임 피드 노출
			primeHistory.setHistoryType(2);
			primeHistory.setShowFeed(f);			
			primeHistory.setIpAddress(IP);
			
			//유저가 로그인 한 경우 저장
			if(user !=null) {
				primeHistory.setWatchUser(user);
			}
			
			historyServices. addHistory(primeHistory);			
		
			f.setPrimeFeedViewCount(f.getPrimeFeedViewCount()+1);
			feedServices.updatePrimeFeedViewCount(f);
		}		
	}
	


}
