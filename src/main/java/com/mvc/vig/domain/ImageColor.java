package com.mvc.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class ImageColor implements Serializable{	
	
	private int colorId;
	private int ImageId;
	
	private int red;
	private int green;
	private int blue;
	
	private String haxcode;
	
	public ImageColor() {}	
}
