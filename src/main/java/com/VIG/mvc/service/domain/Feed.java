package com.VIG.mvc.service.domain;

import java.util.List;

import lombok.Data;

@Data
public class Feed {
	
	private int feedId;
	private String feedTitle;
	private String feedExplanation;
	private User writer;
	private String feedRegDate;
	private String feedEditDate;
	private int feedIikes;
	private int feedViewCount;
	private int feedIsPrime;
	private Category category;
	private String feedUseGears;
	private int feedIsTemp;
	private int primeFeedViewCount;
	private int commentRange;
	private List<Coworker> cowakers;
	private List<Image> images;
	

	public Feed() {
		// TODO Auto-generated constructor stub
	}

}
