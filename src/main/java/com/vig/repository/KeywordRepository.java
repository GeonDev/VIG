package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.ImageKeyword;



public interface KeywordRepository  extends JpaRepository<ImageKeyword, Long>{
	


}
