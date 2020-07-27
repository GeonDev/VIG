package com.VIG.mvc.service.payment;

import java.util.List;

import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;

public interface PaymentServices {
	
	public void addPayment(Payment payment) throws Exception;
	
	public void deletePayment(Payment payment) throws Exception;
	
	public Payment getPayment(String paymentId) throws Exception;
	
	public List<Payment> getPaymentList(Search search) throws Exception;	
	
	public int getCountPayment(Search search) throws Exception;

}
