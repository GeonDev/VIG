package com.vig.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vig.domain.Comment;


public interface CommentRepository extends JpaRepository<Comment, Long>{
	
}
