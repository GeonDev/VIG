package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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
@Table(name="images")
public class Image implements Serializable {

	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "image_id")
	private Long imageId;
	
	@Column(name = "feed_id")
	@ManyToOne
	private Feed feed;
	
	@Column(name = "feed_order" , nullable = false)
	private int feedOrder;
	
	@Column(name = "is_thumbnail", nullable = false)
	private int isThumbnail;
	
	@Column(name = "image_file")
	private String imageFile;
	

	@OneToMany
	private List<ImageColor> color;
	

	@OneToMany
	private List<ImageKeyword> keyword;

}
