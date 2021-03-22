package com.vig.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Category;
import com.vig.domain.Feed;
import com.vig.domain.Follow;
import com.vig.domain.Image;
import com.vig.domain.ImageInfo;
import com.vig.domain.ImageKeyword;
import com.vig.domain.LikeUser;
import com.vig.domain.User;
import com.vig.scheduler.WaitingList;
import com.vig.service.FeedService;
import com.vig.service.FollowService;
import com.vig.service.ImageService;
import com.vig.service.KeywordService;
import com.vig.service.LikeService;
import com.vig.util.CommonUtil;
import com.vig.util.Translater;


@Controller
@RequestMapping("feed/*")
public class FeedController {
	
	public static final Logger logger = LoggerFactory.getLogger(FeedController.class); 
	
	@Value("${uploadPath}")
	private String  uploadPath;
	
	@Value("${realPath}")
	private String realPath;

	@Autowired 
	private ImageService imageServices;
	
	@Autowired 
	private KeywordService keywordServices;
	
	@Autowired
	private FeedService feedServices;

	@Autowired
	private LikeService likeServices;
	
	@Autowired	
	private FollowService followServices;
	
	@Autowired
	private ServletContext context;	

	
	public FeedController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	@RequestMapping(value = "addFeedView", method = RequestMethod.GET)
	public ModelAndView addFeedView(@SessionAttribute("user") User user) {
		
		ModelAndView mav = new ModelAndView();
		
		if(user.getRole().equals("admin")) {
			
			String msg = "관리자는 피드작성이 불가능합니다.";				
			return new ModelAndView("common/alertView", "message", msg);
		}
		
		mav.setViewName("feedView/addFeed");
		return mav;
	}
	
	
	@Transactional
	@RequestMapping(value = "addFeed", method = RequestMethod.POST)
	public ModelAndView addFeed(@RequestParam("keyword") String keyword, @ModelAttribute("feed") Feed feed, @ModelAttribute("category") Category category,@RequestParam("uploadFile") List<MultipartFile> files, @SessionAttribute("user") User user) throws Exception {
		
		feed.setWriter(user);									
		feed.setFeedCategory(category);			
		feedServices.addFeed(feed);
							
          
		String path = CommonUtil.getFilePath(context, uploadPath, realPath);
       
		if(files != null) {
			int k=0;	
			
	        for (MultipartFile multipartFile : files) {	        	
	        	k++;	        		        	
	        		
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	        	
	    		File f =new File(path+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);		    		
	    		
	    		Image image = new Image();
	    		String imageFile=inDate+multipartFile.getOriginalFilename();			
	    	    
	    		int getfeedId = feedServices.getLastFeedId();				//마지막 피드아이디 = getfeedId
	    		image.setFeedId(getfeedId);									//이미지에 피드ID,이미지파일 셋
	    		image.setImageFile(imageFile);		
	    		
	    		if(k == files.size()) {
					image.setIsThumbnail(1);										      //썸네일 지정 
	    		}
	    		
	    		imageServices.addImage(image);													    	
	    		
	    		
				String[] originKeyword = keyword.split(","); //스트링으로 받은 키워드를 파싱후 string[]에 담는다
	    			
				if(originKeyword.length > 0) {
					
	   				for(String tag :  originKeyword) {		    				   					

	   					//추가할 단어가 null인지 확인
	   					if(!CommonUtil.null2str(tag).equals("")) {
							ImageKeyword imageKeyword = new ImageKeyword();
							
							imageKeyword.setKeywordOrigin(tag);                //이미지키워드에 오리진키워드 set
							imageKeyword.setIsTag(1);										//태그,키워드 구별
						    String enKeyword = Translater.autoDetectTranslate(tag,"en");																		//오리진 키워드 번역후 en에 set
						    imageKeyword.setKeywordEn(enKeyword);
							imageKeyword.setImageId(imageServices.getLastImageId());		 //키워드 이미지 연결
							
							keywordServices.addKeyword(imageKeyword); 	
	   					}		    		
	   				}  	
				}				
								
				ImageInfo info = new ImageInfo();
				info.setImageId(imageServices.getLastImageId());
				info.setPath(path+imageFile);
				
				//대기 리스트에 이미지 추가
				WaitingList.setWaitImage(info);
	        }			
		}

		
		
		return new ModelAndView("myFeedView/getMyFeedList");
	}
	
	
	@RequestMapping(value="getFeed", method=RequestMethod.GET)
	public ModelAndView getFeed(@RequestParam("feedId") int feedId, HttpSession session, HttpServletRequest request) throws Exception {
		

		Feed feed = feedServices.getFeed(feedId);
		User user = (User)session.getAttribute("user");
		User writer = feed.getWriter();
		

		ModelAndView mav = new ModelAndView();
		mav.setViewName("feedView/getFeed");
		
		if(user !=null) {
			
			//해당 게시글 좋아요, 팔로우 여부 체크
			LikeUser likeUser = new LikeUser();
			likeUser.setFeedId(feedId);
			likeUser.setUser(user);			
			boolean isLike = likeServices.getLikeState(likeUser);
			
			Follow follow = new Follow();
			follow.setTagetUser(user);
			follow.setFollowUser(writer);
			int isFollow = followServices.getFollow(follow);
			
			mav.addObject("isFollow", isFollow);
			mav.addObject("isLike", isLike);			
		}
		
		Feed dbFeed = feedServices.getFeed(feedId);
		mav.addObject("feed", dbFeed);
		
		return mav;		
		}

	
	@RequestMapping(value = "deleteFeed", method = RequestMethod.GET)
	public ModelAndView deleteFeed(HttpSession session, @RequestParam("feedId") int feedId) throws Exception {
		User user = (User)session.getAttribute("user");
		
		logger.info(String.valueOf(feedId));
		feedServices.deleteFeed(feedId);
		
	
		ModelAndView mav = new ModelAndView("redirect: myFeedView/getMyFeedList?userCode="+user.getUserCode());
		
		return mav;
	}
}
