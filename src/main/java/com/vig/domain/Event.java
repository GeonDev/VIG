package com.vig.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.vig.domain.enums.EventType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="event")
public class Event implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="event_id")
	private Long eventId;
	
	@Column(name ="event_title")
	private String eventTitle;
	
	@Column(name ="event_sub")
	private String eventSub; //부제
	
	@Column(name ="event_start")
	private String eventStart; //시작날짜
	
	@Column(name ="event_end")
	private String eventEnd; //종료날짜
	
	@Column(name ="event_thumbnail")
	private String eventThumb; //썸네일

	@Column(name ="event_tag")
	private String eventTags; //참여하기위한 태그
	
	@Column(name ="event_image")
	//이벤트의 내용을 올릴때 사용하는 부분
	private String eventImage;
	
	@Column(name ="banner")
	//이벤트 배너 이미지
	private String banner;
	
	@Column(name ="event_type")
    @Enumerated(EnumType.STRING)
    private EventType eventType;
	//false=일반, true=당첨자발표
	

	


}
