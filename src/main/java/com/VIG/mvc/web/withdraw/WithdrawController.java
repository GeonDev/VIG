package com.VIG.mvc.web.withdraw;

import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.domain.Withdraw;
import com.VIG.mvc.service.payment.PaymentServices;
import com.VIG.mvc.service.withdraw.WithdrawServices;

@Controller
@RequestMapping("/withdraw/*")
public class WithdrawController {
	
	
	@Autowired
	@Qualifier("paymentServicesImpl")
	private PaymentServices paymentServices;
	
	@Autowired
	@Qualifier("withdrawServicesImpl")
	private WithdrawServices withdrawServices;

	@Value("#{commonProperties['pageSize'] ?: 5}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit'] ?: 5}")
	int pageUnit;
	
	public WithdrawController() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value="getDonationList", method=RequestMethod.GET)
	public ModelAndView getDonationList(HttpSession session) throws Exception {
		
		System.out.println("getDonationList");
		User user = (User)session.getAttribute("user");
		System.out.println(user);
		Search search = new Search();
		String userCode = user.getUserCode();
		search.setKeyword(userCode);
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		Page resultPage = new Page(search.getCurrentPage(), paymentServices.getCountDonation(search) , pageUnit, pageSize);
		
		List<Payment> list = paymentServices.getDonationList(search);
		
		int possibleAmount = paymentServices.getPossiblePrice(userCode);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("resultPage", resultPage);
		mav.addObject("search", search);
		mav.addObject("list", list);
		mav.addObject("possibleAmount", possibleAmount);
		mav.setViewName("forward:/withdraw/getDonationList.jsp");
		
		return mav;
	}

	
	

}
