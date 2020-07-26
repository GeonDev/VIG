package com.VIG.mvc.web.history;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.color.ColorServices;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.image.ImageServices;
import com.VIG.mvc.service.keyword.KeywordServices;
import com.VIG.mvc.service.user.UserServices;


@Controller
@RequestMapping("/history/*")
public class HistoryController {
	
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;

	@Autowired 
	@Qualifier("userServicesImpl")
	private UserServices userServices;
	


	public HistoryController() {
		// TODO Auto-generated constructor stub		
	}	
	
	
	@RequestMapping("getMyHistory")
	public ModelAndView getMyHistory(HttpSession session) throws Exception {		
	
				
		return new ModelAndView("forward:/history/getMyHistory.jsp");
	}
	
}