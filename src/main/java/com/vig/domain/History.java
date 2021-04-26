package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.vig.domain.enums.HistoryType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="history")
public class History implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="history_id")
	private Long historyId;
	
	@Column(name ="watch_user_code")
	@ManyToOne
	private User watchUser;
	
	@Column(name ="feed_id")
	@ManyToOne
	private Feed showFeed;
	
	@Column(name ="show_date")
	private Date showDate;
	
	@Column(name ="ip_address")
	private String ipAddress;
	
	//0 = 일반 피드 본것 1 = 숨김피드  2 = 프라임 피드 강제 노출
	@Column(name ="history_type")
	@Enumerated(EnumType.STRING)
	private HistoryType historyType;


}
