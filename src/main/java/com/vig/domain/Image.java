package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Image implements Serializable {

	private static final long serialVersionUID = 1236283424582915L;
	
	private long imageId;
	private long feedId;
	private int feedOrder;
	private int isThumbnail;
	private String imageFile;
	private List<ImageColor> color;
	private List<ImageKeyword> keyword;

	
	public Image() {
		// TODO Auto-generated constructor stub
	}


}
