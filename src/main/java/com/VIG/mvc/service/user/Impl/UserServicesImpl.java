package com.VIG.mvc.service.user.Impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Search;
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
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateUser(user);
	}
	
	@Override
	public Map<String , Object > getUserList(Search search) throws Exception{
		
		return null;
	}
	
	@Override
	public boolean sendEmail(String email) throws Exception{
		
		return false;
	}
	
	@Override
	public boolean checkDuplication(String userCode) throws Exception {
		boolean result=true;
		User user=userDao.getUserOne(userCode);
		if(user != null) {
			result=false;
		}
		return result;
	}
	
	@Override
	public void deleteUser(User user) throws Exception{
		
	}

	@Override
	public User getUserOne(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserOne(userCode);
	}
	
	@Override
	public User getCode(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getCode(userCode);
	}

	@Override
	public List<User> getUserListFromName(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserListFromName(search);
	}

	@Override
	public List<String> getAutoUserName(String name) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getAutoUserName(name);
	}

	@Override
	public List<User> getAllUserList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getAllUserList();
	}


	
	//
	//@Override
	//public void loginCheck(String userCode, HttpServletResponse response) throws Exception {
	//}
	
	
	

}
