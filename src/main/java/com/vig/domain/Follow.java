package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="follow")
public class Follow implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="follower_id")
	private long followId;
	
	@Column(name ="user_code")
	private User tagetUser;
	
	@Column(name ="follower_code")
	private User followUser; 
	
	@Column(name ="add_date")
	private Date addDate;
	
	//맞팔로우 상태인지 알려준다
	@Transient
	private String isF4F;
	


}
