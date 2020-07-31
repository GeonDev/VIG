package com.VIG.mvc.service.domain;

import java.util.List;

import lombok.Data;

@Data
public class Withdraw {
	
	private int withdrawId;
	private String userCode; //신청자유저코드
	private String holder; //예금주
	private String withdrawDate; //출금신청시간
	private String accNo; //계좌번호
	private String bankName; //은행명
	private int amount; //출금신청한 금액
	private int possibleAmount; //출금가능금액
	private List<Payment> sponsors; //후원한 사람 목록
	
	public Withdraw() {
		// TODO Auto-generated constructor stub
	}

}
