package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

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
@Table(name="history")
public class History implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long historyId;
	private User watchUser;
	private Feed showFeed;
	private Date showDate;
	private String ipAddress;
	//0 = 일반 피드 본것 1 = 숨김피드  2 = 프라임 피드 강제 노출
	private int historyType;


}
