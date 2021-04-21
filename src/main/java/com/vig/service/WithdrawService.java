package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Search;
import com.vig.domain.Withdraw;
import com.vig.repository.WithdrawMapper;




@Service
public class WithdrawService{
	
	@Autowired
	private WithdrawMapper withdrawMapper;
	

	public WithdrawService() {
		// TODO Auto-generated constructor stub
	}


	public void addWithdraw(Withdraw withdraw) throws Exception {
		// TODO Auto-generated method stub
		
		withdrawMapper.addWithdraw(withdraw);
		
	}


	public void updateWithdraw(Withdraw withdraw) throws Exception {
		// TODO Auto-generated method stub
		
	}


	
	public List<Withdraw> getWithdrawList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return withdrawMapper.getWithdrawList(search);
	}


	
	public int getCountWithdraw(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return withdrawMapper.getCountWithdraw(userCode);
	}
	
	
	
	

}
