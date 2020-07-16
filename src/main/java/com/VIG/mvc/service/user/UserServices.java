package com.VIG.mvc.service.user;

import java.util.Map;

import com.VIG.mvc.service.domain.User;

public interface UserServices {
	
	// INSERT
	public void addUser(User user) throws Exception;

	// SELECT ONE
	public User getUser(String userCode) throws Exception;	

	// UPDATE 
	public void updateUser(User user) throws Exception;
	
	// delete 
	public void deleteUser(User user) throws Exception;
	
	// delete 
	//public void deleteUser(String userCode) throws Exception;

	// user list 
	public Map<String , Object> getUserList(User user) throws Exception;
	
	// send email
	public boolean sendEmail(String email) throws Exception;
	
	// id check
	public boolean checkDuplication(String userCode) throws Exception;

	
}
