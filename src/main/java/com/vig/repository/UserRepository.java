package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.Search;
import com.vig.domain.User;

public interface UserRepository  extends JpaRepository<User, Long>{
	
}