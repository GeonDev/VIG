package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.Feed;


public interface FeedRepository extends JpaRepository<Feed, Long> {
	
}
