package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="alarm")
public class Alarm implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "alarm_Id")
	private long alarmId;
	
	@ManyToOne
	@JoinColumn(name = "send_user_code")
	private User sendUser;
	
	@ManyToOne
	@JoinColumn(name = "receive_user_code")
	private User reciveUser;
	
	@ManyToOne
	@JoinColumn(name = "like_feed_id")
	private Feed likefeed;
	
	@Column(name = "is_watch", nullable = false)
	private int isWatch;
	
	// 자바의 기본타입에는 NULL을 입력할수 없기 때문에 nullable 옵션을 추가하여야 한다.
	// 0 = 피드 좋아요, 1= 피드 댓글, 2=팔로우
	@Column(name = "alarm_type", nullable = false)
	private int alarmType;		
	
	@Column(name = "add_date")
	private Date addDate;	
	
	// @Transient는 데이터베이스에 매핑하지 않는다는 선언
	// 0 = 확인안함 1 = 확인함
	@Transient					
	private String message; 	

}
