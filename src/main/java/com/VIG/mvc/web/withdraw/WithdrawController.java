package com.VIG.mvc.web.withdraw;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.payment.PaymentServices;
import com.VIG.mvc.service.user.UserServices;

@Controller
@RequestMapping("/payment/*")
public class WithdrawController {
	
	
	@Autowired
	@Qualifier("paymentServicesImpl")
	private PaymentServices paymentServices;
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	public WithdrawController() {
		// TODO Auto-generated constructor stub
	}
	

	
	

}
