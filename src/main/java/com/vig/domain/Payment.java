package com.vig.domain;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
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
@Table(name="payment")
public class Payment implements Serializable{
	
	private static final long serialVersionUID = 8067729718531214955L;
	
	//import에서 오는 결제 uid
	@Id	
	@Column(name ="payment_id")
	private String paymentId;
	
	//구매자(후원자)
	@Column(name ="buyer")
	@ManyToOne
	private User buyer;
	
	//후원시엔 후원을 받을 사람과 피드정보
	@Column(name ="beneficiary")
	private String beneficiary;
	
	@Column(name ="feed_id")
	@ManyToOne
	private Feed feed;
	
	//0: 카드, 1: 실시간계좌이체
	@Column(name ="payment_option", nullable = false)
	private int paymentOption;
	
	//0: 프라임피드결제 , 1: 비즈니스전환결제, 2:후원결제
	@Column(name ="product_type", nullable = false)
	private int productType;
	
	//후원 결제시 선택한 금액 = 후원금액
	@Column(name ="select_price", nullable = false)
	private int selectPrice;
	//실제 결제한 금액
	@Column(name ="last_price", nullable = false)
	private int lastPrice;
	
	@Column(name ="payment_date")
	private String paymentDate;
	//0:출금 전, 1:출금 후
	
	@Column(name ="is_withdraw", nullable = false)
	private int isWithdraw;
	
	@Column(name ="is_cancel", nullable = false)
	//0: 정상결제상태 1:결제취소상태
	private int isCancel;
	


}
