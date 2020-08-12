package com.VIG.mvc.service.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class Image implements Serializable {

	private int imageId;
	private int feedId;
	private int feedOrder;
	private int isThumbnail;
	private String imageFile;
	private List<ImageColor> color;
	private List<ImageKeyword> keyword;

	
	public Image() {
		// TODO Auto-generated constructor stub
	}


}
