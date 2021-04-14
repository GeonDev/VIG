package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Payment;
import com.vig.domain.Search;
import com.vig.repository.PaymentRepository;


@Service
public class PaymentService {
	
	@Autowired
	private PaymentRepository paymentMapper;
	

	public PaymentService() {
		// TODO Auto-generated constructor stub
	}


	public void addPayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		
		paymentMapper.addPayment(payment);

	}


	public void deletePayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub

	}


	public Payment getPayment(String paymentId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	public List<Payment> getPaymentList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		return paymentMapper.getPaymentList(search);
	}


	public int getCountPayment(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		return paymentMapper.getCountPayment(search);
		
	}


	public void cancelPayment(String paymentId) throws Exception {
		// TODO Auto-generated method stub
		
		paymentMapper.cancelPayment(paymentId);
		
	}


	public List<Payment> getDonationList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		return paymentMapper.getDonationList(search);
	}


	public int getCountDonation(Search search) throws Exception {
		// TODO Auto-generated method stub	
		return paymentMapper.getCountDonation(search);
	}
	
	public int getPossiblePrice(String userCode) throws Exception {
		
		return paymentMapper.getPossiblePrice(userCode);
	}


	public void updatePayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		
		paymentMapper.updatePayment(payment);
		
	}
	
	
	
	

}
