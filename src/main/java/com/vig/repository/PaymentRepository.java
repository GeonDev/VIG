package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long>{

}
