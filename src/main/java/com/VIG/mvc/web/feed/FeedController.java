package com.VIG.mvc.web.feed;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.ibatis.javassist.compiler.ast.Keyword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.category.CategoryServices;
import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.Category;
import com.VIG.mvc.service.domain.Event;
import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.ImageColor;
import com.VIG.mvc.service.domain.ImageKeyword;
import com.VIG.mvc.service.domain.JoinUser;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;
import com.VIG.mvc.util.VisionInfo;


@Controller
@RequestMapping("/feed/*")
public class FeedController {
	
	
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
	private ServletContext context;	

	
	public FeedController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	
	@RequestMapping(value = "addFeed", method = RequestMethod.POST)
	public ModelAndView addFeed(@RequestParam("keyword") String keyword,@ModelAttribute("feed") Feed feed, @ModelAttribute("category") Category category,@RequestParam("uploadFile") List<MultipartFile> files) throws Exception {
										
         
				String[] originKeyword = keyword.split(","); //스트링으로 받은 키워드를 파싱후 string[]에 담는다
				
				for(int i =0; i < originKeyword.length;  i++) {			
				int imageId=30000;			//Test용 이미지아이디
				ImageKeyword imageKeyword = new ImageKeyword();          
				imageKeyword.setKeywordOrigin(originKeyword[i]);                //이미지키워드에 오리진키워드 set
				imageKeyword.setImageId(imageId);
		//		keywordServices.addKeyword(imageKeyword);                		  
				System.out.println(imageKeyword);	
				}
									
		
		String userCode = "user11";
		
		User user = userServices.getUserOne(userCode);
		feed.setWriter(user);									
		feed.setFeedCategory(category);	
				
		System.out.println("category :"+category);
		System.out.println("feed : "+feed);			
		System.out.println("추가한 이미지 파일: ");
		
        String path = context.getRealPath("/");        
        path = path.substring(0,path.indexOf("\\.metadata"));         
        path = path +  uploadPath;  
		
        String result = new String("VISION KEY : ");
        List<ImageKeyword> keys = new ArrayList<ImageKeyword>();
        List<ImageColor> colors = new ArrayList<ImageColor>();
        
		if(files !=null) {
	        for (MultipartFile multipartFile : files) {
	        	//파일 업로드시 시간을 이용하여 이름이 중복되지 않게 한다.
	        	String inDate   = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	    
	    		File f =new File(path+inDate+multipartFile.getOriginalFilename());
	    		//원하는 위치에 파일 저장
	    		multipartFile.transferTo(f);	
	    		
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
		
		return new ModelAndView("forward:/common/alertView.jsp", "message", result);
	}	
	
	@RequestMapping(value="getFeed", method=RequestMethod.GET)
	public ModelAndView getFeed(@RequestParam("feedId") int feedId) throws Exception {
		
		Feed feed = feedServices.getFeed(feedId);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/feed/getFeed.jsp");
		mav.addObject("feed", feed);
		
		return mav;
		
	}
	

}
