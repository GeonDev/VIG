package com.VIG.mvc.service.user;

import java.util.List;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;

public interface UserDao {
	
	// INSERT
	public void addUser(User user) throws Exception;

	// SELECT ONE
	public User getUserOne(String userCode) throws Exception;	
	

	// UPDATE 
	public void updateUser(User user) throws Exception;	
	
	// delete 
	public void deleteUser(User user) throws Exception;

	// 유저의 닉네임으로 리스트를 받아옴 
	public List<User> getUserListFromName(Search search) throws Exception;
	
	//유저 검색 시 자동생성
	public List<String> getAutoUserName(String name) throws Exception;

	
	
	
	
	//int loginCheck(String userCode) throws Exception;
	
		
	//
	//public boolean loginCheck(User user) throws Exception;

	
}
