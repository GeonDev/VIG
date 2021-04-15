package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.vig.repository.LikerRepository;

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
	private long feedId;
	private String feedTitle;
	private String feedExplanation;
	private User writer;
	private Date feedRegDate;
	private Date feedEditDate;
	private int feedViewCount;
	
	// 0 = 일반피드, 1= 프라임피드
	private int feedIsPrime;
	//카테고리 저장
	private Category feedCategory;
	private String feedUseGears;
	// 0 = 정상등록, 1 = 임시 피드, 2 = 비공개(제재 등)
	private int feedState;
	private int primeFeedViewCount;
	// 0 = 모두 등록, 1= 팔로워만 등록, 2= 등록불가
	private int commentRange;
	private List<Image> images;
	private List<LikeUser> likes;
	private List<Comment> comments;
	
	// 피드가 가지고 있는 키워드 - 서비스에서 세팅해 주어야 한다.
	private List<ImageKeyword> keywords;	



}
