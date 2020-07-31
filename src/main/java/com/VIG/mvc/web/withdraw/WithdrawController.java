package com.VIG.mvc.web.withdraw;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



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
	public Withdraw getDonationList(HttpSession session) throws Exception {
		
		User user = (User)session.getAttribute("user");
		Search search = new Search();
		search.setKeyword(user.getUserCode());
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		Withdraw withdraw = new Withdraw();
		return withdraw;
	}

	
	

}
