package com.VIG.mvc.service.user.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	public int getTotalCount(Search search) throws Exception {
		
		return userDao.getTotalCount(search);
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateUser(user);
	}
	
	@Override
	public Map<String , Object > getUserList(Search search) throws Exception{
		
		List<User> list= userDao.getUserList(search);
		int totalCount = userDao.getTotalCount(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public boolean sendEmail(String email) throws Exception{
		
		return false;
	}
		
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
		userDao.deleteUser(user);
	}

	@Override
	public User getUserOne(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserOne(userCode);
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

	@Override
	public List<User> getBanUserList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getBanUserList();
	}

	@Override
	public int chcekPw(String password) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public User getGoogleID(String googleId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getGoogleID(googleId);
	}


	@Override
	public int getLastUserNum() throws Exception {		
		//최대값 보다 1큰 값을 전달
		return (userDao.getLastUserNum()+1);
	}

	
	//이메일인증사용
	@Override
	public boolean duplicationCheck(String email) throws Exception {
		// TODO Auto-generated method stub	
		return userDao.duplicationCheck(email);
	}


}