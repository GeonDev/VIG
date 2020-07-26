package com.VIG.mvc.web.payment;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.domain.Feed;
import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.feed.FeedServices;
import com.VIG.mvc.service.payment.PaymentServices;

@Controller
@RequestMapping("/payment/*")
public class PaymentController {
	
	
	@Autowired
	@Qualifier("paymentServicesImpl")
	private PaymentServices paymentServices;
	
	@Autowired
	@Qualifier("feedServicesImpl")
	private FeedServices feedServices;
	
	public PaymentController() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value="addPayment", method=RequestMethod.GET)
	public ModelAndView addPayment(@RequestParam("productType") int productType, @RequestParam("feedId") int feedId) throws Exception {
		
		System.out.println("addPayment:GET");
		System.out.println(productType+" : "+feedId);
		ModelAndView mav = new ModelAndView();
		
		
		//0: 프라임피드결제 , 1: 비즈니스전환결제, 2:후원결제
		if(productType == 0) {
			//프라임 피드 결제
			mav.setViewName("forward:/payment/addPrimeView.jsp");
			
		}
		
		if(productType == 1) {
			//비즈니스 전환 결제
			mav.setViewName("forward:/payment/addBusinessView.jsp");
			
			
		}
		
		if(productType == 2) {
			//후원 결제
			Feed feed = feedServices.getFeed(feedId);
			User writer = feed.getWriter();
			System.out.println(writer);
			
			if(writer.getRole().contains("business")) {
			
			mav.setViewName("forward:/payment/addDonationView.jsp");
			
			mav.addObject("feed", feed);
			
			}
			
		}
		
		return mav;
		
	}
	
	@RequestMapping(value="addDonation", method=RequestMethod.POST)
	public ModelAndView addDonation(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		payment.setBuyer(sessionUser);
		
		
		paymentServices.addPayment(payment);
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("forward:/payment/addPayment.jsp");
		mav.addObject("payment", payment);
		
		return mav;
	}

}
