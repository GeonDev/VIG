package com.vig.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Search;
import com.vig.domain.User;
import com.vig.repository.UserMapper;

@Service
public class UserService  {	
	
	@Autowired	  
	private UserMapper userMapper;	
	

	public UserService() {
		// TODO Auto-generated constructor stub
	}
	

	public void addUser(User user) throws Exception {
		userMapper.addUser(user);
	}


	public int getTotalCount(Search search) throws Exception {
		
		return userMapper.getTotalCount(search);
	}


	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userMapper.updateUser(user);
	}
	

	public Map<String , Object > getUserList(Search search) throws Exception{
		
		List<User> list= userMapper.getUserList(search);
		int totalCount = userMapper.getTotalCount(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	
		
	public boolean checkDuplication(String userCode) throws Exception {
		boolean result=true;
		User user=userMapper.getUserOne(userCode);
		if(user != null) {
			result=false;
		}
		return result;
	}
	

	public void deleteUser(User user) throws Exception{
		userMapper.deleteUser(user);
	}


	public User getUserOne(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserOne(userCode);
	}
	

	public List<User> getUserListFromName(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserListFromName(search);
	}


	public List<String> getAutoUserName(String name) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getAutoUserName(name);
	}


	public List<User> getAllUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getAllUserList(search);
	}


	public List<User> getBanUserList() throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getBanUserList();
	}


	public int chcekPw(String password) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}


	
	public User getGoogleID(String googleId) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getGoogleID(googleId);
	}


	
	public int getLastUserNum() throws Exception {		
		//최대값 보다 1큰 값을 전달 => 유저코드 자동 생성용
		return (userMapper.getLastUserNum()+1);
	}

	
	//이메일인증사용
	public boolean duplicationCheck(String email) throws Exception {
		// TODO Auto-generated method stub	
		return userMapper.duplicationCheck(email);
	}

	//유저결제용
	public void updateBusiness(User user) throws Exception {
		// TODO Auto-generated method stub
		
		userMapper.updateBusiness(user);
		
	}


}