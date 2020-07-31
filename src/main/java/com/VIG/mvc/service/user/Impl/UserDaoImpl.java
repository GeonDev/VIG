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
	public User getCode(String userCode) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getUserOne", userCode);
	}
	
	@Override
	public List<User> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserList",search);
		
	}
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
		@Override
		public int getTotalCount(Search search) throws Exception {
			return sqlSession.selectOne("UserMapper.getTotalCount", search);
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


	@Override
	public List<User> getAllUserList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getAllUserList");
	}


	@Override
	public List<User> getBanUserList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getBanUserList");
	}

		
	
//	@Override
	//public int loginCheck(String userCode) throws Exception {
		// TODO Auto-generated method stub
//		return sqlSession.selectOne("UserMapper.loginCheck", userCode);
//	}

}
