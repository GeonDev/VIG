package com.VIG.mvc.service.payment.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.payment.PaymentDao;
import com.VIG.mvc.service.payment.PaymentServices;


@Service("paymentServicesImpl")
public class PaymentServicesImpl implements PaymentServices {
	
	@Autowired
	@Qualifier("paymentDaoImpl")
	private PaymentDao paymentDao;
	

	public PaymentServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		
		paymentDao.addPayment(payment);

	}

	@Override
	public void deletePayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public Payment getPayment(String paymentId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Payment> getPaymentList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		return paymentDao.getPaymentList(search);
	}

	@Override
	public int getCountPayment(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		return paymentDao.getCountPayment(search);
		
	}

	@Override
	public void cancelPayment(String paymentId) throws Exception {
		// TODO Auto-generated method stub
		
		paymentDao.cancelPayment(paymentId);
		
	}
	
	
	
	

}
