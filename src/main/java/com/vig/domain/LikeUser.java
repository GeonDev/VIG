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
@Table(name="liker")
public class LikeUser implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="liker_id")
	private long likeId;
	
	@Column(name ="user_code")
	@ManyToOne
	private User user;	
	
	@Column(name ="feed_id")
	@ManyToOne
	private Feed feed;
	
	@Column(name ="add_date")
	private Date addDate;
	



}
