package com.VIG.mvc.service.payment.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.Payment;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.payment.PaymentDao;

@Repository("paymentDaoImpl")
public class PaymentDaoImpl implements PaymentDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public PaymentDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPayment(Payment payment) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.insert("PaymentMapper.addPayment", payment);
		

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
		
		
		List<Payment> list = sqlSession.selectList("PaymentMapper.getPaymentList", search);

		
		return list;
	}

	@Override
	public int getCountPayment(Search search) throws Exception {
		// TODO Auto-generated method stub

		return sqlSession.selectOne("PaymentMapper.getCountPayment", search);
	}

	@Override
	public void cancelPayment(String paymentId) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.update("PaymentMapper.cancelPayment", paymentId);
		
	}
	
	

}
