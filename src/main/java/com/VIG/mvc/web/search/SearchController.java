package com.VIG.mvc.web.search;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

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
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.ImageKeyword;
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
	
	
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;

	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;

	
	public SearchController() {
		// TODO Auto-generated constructor stub		
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
		
		//중복제거를 위한 SET
		HashSet<Image> temp = new HashSet<Image>(relatedImages);
		relatedImages = new ArrayList<Image>(temp);
		
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
