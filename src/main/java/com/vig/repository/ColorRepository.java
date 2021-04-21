package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.ImageColor;


public interface ColorRepository extends JpaRepository<ImageColor, Long>{
	


}
