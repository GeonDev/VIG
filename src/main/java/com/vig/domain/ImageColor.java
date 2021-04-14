package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ImageColor implements Serializable{	
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private long colorId;
	private long ImageId;
	
	private int red;
	private int green;
	private int blue;
	
	private String haxcode;
	
}
