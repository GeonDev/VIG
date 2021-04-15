package com.vig.domain;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ImageInfo implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	private long imageId;
	private String path;
	
}
