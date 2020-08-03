package com.VIG.mvc.web.withdraw;

import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Page;
import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.domain.Withdraw;
import com.VIG.mvc.service.payment.PaymentServices;
import com.VIG.mvc.service.withdraw.WithdrawServices;
import com.VIG.mvc.web.event.EventController;

@Controller
@RequestMapping("/withdraw/*")
public class WithdrawController {
	
	public static final Logger logger = LogManager.getLogger(WithdrawController.class); 
	
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
		
		logger.debug("getDonationList");
		ModelAndView mav = new ModelAndView();
		if((User)session.getAttribute("user") == null) {
		
		mav.addObject("message", "로그인이 필요합니다.");
		mav.setViewName("forward:../common/alertView.jsp");

		} else {
		User user = (User)session.getAttribute("user");

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
	
		mav.addObject("resultPage", resultPage);
		mav.addObject("search", search);
		mav.addObject("list", list);
		mav.addObject("possibleAmount", possibleAmount);
		mav.setViewName("forward:/withdraw/getDonationList.jsp");
		}
		
		return mav;
	}
	
	@RequestMapping(value="addWithdraw", method=RequestMethod.POST)
	public ModelAndView addWithdraw(HttpSession session, @RequestParam("paymentId") List<String> paymentIds, 
																	@ModelAttribute("withdraw") Withdraw withdraw) throws Exception {
		logger.debug("addWithdraw");
		logger.debug(withdraw);
		logger.debug(paymentIds);
		ModelAndView mav = new ModelAndView();
		if((User)session.getAttribute("user") == null || withdraw.getAmount() <10000) {
			
			mav.addObject("message", "잘못된 접근입니다.");
			mav.setViewName("forward:../common/alertView.jsp");

		} else {
		Payment payment = new Payment();
		String userCode =((User)session.getAttribute("user")).getUserCode();
		withdraw.setUserCode(userCode);
		withdrawServices.addWithdraw(withdraw);
				
				//후원 목록 is_withdraw = 1로 만들어주는 작업
				for(String paymentId: paymentIds) {
					
					System.out.println(paymentId);
					payment.setPaymentId(paymentId);
					paymentServices.updatePayment(payment);
				}
		
		
		mav.setViewName("forward:/withdraw/getWithdrawList");
		}
		
		return mav;
	}
	
	@RequestMapping(value="getWithdrawList", method=RequestMethod.GET)
	public ModelAndView getWithdrawList(HttpSession session, Search search) throws Exception {
		
		logger.debug("getWithdrawList");
		ModelAndView mav = new ModelAndView();
		List<Withdraw> list = null;
		Page resultPage = null;
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			mav.addObject("message", "잘못된 접근입니다.");
			mav.setViewName("forward:../common/alertView.jsp");
			
		}else { 
			
			if (user.getRole() != "admin") {
				
			}else {
				
				search.setKeyword(user.getUserCode());
				
				
			}
				
				search.setPageSize(pageSize);
				
				resultPage = new Page(search.getCurrentPage(), withdrawServices.getCountWithdraw(user.getUserCode()) , pageUnit, pageSize);
				
				list = withdrawServices.getWithdrawList(search);
				mav.addObject("resultPage", resultPage);
				mav.addObject("search", search);
				mav.addObject("list", list);
				mav.setViewName("forward:/withdraw/getWithdrawList.jsp");
		}
		
		
		
		return mav;
	}

	
	

}
