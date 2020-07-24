package com.VIG.mvc.service.domain;

import lombok.Data;

@Data
public class Payment {
	
	//import에서 오는 결제 uid
	private String paymentId;
	//구매자(후원자)
	private User buyer;
	//후원시엔 후원을 받을 사람
	private User beneficiary;
	//0: 카드, 1: 실시간계좌이체
	private int paymentOption;
	//0: 프라임피드결제 , 1: 비즈니스전환결제, 2:후원결제
	private int productType;
	//후원 결제시 선택한 금액 = 후원금액
	private int selectPrice;
	//실제 결제한 금액
	private int lastPrice;
	private String productName;
	private String paymentDate;
	//0:출금 전, 1:출금 후
	private int isWithdraw;
	//0: 결제취소가능, 1:결제취소불가, 2:결제취소상태
	private int isCancel;
	
	public Payment() {
		// TODO Auto-generated constructor stub
	}

}
