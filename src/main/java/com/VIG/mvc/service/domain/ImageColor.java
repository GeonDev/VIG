package com.VIG.mvc.service.domain;

public class ImageColor {	
	
	private float red;
	private float green;
	private float blue;
	
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

	@Override
	public String toString() {
		return "ImageColor [red=" + red + ", green=" + green + ", blue=" + blue + "]";
	}

}
