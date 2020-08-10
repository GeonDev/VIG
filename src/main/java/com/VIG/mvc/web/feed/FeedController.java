package com.VIG.mvc.web.feed;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.comment.CommentServices;
import com.VIG.mvc.service.domain.Category;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Follow;
import com.VIG.mvc.service.domain.History;
import com.VIG.mvc.service.domain.Image;
import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.follow.FollowServices;
import com.VIG.mvc.service.history.HistoryServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.like.LikeServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.CommonUtil;
import com.VIG.mvc.util.VisionInfo;
import com.VIG.mvc.web.main.mainController;


@Controller
@RequestMapping("/feed/*")
public class FeedController {
	
	public static final Logger logger = LogManager.getLogger(FeedController.class); 
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;

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
	
	@Autowired
	@Qualifier("commentServicesImpl")
	private CommentServices commentServices;
	
	@Autowired
	@Qualifier("likeServicesImpl")
	private LikeServices likeServices;
	
	@Autowired
	@Qualifier("followServicesImpl")
	private FollowServices followServices;
	
	
	

	@Autowired
	private ServletContext context;	

	
	public FeedController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	
	@RequestMapping(value = "addFeed", method = RequestMethod.POST)
	public ModelAndView addFeed(@RequestParam("keyword") String keyword,@ModelAttribute("feed") Feed feed, @ModelAttribute("category") Category category,@RequestParam("uploadFile") List<MultipartFile> files, @SessionAttribute("user") User user,@ModelAttribute("joinUser") JoinUser joinUser) throws Exception {
		
		feed.setWriter(user);									
		feed.setFeedCategory(category);			
		feedServices.addFeed(feed);
							
        String path = context.getRealPath("/");        
        path = path.substring(0,path.indexOf("\\.metadata"));         
        path = path +  uploadPath;  
		
        String result = new String("VISION KEY : ");
        List<ImageKeyword> keys = new ArrayList<ImageKeyword>();
        List<ImageColor> colors = new ArrayList<ImageColor>();
        
        
		if(files !=null) {
			int k=0;	
			
	        for (MultipartFile multipartFile : files) {
	        	System.out.println("이미지순서: "+ k++);
	        	
	        		
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	        	
	    		File f =new File(path+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);		    		
	    		
	    		Image image = new Image();
	    		String imageFile=inDate+multipartFile.getOriginalFilename();
	    	    System.out.println("imageFile:"+imageFile);
	    	    
	    	    
	    	    
	    		int getfeedId = feedServices.getLastFeedId();				//마지막 피드아이디 = getfeedId
	    		image.setFeedId(getfeedId);											//이미지에 피드ID,이미지파일 셋
	    		image.setImageFile(imageFile);		
	    		
	    		if(k == files.size()) {
					image.setIsThumbnail(1);										      //썸네일 지정 
	    		}
	    		
	    		imageServices.addImage(image);												
				
	    		int imageId = imageServices.getLastImageId();				//마지막 이미지Id를 뽑는다
	    	
	    		
	    		
				String[] originKeyword = keyword.split(","); //스트링으로 받은 키워드를 파싱후 string[]에 담는다
	    									
   				for(int i =0; i < originKeyword.length;  i++) {			    			
   					
	    					ImageKeyword imageKeyword = new ImageKeyword();
	    				
	    					imageKeyword.setKeywordOrigin(originKeyword[i]);                //이미지키워드에 오리진키워드 set
	    					imageKeyword.setIsTag(1);														  //태그,키워드 구별
	    					imageKeyword.setImageId(imageId);										  //키워드 이미지 연결
	    					
	    					keywordServices.addKeyword(imageKeyword);                		  
	    					System.out.println(imageKeyword);	
	    					}
   							System.out.println(image);
	  
	    		//keys = VisionInfo.getKeywordForVision(path+inDate+multipartFile.getOriginalFilename());	    			
	    		//colors = VisionInfo.getColorForVision(path+inDate+multipartFile.getOriginalFilename());
			}
	        
		}		
		
		if(keys.size() > 1) {
			for(ImageKeyword word : keys) {				
				result +=" "+word.getKeywordEn();
				
			}
		}	
		
		if(colors.size() > 1) {
			for(ImageColor color : colors) {
				result +=" R: "+color.getRed();
				result +=" G: "+color.getGreen();
				result +=" B: "+color.getBlue();
				result +=" Ratio: "+color.getRatio();
				
			}
			
		}	
		
		
		return new ModelAndView("forward:/history/getMyHistoryList?userCode="+user.getUserCode());
	}		
	
	@RequestMapping(value="getFeed", method=RequestMethod.GET)
	public ModelAndView getFeed(@RequestParam("feedId") int feedId, HttpSession session, HttpServletRequest request) throws Exception {
		
		System.out.println(feedId);
		Feed feed = feedServices.getFeed(feedId);
		System.out.println(feed);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/feed/getFeed.jsp");
		mav.addObject("feed", feed);
		
		//ip로 조회수 counting 하는 부분
		String ipAddress = CommonUtil.getUserIp(request);
		System.out.println(ipAddress);
		
		User user = (User)session.getAttribute("user");
		User writer = feed.getWriter();
		System.out.println("User"+user);
		System.out.println("Writer"+writer);
		
		
		
		// 로그인한 유저정보가 있는지 체크 - 히스토리를 남기는 부분입니다. 삭제 X(손건)
		History history = new History();		
		history.setWatchUser(user);
		history.setHistoryType(0);
		history.setShowFeed(feed);
		history.setIpAddress(ipAddress);
		
		if(user !=null) {
			
			//좋아요, 팔로우 여부 체크
			JoinUser joinUser = new JoinUser();
			joinUser.setFeedId(feedId);
			joinUser.setUser(user);
			joinUser.setIsLike(1);
			boolean isLike = likeServices.getLikeState(joinUser);
			
			Follow follow = new Follow();
			follow.setFollowingUser(user);
			follow.setFollowedUser(writer);
			int isFollow = followServices.getFollow(follow);
			
			mav.addObject("isFollow", isFollow);
			mav.addObject("isLike", isLike);
			
			System.out.println("회원조회");
			
			int count = historyServices.getViewHistory(history);
			System.out.println(count);
			if(count == 0 ) {
			
				feedServices.updateViewCount(feedId);
				historyServices.addHistory(history);
			}
			//historyServices.addHistory(history);
			
		
		}//비회원이면
		else if(user==null) {
				System.out.println("비회원 조회");
					int count = historyServices.getViewHistory(history);
					System.out.println(count);
					if(count == 0 ) {
						
						historyServices.addHistory(history);
						feedServices.updateViewCount(feedId);
						
					}
			
		}		
		
		return mav;
		
		}
		
	

}
