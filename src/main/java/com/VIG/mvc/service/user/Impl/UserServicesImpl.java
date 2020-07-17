package com.VIG.mvc.service.user.Impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.user.UserDao;
import com.VIG.mvc.service.user.UserServices;


@Service("userServicesImpl")
public class UserServicesImpl implements UserServices {	
	
	@Autowired	  
	@Qualifier("userDaoImpl")
	private UserDao userDao;	

	public UserServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
	}

	@Override
	public User getUser(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
	}
	
	@Override
	public Map<String , Object > getUserList(User user) throws Exception{
		
		return null;
	}
	
	@Override
	public boolean sendEmail(String email) throws Exception{
		
		return false;
	}
	
	@Override
	public boolean checkDuplication(String userCode) throws Exception {
		
		return false;
	}
	
	@Override
	public void deleteUser(User user) throws Exception{
		
	}
	
	
	
	

}
