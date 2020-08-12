package com.VIG.mvc.service.user;

import java.util.List;

import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.domain.User;

public interface UserDao {
	
	// INSERT
	public void addUser(User user) throws Exception;

	// SELECT ONE
	public User getUserOne(String userCode) throws Exception;	

	// UPDATE 
	public void updateUser(User user) throws Exception;	
	
	////
	public List<User> getUserList(Search search) throws Exception;
	
	// delete 
	public void deleteUser(User user) throws Exception;

	// 유저의 닉네임으로 리스트를 받아옴 
	public List<User> getUserListFromName(Search search) throws Exception;
	
	//유저 검색 시 자동생성
	public List<String> getAutoUserName(String name) throws Exception;

	//유저 전체를 받아옴 - 최초 해쉬 세팅용
	public List<User> getAllUserList() throws Exception;
	
	//일시 정지 유저를 받아옴
	public List<User> getBanUserList() throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception;
	
	//구글 로그인 체크
	public User getGoogleID(String googleId) throws Exception ;
	
	//소셜로그인 시 userCode 자동 생성을 위한 번호 갖고오기
	public int getLastUserNum() throws Exception;

	
	//이메일인증사용
	public boolean duplicationCheck(String email) throws Exception;
	
	//유저 결제용
	public void updateBusiness(User user) throws Exception;
	

	
}