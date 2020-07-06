package com.VIG.mvc.user.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.user.UserDao;
import com.VIG.mvc.user.UserServices;



@Service("userServiceImpl")
public class UserServicesImpl implements UserServices {	
	
	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	

	public UserServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public User getUser(int userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub

	}

}
