package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.LikeUser;

public interface LikerRepository extends JpaRepository<LikeUser, Long> {

}
