package com.VIG.mvc.service.payment;

import java.util.List;

import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;

public interface PaymentDao {

	
	public void addPayment(Payment payment) throws Exception;
	
	public void deletePayment(Payment payment) throws Exception;
	
	public void cancelPayment(String paymentId) throws Exception;
	
	public Payment getPayment(String paymentId) throws Exception;
	
	public void updatePayment(Payment payment) throws Exception;
	
	public List<Payment> getPaymentList(Search search) throws Exception;
	
	public int getCountPayment(Search search) throws Exception;

	List<Payment> getDonationList(Search search) throws Exception;

	public int getCountDonation(Search search) throws Exception;

	public int getPossiblePrice(String userCode) throws Exception;


}
