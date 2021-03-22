package com.vig.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class ImageColor implements Serializable{	
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private int colorId;
	private int ImageId;
	
	private int red;
	private int green;
	private int blue;
	
	private String haxcode;
	
	public ImageColor() {}	
}
