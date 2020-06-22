package com.VIG.mvc.service.domain;

public class ImageColor {	
	
	private float red;
	private float green;
	private float blue;
	
	//이미지에서 해당 색이 차지하는 비율
	private float ratio;
	
	public ImageColor() {}

	public float getRed() {
		return red;
	}

	public void setRed(float red) {
		this.red = red;
	}

	public float getGreen() {
		return green;
	}

	public void setGreen(float green) {
		this.green = green;
	}

	public float getBlue() {
		return blue;
	}

	public void setBlue(float blue) {
		this.blue = blue;
	}

	public float getRatio() {
		return ratio;
	}

	public void setRatio(float ratio) {
		this.ratio = ratio;
	}

	@Override
	public String toString() {
		return "ImageColor [red=" + red + ", green=" + green + ", blue=" + blue + ", ratio=" + ratio + "]";
	}
	
	

}
