package com.VIG.mvc.service.user;

import com.VIG.mvc.service.domain.User;

public interface UserServices {
	
	// INSERT
	public void addUser(User user) throws Exception;

	// SELECT ONE
	public User getUser(int userId) throws Exception;	

	// UPDATE 
	public void updateUser(User user) throws Exception;

}
