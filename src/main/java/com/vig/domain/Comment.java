package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
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
	
	private static final long serialVersionUID = 8067729718531214955L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="comment_id")
	private Long commentId;
		
	@ManyToOne
	@Column(name="feed_id")	
	private Feed feed;
	
	@Column(name="comment_text")
	private String comment;
	
	@Column(name="user_code")
	private User writer;
	
	@Column(name="reg_date")
	private Date regDate;
	
	@Column(name="edit_date")
	private Date editDate;
	


}
