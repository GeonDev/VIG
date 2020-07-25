package com.VIG.mvc.service.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class ImageColor implements Serializable{	
	
	private int colorId;
	private int ImageId;
	
	private int red;
	private int green;
	private int blue;
	
	//이미지에서 해당 색이 차지하는 비율
	private float ratio;
	
	//이미지 헥사코드
	private String haxcode;
	
	public ImageColor() {}

}
