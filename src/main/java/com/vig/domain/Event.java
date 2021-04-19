package com.vig.domain;

import java.io.Serializable;

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
@Table(name="event")
public class Event implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="event_id")
	private Long eventId;
	
	private String eventTitle;
	
	private String eventSub; //부제
	
	private String eventStart; //시작날짜
	
	private String eventEnd; //종료날짜
	
	private String eventThumb; //썸네일

	private String eventTags; //참여하기위한 태그
	
	//이벤트의 내용을 올릴때 사용하는 부분
	private String eventImage;
	
	//이벤트 배너 이미지
	private String banner;
	
	private boolean eventType; //false=일반, true=당첨자발표
	

	


}
