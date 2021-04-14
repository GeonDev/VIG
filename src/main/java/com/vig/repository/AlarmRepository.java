package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.Alarm;

public interface AlarmRepository extends JpaRepository<Alarm, Long> {
	


}
