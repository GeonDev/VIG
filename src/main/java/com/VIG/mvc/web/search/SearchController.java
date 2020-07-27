package com.VIG.mvc.web.search;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.History;
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
import com.VIG.mvc.util.Translater;


@Controller
@RequestMapping("/search/*")
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
	public ModelAndView getSearchList(@RequestParam(value =  "Mode", defaultValue = "Feed") String mode, @RequestParam(value =  "keyword", defaultValue = "") String keyword, Model model, HttpSession session) throws Exception{
		
		Search search = new Search();		
		
		//새로운 페이지 갱신용으로만 사용함으로 항상 첫번째 페이지
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		//로그인한 유저 정보를 받아옴
		User user = (User)session.getAttribute("user");
		
		System.out.println("전달된 모드 : "+ mode);
		System.out.println("전달된 키워드 : "+ keyword);
		
		//피드 검색
		if(mode.equals("Feed")) {
			
			//리턴시킬 피드 리스트를 초기화
			List<Feed> feedlist = new ArrayList<Feed>();			
			
			//검색어를 영어로 변역
			if(CommonUtil.null2str(keyword).equals("")) {
				search.setKeyword("");
				feedlist = feedServices.getFeedListFromKeyword(search);
			}else {
				if(CommonUtil.checkNumber(keyword)){
					//단순 숫자라면 번역 하지 않고 바로 적용
					search.setKeyword(keyword);
					feedlist = feedServices.getFeedListFromKeyword(search);
				}else if( keyword.charAt(0) == '#' ) {
					//첫글자가 #이라면 RGB로 바꾸어 본다.
					search.setKeyword(keyword);
					search = CommonUtil.getHaxtoRGB(search, colorRange);
					System.out.println("색상변환 : "+search.getColor().getRed() +", "+search.getColor().getGreen()+", "+search.getColor().getBlue()) ;
					if(search !=null) {
						//색상 기반으로 검색
						feedlist = feedServices.getFeedListFromColor(search);
					}
				
				}else {
					search.setKeyword(Translater.autoDetectTranslate(keyword,"en"));
					feedlist = feedServices.getFeedListFromKeyword(search);
				}				
			}
			
			
			//프라임피드를 추가하고 조회수를 늘려준다.
			Feed primeFeed = feedServices.getPrimeFeedOne(search);
			
			if(primeFeed != null) {
				primeFeed.setPrimeFeedViewCount(primeFeed.getPrimeFeedViewCount()+1);
				feedServices.updatePrimeFeedViewCount(primeFeed);
				feedlist.add(primeFeed);				
			}
			
			//피드 중복을 제거하기 위하여 Set에 넣었다 뺀다.
			HashSet<Feed> temp = new HashSet<Feed>(feedlist);
			feedlist.clear();
			feedlist = new ArrayList<Feed>(temp);
					
			
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
			
			
			model.addAttribute("feedlist", feedlist);			
		}		
		
		//이미지 검색
		if(mode.equals("Image")) {
			
			//결과를 리턴할 이미지 객체
			List<Image> imageList = new ArrayList<Image>();
			
			//검색어를 영어로 변역
			if(CommonUtil.null2str(keyword).equals("")) {
				search.setKeyword("");
				imageList = imageServices.getImageListFromKeyword(search);
			}else {
				
				if(CommonUtil.checkNumber(keyword)){
					//단순 숫자라면 번역안함
					search.setKeyword(keyword);
					imageList = imageServices.getImageListFromKeyword(search);
				}else if(keyword.charAt(0) == '#') {
					//첫글자가 #이라면 RGB로 바꾸어 본다.
					search.setKeyword(keyword);
					search = CommonUtil.getHaxtoRGB(search, colorRange);
					
					if(search != null) {
						//색상 기반으로 검색
						imageList = imageServices.getImageListFromColor(search);
					}
					
				}else {
					search.setKeyword(Translater.autoDetectTranslate(keyword,"en"));
					imageList = imageServices.getImageListFromKeyword(search);
				}			
			}			
			
			
			//선택된 이미지의 순서를 랜덤으로 섞어준다. -> 같은 피드의 이미지가 연속으로 나오지 않게 한다.
			Collections.shuffle(imageList);					
			model.addAttribute("imageList", imageList);					
		}	
		
		model.addAttribute("mode", mode);		
		
		
		//외부로 비밀번호와 구글 ID가 노출되지 않도록 한다.
		user.setGoogleId("");
		user.setPassword("");
		model.addAttribute("user", user);
		
		return new ModelAndView("forward:/search/getSearchResult.jsp");
	}
	
	

	//이미지 자세히 보기 최소 세팅 시에만 처리 -> 이후부터는 REST로 페이지 갱신
	@RequestMapping(value = "getSearchImages")
	public ModelAndView getSearchImageList(@RequestParam("imageId") int imageId, HttpSession session, Model model) throws Exception {		
		
		//크게 볼 이미지를 선택
		Image image = imageServices.getImageOne(imageId);				
		
		Search search = new Search();
		search.setPageSize(pageSize);
		search.setCurrentPage(1);
		search.setKeywords(image.getKeyword());
		
		//해당 이미지 제외를 위한 설정 -> keyword에 넣고 싶으나 타입이 맞지않아 searchType에 삽입
		search.setSearchType(image.getImageId());		
		
		//키워드 연관 이미지 추출
		List<Image> relatedImages = imageServices.getImageListFromImage(search);
		
		//추출된 이미지리스트에 있는 이미지가 선택된 이미지의 키워드와 얼마나 유사한 값을 가지고 있는지 체크
		if(relatedImages.size() > 0) {						
			for(Image target : relatedImages) {
				for(ImageKeyword key : image.getKeyword()) {
					if(target.getKeyword().contains(key)) {
						target.setCurrentKeywordSameCount(target.getCurrentKeywordSameCount()+1);
					}					
				}				
			}			
		}	
		
		// 같은 키워드를 많이 가지고 있는 순으로 정렬
		Collections.sort(relatedImages);		
		
				
		model.addAttribute("baseImage", image);
		model.addAttribute("list", relatedImages);
		return new ModelAndView("forward:/search/getSearchImageResult.jsp");
	}	

}
