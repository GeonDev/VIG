package com.VIG.mvc.service.withdraw;

import java.util.List;

import com.VIG.mvc.service.domain.Withdraw;

public interface WithdrawDao {
	
	public void addWithdraw(Withdraw withdraw) throws Exception;
	
	public void updateWithdraw(Withdraw withdraw) throws Exception;
	
	//내 후원목록
	public Withdraw getDonaionList(String userCode) throws Exception;
	
	public List<Withdraw> getWithdrawList(String userCode) throws Exception;
	

}
