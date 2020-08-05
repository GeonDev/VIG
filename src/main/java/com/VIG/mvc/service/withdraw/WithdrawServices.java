package com.VIG.mvc.service.withdraw;

import java.util.List;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.Withdraw;

public interface WithdrawServices {
	
	public void addWithdraw(Withdraw withdraw) throws Exception;
	
	public void updateWithdraw(Withdraw withdraw) throws Exception;
	
	public List<Withdraw> getWithdrawList(Search search) throws Exception;
	
	public int getCountWithdraw(String userCode) throws Exception;
	
}
