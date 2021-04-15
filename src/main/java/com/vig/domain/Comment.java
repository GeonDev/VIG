package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="comments")
public class Comment implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long commentId;
	private long feedId;
	private String commentText;
	private User user;
	private Date regDate;
	private Date editDate;
	


}
