package com.VIG.mvc.service.withdraw.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.Withdraw;
import com.VIG.mvc.service.payment.PaymentDao;
import com.VIG.mvc.service.payment.PaymentServices;
import com.VIG.mvc.service.withdraw.WithdrawDao;
import com.VIG.mvc.service.withdraw.WithdrawServices;


@Service("withdrawServicesImpl")
public class WithdrawServicesImpl implements WithdrawServices {
	
	@Autowired
	@Qualifier("withdrawDaoImpl")
	private WithdrawDao withdrawDao;
	

	public WithdrawServicesImpl() {
		// TODO Auto-generated constructor stub
	}


	@Override
	public void addWithdraw(Withdraw withdraw) throws Exception {
		// TODO Auto-generated method stub
		
		withdrawDao.addWithdraw(withdraw);
		
	}

	@Override
	public void updateWithdraw(Withdraw withdraw) throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<Withdraw> getWithdrawList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return withdrawDao.getWithdrawList(search);
	}
	
	
	
	

}
