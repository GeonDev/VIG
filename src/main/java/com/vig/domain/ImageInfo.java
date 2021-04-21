package com.vig.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ImageInfo implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private int imageId;
	private String path;
	
}
