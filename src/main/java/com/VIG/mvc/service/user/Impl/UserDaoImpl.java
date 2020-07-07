package com.VIG.mvc.service.user.Impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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
	public User getUser(int userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.addUser", userId);
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub

	}

}
