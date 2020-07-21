package com.VIG.mvc.service.user.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;
import com.VIG.mvc.service.user.UserDao;


@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao {
			
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	

	public UserDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}	

	@Override
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}
	
	@Override
	public void deleteUser(User user) throws Exception{
		sqlSession.delete("UserMapper.deleteUser", user);
	}


	@Override
	public User getUserOne(String userCode) throws Exception {
		// TODO Auto-generated method stub
		User user = sqlSession.selectOne("UserMapper.getUserOne", userCode);
		return user;
	}


	@Override
	public List<User> getUserListFromName(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserListFromName", search);
	}


	@Override
	public List<String> getAutoUserName(String name) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getAutoUserName", name);
	}
	

	

}
