package com.vig.domain;



import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
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
@Table(name="withdraw")
public class Withdraw implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name ="withdraw_id")
	private Long withdrawId;
	
	@Column(name ="user_code")
	@ManyToOne
	private User user; //신청자유저코드
	
	@Column(name ="acc_holder")
	private String holder; //예금주
	
	@Column(name ="withdraw_date")
	private String withdrawDate; //출금신청시간
	
	@Column(name ="acc_no")
	private String accNo; //계좌번호
	
	@Column(name ="bank_code")
	private int bankCode; //은행코드
	
	@Column(name ="amount")
	private int amount; //출금신청한 금액
	
	@Transient
	private int possibleAmount; //출금가능금액
	


}
