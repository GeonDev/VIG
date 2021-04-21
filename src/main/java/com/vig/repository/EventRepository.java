package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.Event;


public interface EventRepository extends JpaRepository<Event, Long>{

	
}
