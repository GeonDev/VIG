package com.mvc.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mvc.vig.domain.Payment;
import com.mvc.vig.domain.Search;


@Mapper
public interface PaymentMapper {

	
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
