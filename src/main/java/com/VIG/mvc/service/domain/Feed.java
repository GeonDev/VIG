package com.VIG.mvc.service.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class Feed {
	
	private int feedId;
	private String feedTitle;
	private String feedExplanation;
	private User writer;
	private Date feedRegDate;
	private Date feedEditDate;
	private int feedViewCount;
	private int feedIsPrime;
	private String category;
	private String feedUseGears;
	private int feedIsTemp;
	private int primeFeedViewCount;
	private int commentRange;
	private List<JoinUser> coworkers;
	private List<Image> images;
	private List<JoinUser> likes;
	private List<Comment> comments;
	

	public Feed() {
		// TODO Auto-generated constructor stub
	}

}
