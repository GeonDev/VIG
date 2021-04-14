package com.vig.domain;



import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Withdraw implements Serializable{
	
	private static final long serialVersionUID = 1236283424582915L;
	
	private long withdrawId;
	private String userCode; //신청자유저코드
	private String holder; //예금주
	private String withdrawDate; //출금신청시간
	private String accNo; //계좌번호
	private int bankCode; //은행코드
	private int amount; //출금신청한 금액
	private int possibleAmount; //출금가능금액
	


}
