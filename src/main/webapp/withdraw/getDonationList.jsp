<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>VIG</title>

<!-- JQuery -->
	
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
	<!-- 폰트 -->
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Nanum+Myeongjo&display=swap&subset=korean" rel="stylesheet">


		<!-- JQuery -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	<!--  아임포트 결제 구현  -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	
<style>
	
	body {
		
		font-family: "Nanum Gothic", sans-serif;

	
	}
	
	#main { 
		width: 960px;
		margin-top: 70px;
		margin-left: 30px;
		align:  center;
	}
	

	
	#priceRadio {
	
		margin: 3px auto;
	
	}
	
	#content {
	
		align: center;
		
	
	}
	



</style>


<script type="text/javascript">



 function fncdeletepay(paymentId){
	 

	 alert("취소합니다.");
	 alert(paymentId);
	 
	 //아임포트 ajax 환불하는 곳
	 
	 self.location="/VIG/payment/cancelPayment?paymentId="+paymentId;
	 
 }
 



</script>


</head>
<body>
	
	
<div id=main>
	
	<h2> 받은 후원 목록 </h2>
	<hr>
	
	<div class="container">
		
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">No.</th>
		      <th scope="col">후원자</th>
		      <th scope="col">후원금액</th>
		      <th scope="col">후원피드</th>
		      <th scope="col">후원일</th>
		      <th scope="col">출금유무</th>
		    </tr>
		  </thead>
		  <tbody>
			<c:if test="${list != null }">
				<c:forEach var="payment" items="${list}">
				<c:set var="i" value="0"/>
				<c:set var="i" value="${i+1}"/>
				
				
					<tr>
						<th scope="row"><div style="width: 120px">${i}</div></th>
						<td>
							${payment.buyer.userCode}
						</td>
						<td>
							${payment.selectPrice}
						</td>
						<td>
							${payment.feedId}
						</td>
						<td>
							${payment.paymentDate }
						</td>
						<td>
							<c:if test="${payment.isWithdraw == '0' }">
								출금가능
							</c:if>
							<c:if test="${payment.isWithdraw == '1' }">
								출금 완료
							</c:if>
						</td>
				
					</tr>
				
				
				</c:forEach>
			</c:if>
		
		</tbody>
		</table>
		<hr>
		<div style="text-align:right; font-size: 23px "><p style="display:inline-block; font-weight: bold; font-size:25px; color: #1B7619;">출금가능금액</p> TOTAL : <fmt:formatNumber value="${possibleAmount}" pattern="0,000"/> 원</div>
		<input type="hidden" value="${possibleAmount}" name="possibleAmount">
	
			<div style="text-align: center"><a href="" class="btn btn-default btn-rounded mb-4" data-toggle="modal" data-target="#modalRegisterForm">출금신청</a>
			<a href='' onclick="history.go(-1);" class="btn btn btn-mdb-color btn-rounded mb-4">취소</a></div>
			
				<div class="modal fade" id="modalRegisterForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
						  aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header text-center">
						        <h4 class="modal-title w-100 font-weight-bold">출금신청</h4>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body mx-3">
						      	 <fmt:formatNumber value="${possibleAmount}" pattern="0,000"/>원 출금신청
						        <div class="md-form mb-5">
						          <input type="text" id="orangeForm-name" name="holder" class="form-control validate">
						          <label data-error="wrong" data-success="right" for="orangeForm-name">예금주 명</label>
						        </div>
						        <div class="md-form mb-5">
						          <input type="email" id="orangeForm-email" name="accNo" class="form-control validate">
						          <label data-error="wrong" data-success="right" for="orangeForm-email">계좌번호</label>
						        </div>
						
						        <div class="md-form mb-4">
						          <i class="fas fa-lock prefix grey-text"></i>
						          <input type="password" id="orangeForm-pass" class="form-control validate">
						          <label data-error="wrong" data-success="right" for="orangeForm-pass">주민등록번호(앞 7자리)</label>
						        </div>
								<select class="browser-default custom-select" name="bankCode">
				                        <option value="">은행명을 선택하세요</option>
				                        <option value="35">경남은행</option>
				                        <option value="29">광주은행</option>
				                        <option value="7">국민은행</option>
				                        <option value="5">기업은행</option>
				                        <option value="15">농협중앙회</option>
				                        <option value="17">농협회원조합</option>
				                        <option value="25">대구은행</option>
				                        <option value="47">도이치은행</option>
				                        <option value="27">부산은행</option>
				                        <option value="3">산업은행</option>
				                        <option value="41">상호저축은행</option>
				                        <option value="37">새마을금고</option>
				                        <option value="11">수협중앙회</option>
				                        <option value="36">신한금융투자</option>
				                        <option value="60">신한은행</option>
				                        <option value="39">신협중앙회</option>
				                        <option value="9">외환은행</option>
				                        <option value="19">우리은행</option>
				                        <option value="56">우체국</option>
				                        <option value="33">전북은행</option>
				                        <option value="31">제주은행</option>
				                        <option value="68">카카오뱅크</option>
				                        <option value="67">케이뱅크</option>
				                        <option value="59">하나은행</option>
				                        <option value="23">한국씨티은행</option>
				                        <option value="45">HSBC은행</option>
				                        <option value="21">SC제일은행</option>
							</select>
							<button type="button" class="btn btn-info">계좌조회</button>
						      </div>
						      <div class="modal-footer d-flex justify-content-center">
						        <button class="btn btn-deep-orange">출금신청</button>
						      </div>
						    </div>
						  </div>
						</div>


	</div>
	
	
		
	
</div>
		
		
</body>
</html>