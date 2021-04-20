package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="colors")
public class ImageColor implements Serializable{	
	
	private static final long serialVersionUID = 8067729718531214955L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "color_id")
	private long colorId;
	
	@Column(name = "image_id")
	private Image Image;
	
	@Column(name = "color_r" ,nullable = false)
	private int red;
	
	@Column(name = "color_g" ,nullable = false)
	private int green;
	
	@Column(name = "color_b" ,nullable = false)
	private int blue;
	
	@Column(name = "haxcode")
	private String haxcode;
	
}
