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
@Table(name="keyword")
public class ImageKeyword implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="keyword_id")
	private long keywordId;
	
	@Column(name ="image_id")
	@ManyToOne
	private Image image;
	
	// 0= 테그아님 1= 테그
	@Column(name ="is_tag" ,nullable = false)
 	private int isTag;
	
	@Column(name ="user_code")
	@ManyToOne
	private User user;
	
	@Column(name ="keyword_en")
	private String keywordEn;
	
	@Column(name ="keyword_origin")
	private String keywordOrigin;	
	
	@Column(name ="keyword_score")
	private float score;
	



}
