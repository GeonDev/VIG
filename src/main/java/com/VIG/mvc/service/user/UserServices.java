package com.VIG.mvc.service.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;

public interface UserServices {
	
	// INSERT
	public void addUser(User user) throws Exception;

	// SELECT ONE
	public User getUserOne(String userCode) throws Exception;	
	
	public User getCode(String userCode) throws Exception;

	// UPDATE 
	public void updateUser(User user) throws Exception;
	
	// delete 
	public void deleteUser(User user) throws Exception;
	
	// delete 
	//public void deleteUser(String userCode) throws Exception;

	public List<User> getAllUserList() throws Exception;
	
	
	// user list 
	public Map<String , Object> getUserList( Search search) throws Exception;
	
	// send email
	public boolean sendEmail(String email) throws Exception;
	
	// id check
	public boolean checkDuplication(String userCode) throws Exception;
	
	// 유저의 닉네임으로 리스트를 받아옴 
	public List<User> getUserListFromName(Search search) throws Exception;
	
	//유저 검색 시 자동생성
	public List<String> getAutoUserName(String name) throws Exception;

	public List<User> getBanUserList() throws Exception;
	
	
	//
//	public void loginCheck(String userCode, HttpServletResponse response) throws Exception;
}
