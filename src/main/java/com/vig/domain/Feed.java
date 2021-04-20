package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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
@Table(name="feeds")
public class Feed implements Serializable {
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="feed_id")
	private Long feedId;
	
	@Column(name ="feed_title")
	private String feedTitle;
	
	@Column(name ="feed_explanation")
	private String feedExplanation;
	
	@Column(name ="user_code")
	@ManyToOne
	private User writer;
	
	@Column(name ="feed_reg_date")
	private Date feedRegDate;
	
	@Column(name ="feed_edit_date")
	private Date feedEditDate;
	
	@Column(name ="feed_view_count")
	private int feedViewCount;
	
	// 0 = 일반피드, 1= 프라임피드
	@Column(name ="feed_is_prime" , nullable = false)
	private int feedIsPrime;
	
	//카테고리 저장
	@Column(name ="category_id")
	@ManyToOne
	private Category feedCategory;
	
	@Column(name ="feed_use_gears")
	private String feedUseGears;
	
	// 0 = 정상등록, 1 = 임시 피드, 2 = 비공개(제재 등)
	@Column(name ="feed_state" , nullable = false)
	private int feedState;
	
	@Column(name ="prime_feed_view_count")
	private int primeFeedViewCount;
	
	// 0 = 모두 등록, 1= 팔로워만 등록, 2= 등록불가
	@Column(name ="comment_range")
	private int commentRange;
	
	@Column(name ="feed_id")
	@OneToMany
	private List<Image> images;
	
	@Column(name ="feed_id")
	@OneToMany
	private List<LikeUser> likes;
	
	@Column(name ="feed_id")
	@OneToMany
	private List<Comment> comments;
	
	// 피드가 가지고 있는 키워드 - 서비스에서 세팅해 주어야 한다.
	// private List<ImageKeyword> keywords;	



}
