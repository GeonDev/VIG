package com.vig.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vig.domain.Feed;
import com.vig.domain.Page;
import com.vig.domain.Payment;
import com.vig.domain.Search;
import com.vig.domain.User;
import com.vig.service.FeedService;
import com.vig.service.PaymentService;
import com.vig.service.UserService;

@Controller
@RequestMapping("/payment/*")
public class PaymentController {
	
	
	@Autowired
	private PaymentService paymentServices;
	
	@Autowired	
	private FeedService feedServices;
	
	@Autowired
	private UserService userServices;

	@Value("${pageUnit}")
	int pageUnit;

	@Value("${pageSize}")
	int pageSize;
	
	public PaymentController() {
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping(value="addPayment", method=RequestMethod.GET)
	public ModelAndView addPayment(@RequestParam("productType") int productType, HttpServletRequest request) throws Exception {
		

		ModelAndView mav = new ModelAndView();
		
		
		//0: 프라임피드결제 , 1: 비즈니스전환결제, 2:후원결제
		if(productType == 0) {
			//프라임 피드 결제
			mav.setViewName("paymentView/addPrimeView");
		}
		
		if(productType == 1) {
			//비즈니스 전환 결제
			mav.setViewName("paymentView/addBusinessView");
		}
		
		if(productType == 2) {
			//후원 결제
			int feedId = Integer.parseInt(request.getParameter("feedId"));

			Feed feed = feedServices.getFeed(feedId);
			User writer = feed.getWriter();
			
			
			if(writer.getRole().contains("business")) {
			
				mav.setViewName("paymentView/addDonationView");
				
				mav.addObject("feed", feed);
			
			}
			
		}
		
		return mav;
		
	}
	//후원추가
	@RequestMapping(value="addDonation", method=RequestMethod.POST)
	public ModelAndView addDonation(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		payment.setBuyer(sessionUser);
		
		
		paymentServices.addPayment(payment);
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("paymentView/addPayment");
		mav.addObject("payment", payment);
		
		return mav;
	}
	//프라임피드 1000건 추가
	@RequestMapping(value="addPrime", method=RequestMethod.POST)
	public ModelAndView addPrime(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		
		User dbuser = userServices.getUserOne(sessionUser.getUserCode());
		//db에서 user정보 가져와서 Setting 해주기
		int count = dbuser.getPrimeCount();
		count = count+1000;
		dbuser.setPrimeCount(count);
		
		userServices.updateBusiness(dbuser);
		
		payment.setBuyer(dbuser);
		paymentServices.addPayment(payment);
		
		session.setAttribute("user", dbuser);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("paymentView/addPayment");
		mav.addObject("payment", payment);
		return mav;
	}
	//비즈니스유저로 변경
	@RequestMapping(value="addBusiness", method=RequestMethod.POST)
	public ModelAndView addBusiness(@ModelAttribute("payment") Payment payment, HttpSession session) throws Exception {
		
		System.out.println(payment);
		User sessionUser = (User)session.getAttribute("user");
		
		User dbuser = userServices.getUserOne(sessionUser.getUserCode());
		//db에서 user정보 가져와서 Setting 해주기
		dbuser.setRole("business");
		int count = dbuser.getPrimeCount();
		count = count+1000;
		dbuser.setPrimeCount(count);
		
		userServices.updateBusiness(dbuser);
		
		//업데이트 한 유저정보로 바꿔준다.
		payment.setBuyer(dbuser);
		
		System.out.println(payment);
		paymentServices.addPayment(payment);
		
		session.setAttribute("user", dbuser);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("paymentView/addPayment");
		mav.addObject("payment", payment);
		return mav;
	}
	
	
	@RequestMapping(value="getPaymentList")
	public ModelAndView getPaymentList(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		User user = (User) session.getAttribute("user");
		search.setKeyword(user.getUserCode());
		// 현재 페이지값이 없으면 첫번째 페이지로 설정
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		//키워드 데이터가 NULL이라면
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		
		search.setPageSize(pageSize);
		
		System.out.println(search);
		
		List<Payment> list = paymentServices.getPaymentList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), paymentServices.getCountPayment(search) , pageUnit, pageSize);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("paymentView/getPaymentList");
		mav.addObject("list", list);
		mav.addObject("writer", userServices.getUserOne(user.getUserCode()));
		mav.addObject("resultPage", resultPage);
		
		return mav;
	}
	
	@RequestMapping(value="cancelPayment", method=RequestMethod.GET)
	public ModelAndView cancelPayment(@RequestParam("paymentId") String paymentId, HttpSession session) throws Exception {
		
		paymentServices.cancelPayment(paymentId);
		
		ModelAndView mav = new ModelAndView();
		User user = (User)session.getAttribute("user");
		if(user.getRole().contains("admin")) {
		mav.setViewName("redirect:/paymentView/getAllPaymentList");	
			
		}else {
		mav.setViewName("redirect:/paymentView/getPaymentList");
		}
		return mav;
	}
	
	@RequestMapping(value="getAllPaymentList")
	public ModelAndView getAllPaymentList(HttpSession session, @ModelAttribute("search") Search search) throws Exception {
		
		
		ModelAndView mav = new ModelAndView();
		
		User user = (User)session.getAttribute("user");
				
		search = new Search();
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}		
		search.setPageSize(pageSize);
		List<Payment> list = paymentServices.getPaymentList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), paymentServices.getCountPayment(search) , pageUnit, pageSize);
		
		mav.setViewName("paymentView/getAllPaymentList");
		mav.addObject("list", list);
		mav.addObject("writer", userServices.getUserOne(user.getUserCode()));
		mav.addObject("resultPage", resultPage);
		
		
		return mav;
	}
	
	

}
