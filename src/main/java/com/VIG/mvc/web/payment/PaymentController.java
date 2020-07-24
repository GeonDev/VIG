package com.VIG.mvc.web.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.VIG.mvc.service.payment.PaymentServices;

@Controller
@RequestMapping("/payment/*")
public class PaymentController {
	
	
	@Autowired
	@Qualifier("paymentServicesImpl")
	private PaymentServices paymentServices;
	
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
			mav.setViewName("forward:/VIG/payment/addPrimeView.jsp");
			
		} else if(productType == 1) {
			//비즈니스 전환 결제
			mav.setViewName("forward:/VIG/payment/addBusinessView.jsp");
			
			
		}else if(productType == 2) {
			//후원 결제
			mav.setViewName("forward:/VIG/payment/addDonationView.jsp");
			mav.addObject("feedId", feedId);
		}
		
		return mav;
		
	}

}
