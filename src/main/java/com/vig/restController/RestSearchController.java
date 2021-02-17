package com.vig.restController;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.vig.domain.Feed;
import com.vig.domain.History;
import com.vig.domain.Image;
import com.vig.domain.ImageKeyword;
import com.vig.domain.Search;
import com.vig.domain.User;
import com.vig.service.ColorService;
import com.vig.service.FeedService;
import com.vig.service.HistoryService;
import com.vig.service.ImageService;
import com.vig.service.KeywordService;
import com.vig.service.UserService;
import com.vig.util.CommonUtil;
import com.vig.util.Translater;



@RestController
@RequestMapping("search/*")
public class RestSearchController {	

	public static final Logger logger = LogManager.getLogger(RestSearchController.class); 
	
	
	@Autowired 	
	private UserService userServices;	

	@Autowired 
	private ImageService imageServices;
	
	@Autowired 
	private FeedService feedServices;	
	
	@Autowired 
	private HistoryService historyServices;
	
	
	
	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	@Value("${colorRange}")
	int colorRange;

	@Value("${tagetPercent}")
	int tagetPercent;
	
	@Value("${decreasePercent}")
	int decreasePercent;


	
	public RestSearchController() {
		// TODO Auto-generated constructor stub		
	}	
	

	@RequestMapping(value = "json/getSearchKeyword")
	public List<String> getAutokeyword(@RequestBody Map<String, String> jsonData) throws Exception {			
	
		//키워드가 비어 있을 경우 종료
		if(CommonUtil.null2str(jsonData.get("keyword")).equals("")) {
			return null;
		}
		
		String key = jsonData.get("keyword");
		
		//피드의 타이틀을 자동완성
		if(jsonData.get("mode").equals("Feed")) {
			
			return feedServices.getfeedTitleList(key);
		}
		
		
		//이미지의 키워드를 자동완성
		if(jsonData.get("mode").equals("Image")) {
			return imageServices.getAutoImageKeywordList(key);
					
		}
		
		//유저의 닉네임을 자동완성
		if(jsonData.get("mode").equals("Writer")) {			
			return userServices.getAutoUserName(key);
		}
		
		
		//비정상적인 값이 왔을 경우 종료
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
	public Map<String, Object> getSearchCategoryResult(@RequestBody Map<String, String> jsonData, HttpSession session, @CookieValue(value = "searchKeys", defaultValue = "", required = false) String searchKeys) throws Exception {
				
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();		
		
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
		search.setPageSize(pageSize);
		
		//카테고리 ID 세팅
		search.setSearchType(Integer.parseInt(jsonData.get("category")));
		
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		List<Feed> feedlist = new ArrayList<Feed>();
		
		
		//선택된 카테고리가 사용자 추천인지 체크
		if(search.getSearchType() ==  10012) {
			
			//로그인 하지 않았다면 조회수가 가장 많은 피드를 추천
			if(user == null) {
				feedlist = feedServices.getHightViewFeedList(search);
				
			}else {
			// 로그인 한 유저에게 피드를 추천한다.------------------------------------------------------//					
				
				Search tempSearch = new Search();
				tempSearch.setKeyword(user.getUserCode());
				tempSearch.setPageSize(20);
				
				//일반 피드를 본 기록을 가지고 온다.
				tempSearch.setSearchType(0);
				//첫페이지 양만 가지고 옴
				tempSearch.setCurrentPage(1);				
				
				//최근 본 피드정보 20개를 가지고 온다.
				List<History> historyList =	historyServices.getHistoryList(tempSearch);					
				
				if(historyList.size() > 0) {					
					List<ImageKeyword> keywordList = new ArrayList<ImageKeyword>();
					
					//최근 본 피드의 썸네일 키워드 리스트를 가지고 온다.
					for(History history : historyList) {						
						keywordList.addAll(history.getShowFeed().getKeywords());
					}
					
					keywordList = addkeywordListFromCookis(keywordList,searchKeys);
					
					
					tempSearch.setKeywords(CommonUtil.checkEqualKeyword(keywordList));
					tempSearch.setPageSize(pageSize);
					tempSearch.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
					
					feedlist = CommonUtil.checkEqualFeed(feedServices.getRecommendFeedList(tempSearch));									
	
					
				// 다른 피드를 본 기록이 없는 유저	
				}else {
					// 조회수가 가장 많은 피드를 추천
					feedlist = feedServices.getHightViewFeedList(search);
				}					
			}
				
			
		//추천 카테고리를 선택하지 않은 경우 - 카테고리에 해당하는 이미지를 출력	
		}else {
			feedlist = feedServices.getFeedListFromCategory(search, user);
		}		
		
		map.put("list",feedlist);
		
		return map;	
		
	}
		
	
	
	//선택된 모드에 따라 검색 결과를 반환
	@RequestMapping(value = "json/getSearchResultList")
	public Map<String, Object> getSearchResult(@RequestBody Map<String, String> jsonData, HttpSession session, HttpServletRequest request, HttpServletResponse response ) throws Exception {	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Search search = new Search();		
		
		// 몇번째 페이지를 불러와야 하는지 세팅
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));
		search.setPageSize(pageSize);		
		
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		logger.debug("전달된 키워드 : "+ jsonData.get("keyword") );		
		
		//피드 검색
		if(jsonData.get("mode").equals("Feed")) {
			
			logger.debug("전달된 카테고리 : "+ jsonData.get("category"));
			
			//선택된 카테고리 정보를 세팅
			search.setSearchType(Integer.valueOf(jsonData.get("category")));
			
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
					
					//저장 시 출력하는 해쉬 코드로 변환한다. -> 색상범위를 지정해줌
					search = CommonUtil.getHaxtoRGB(search, colorRange);					
					
					//해쉬코드형식으로 정확하게 도착했다면
					if(search != null) {
						//색상 기반으로 검색
						logger.debug("변환된 색상 : "+ search.getKeyword());
						feedlist = feedServices.getFeedListFromColor(search);
					}				
				
				}else {
					//검색어를 영어로 변역
					String keyword = Translater.autoDetectTranslate(jsonData.get("keyword"),"en");
					search.setKeyword(keyword);
					
					//검색어를 쿠키에 추가
					addSearchKeyCookie(keyword, request, response);					
					feedlist = feedServices.getFeedListFromKeyword(search);
					primeFeed = feedServices.getPrimeFeed(search);
				}					
			}			

						
			//프라임 피드를 지정된 위치에 출력시킨다.
			if(primeFeed.size() > 0 ) {					
					
				for(int i=0; i< primeFeed.size(); i++) {
					//프라임피드를 넣을 위치
					int index = i*5;
					
					if(index > feedlist.size()-1) {
						index = feedlist.size()-1;
					}					
				
					feedlist.add(index, primeFeed.get(i));
					
					//선택된 프라임 피드를 히스토리에 저장
					setPrimeHistory(primeFeed.get(i), user, CommonUtil.getUserIp(request));
				}				
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
			
			//한 피드의 이미지만 나오지 않도록 최대 개수인 10개를 넘게 세팅
			search.setPageSize(pageSize+5);
			
			//결과를 리턴할 이미지 객체
			List<Image> imageList = new ArrayList<Image>();
			
			
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
						logger.debug("변환된 색상 : "+ search.getKeyword());	
						imageList = imageServices.getImageListFromColor(search);
					}
					
				}else {
					//검색어를 영어로 변역
					String keyword = Translater.autoDetectTranslate(jsonData.get("keyword"),"en");
					search.setKeyword(keyword);
					
					//검색어를 쿠키에 추가
					addSearchKeyCookie(keyword, request, response);
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
	
	
	//이미지 자세히 보기 
	@RequestMapping(value = "json/getSearchSameImage")
	public Map<String, Object> getSearchSameImageList(@RequestBody Map<String, String> jsonData, HttpSession session, @CookieValue(value = "searchKeys", defaultValue = "", required = false) String searchKeys ) throws Exception {		
		
		//연산 결과를 저장할 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		//기준 이미지 선택
		Image image = imageServices.getImageOne(Integer.parseInt(jsonData.get("imageId")));				
		
		//키워드 연관 이미지 추출하고 담을 객체
		List<Image> relatedImages = new ArrayList<Image>();
				
		//검색 기준 저장용 객체
		Search search = new Search();
		search.setPageSize(pageSize);				
	
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));		
		
		
		//선택된 이미지의 키워드 + 최근검색어를 저장할 리스트
		List<ImageKeyword> keylist = new ArrayList<ImageKeyword>();
		keylist.addAll(image.getKeyword());				

		keylist = addkeywordListFromCookis(keylist, searchKeys);
		
		//중복 키워드가 있는지 확인후 검색기준에 추가
		keylist = CommonUtil.checkEqualKeyword(keylist);
		search.setKeywords(keylist);
		
		//키워드 연관 이미지 추출
		relatedImages = imageServices.getImageListFromImage(search);
		
		//선택한 이미지는 유사 리스트 에서 제거
		relatedImages.remove(image);
		
		
				
		//중복체크후 반환
		map.put("list", CommonUtil.checkEqualImage(relatedImages));
		return map;
	}	
	
	
	//이미지 자세히 보기 
	@RequestMapping(value = "json/getSearchImages")
	public Map<String, Object> getSearchImageList(@RequestBody Map<String, String> jsonData, HttpSession session, @CookieValue(value = "searchKeys", defaultValue = "", required = false) String searchKeys ) throws Exception {		
		
		//연산 결과를 저장할 맵 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		//기준 이미지 선택
		Image image = imageServices.getImageOne(Integer.parseInt(jsonData.get("ImageId")));				
		
		//키워드 연관 이미지 추출하고 담을 객체
		List<Image> relatedImages = new ArrayList<Image>();
				
		//검색 기준 저장
		Search search = new Search();
		search.setPageSize(pageSize);				
	
		search.setCurrentPage(Integer.valueOf(jsonData.get("currentPage")));		
		
		
		//선택된 이미지의 키워드 + 최근검색어를 저장할 리스트
		List<ImageKeyword> keylist = new ArrayList<ImageKeyword>();
		keylist.addAll(image.getKeyword());				

		keylist = addkeywordListFromCookis(keylist, searchKeys);
		
		//중복 키워드가 있는지 확인후 검색기준에 추가
		keylist = CommonUtil.checkEqualKeyword(keylist);
		
		//조합 결과를 담을 리스트
		List<String> resultkeys = new ArrayList<String>();
		
		//조합 연산을 위한 배열
		boolean[] visited = new boolean[keylist.size()];
		
		int r = keylist.size() * ((tagetPercent - (decreasePercent*(Integer.valueOf(jsonData.get("currentPage"))-1)))/100);
		
		//주어진 퍼센트에 맞는 키워드 조합을 생성
		CommonUtil.comb(keylist, visited, 0, r, resultkeys);
		
		for(String combKey: resultkeys) {
			
			String[] key = combKey.split(",");
			List<ImageKeyword> combkeywords = new ArrayList<ImageKeyword>();
			
			for(String tempkey : key ) {
				ImageKeyword temp = new ImageKeyword();
				temp.setImageId(image.getImageId());	
				temp.setKeywordEn(tempkey);
			}
			
			//조합으로 생성한 키 리스트를 검색 기준으로 넣어  줌
			search.setKeywords(combkeywords);
			relatedImages.addAll(imageServices.getImageListFromImageALLKeys(search));
		}
		
		
				
		//중복체크후 반환
		map.put("list", CommonUtil.checkEqualImage(relatedImages));
		return map;
	}	
	
	//프라임피드 히스토리 기록
	private void setPrimeHistory(Feed primeFeed, User user, String IP) throws Exception {		
		
			History primeHistory = new History();
			
			//해당 피드의 작성자를 불러옴
			User writer = userServices.getUserOne(primeFeed.getWriter().getUserCode());
			
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
			primeHistory.setShowFeed(primeFeed);			
			primeHistory.setIpAddress(IP);
			
			//유저가 로그인 한 경우 저장
			if(user !=null) {
				primeHistory.setWatchUser(user);
			}
			
			historyServices. addHistory(primeHistory);			
		
			primeFeed.setPrimeFeedViewCount(primeFeed.getPrimeFeedViewCount()+1);
			feedServices.updatePrimeFeedViewCount(primeFeed);
				
	}
	
	
	//현재 검색한 단어를 쿠키에 추가 
	private void addSearchKeyCookie(String keyword, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		Cookie[] cookies = request.getCookies();		
		
		if(cookies != null) {
			for(Cookie cookie :cookies) {
				if((cookie.getName()).equals("searchKeys")) {														
					//이미 같은 내용을 포함하고 있다면 쿠키에 추가안함
					if(!cookie.getValue().contains(keyword) ) {
						//두번 인코딩 방지를 위하여 추가되는 부분만 인코딩한다.	
						keyword = URLEncoder.encode(keyword +",", "UTF-8") + cookie.getValue();					
						break;						
					}else {
						keyword = cookie.getValue();	
					} 					
				} 				
			}			
		}	
		//쿠키에는 공백이 들어갈 수 없다./ 공백은 인코딩 되지 않음 
		if(!keyword.contains(" ")) {
			logger.debug("저장된 쿠키 값  : " +keyword);		
			Cookie cookie = new Cookie("searchKeys", keyword );
			//30분 유지
			cookie.setMaxAge(60*30);
			cookie.setPath("/");
			response.addCookie(cookie);				
		}else {
			logger.debug("공백이 포함되어 쿠키에 저장하지 않았습니다.");	
		}
	}
	
	//쿠키에서 추출한 데이터를 키워드와 합침
	private List<ImageKeyword> addkeywordListFromCookis(List<ImageKeyword> keywordList, String searchKeys ){
		
		//쿠키에 저장된 검색어 기록을 가져온다.
		if(!searchKeys.equals("") ) {			
			
			//쿠키에서 가져오면서 변경된 공백을 원래 상태로 돌림
			searchKeys = searchKeys.replaceAll("\\+", " ");						
			//콤마 (,)를 기준으로 나눔
			String[] keys = searchKeys.split(",");
			
			for(String keyword : keys ) {
				
				if(!keyword.equals("")) {
					logger.debug("불러온 쿠키 값 : " + keyword);
					ImageKeyword temp = new ImageKeyword();								
					temp.setKeywordEn(keyword);	
					
					keywordList.add(temp);
				}
			}						
		}
		
		return keywordList;
	}


}
