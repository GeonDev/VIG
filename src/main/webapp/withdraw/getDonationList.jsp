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
		
		maring-top: 70px;
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
 
 $(function(){
	
	 $("a:contains('출금신청')").on("click", function(){
		 var amount = $("input[name='amount']").val();
		 if(amount< 10000){
			 alert("1만원 이상부터 출금신청 할 수 있습니다.");
			 return false;
		 }
		 
	 });
	 
	 $("button:contains('출금신청')").on("click", function(){
		
		
		 var holder = $("input[name='holder']").val();
		 var accNo = $("input[name='accNo']").val();
		 var RRN = $("input[name='RRN']").val();
		 var paymentId = $("input[name='paymentId']");
		 var bankCode =  $("select[name='bankCode']").val();
		 
		 if(holder == null || holder == ''){
			 
			 alert("예금주 명을 입력해주세요");
		 }
		 if(accNo == null || accNo == '') {
			 
			 alert("계좌번호를 입력해주세요");
		 }
		 if(RRN == null || RRN ==''){
			 alert("주민등록번호를 입력해주세요");
		 }
		 if(bankCode == "") {
			 alert("은행을 선택해주세요");
		 }
		 if(holder != "" && accNo != "" && RRN != ""&& bankCode!=""){
			 alert("");
		$("form").attr("method", "post").attr("action", "/VIG/withdraw/addWithdraw").submit();
		 }
		 
	 });
	 
	 
	 
 });
 
 
 



</script>


</head>
<body>
		<!-- toolbar -->
     <div class="container-fluid">  
      	 <div class="row">
      		<div class="col-md-12">
      			<jsp:include page="/main/toolbar.jsp" />
     		</div>
		</div>
		
		<div class="col-md-12">
			<div class="row">
				<!-- 사이드바 자리 -->		
				<div class="col-md-2">		
			    	<jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
			    </div>  
	   <div class="col-md-10" >		
			<div id=main>
				
				<h2> 받은 후원 목록 </h2> <a href="/withdraw/getWithdrawList">출금목록보기</a>
				<hr>
				
				<div class="container">
					 <form name="withdrawForm">
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
					  
						<c:set var="i" value="0"/>
						<c:if test="${list != null }">
							<c:forEach var="payment" items="${list}">
							
							<c:set var="i" value="${i+1}"/>
							
							
								<tr>
									<th scope="row">${i}</th>
									<td>
										${payment.buyer.userCode}
										
										<input type="hidden" name="paymentId" value="${payment.paymentId }"> <!-- sever side에서 상태 변경용 paymentId를 심는다 -->
										
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
							<c:if test="${empty list}">
							<p style="text-align:center; font-weight: bold; height: 30px">받은 후원이 없습니다.</p>
							</c:if>
					<hr>		
						<div class="row justify-content-md-center">
							<jsp:include page="../common/pageNavigator.jsp"/>
						</div>
					
					<!--  출금 가능 금액 표시 / 0이면 pattern X 0이아니면 pattern이 적용됨 -->
					<div style="text-align:right; font-size: 23px "><p style="display:inline-block; font-weight: bold; font-size:25px; color: #1B7619;">
																		출금가능금액</p> TOTAL : 
																		<c:if test="${possibleAmount != 0 }">
																		<fmt:formatNumber value="${possibleAmount}" pattern="0,000"/>
																		</c:if> 
																		<c:if test="${empty possibleAmount || possibleAmount == 0 }">
																		<fmt:formatNumber value="${possibleAmount}"/>
																		</c:if>
																		
																		원</div>
				
						<div style="text-align: center"><a href="" class="btn btn-default btn-rounded mb-4" data-toggle="modal" data-target="#modalRegisterForm">출금신청</a>
						<a href='' onClick="history.go(-1); return false;" class="btn btn btn-mdb-color btn-rounded mb-4">취소</a></div>
						
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
									      	 <p style="text-align: center;"><fmt:formatNumber value="${possibleAmount}" pattern="0,000"/>원 출금신청</p>
									      	 <input type="hidden" name="amount" value="${possibleAmount }">
									        <div class="md-form mb-5">
									          <input type="text" id="orangeForm-name" name="holder" class="form-control validate">
									          <label data-error="wrong" data-success="right" for="orangeForm">예금주 명</label>
									        </div>
									        <div class="md-form mb-5">
									          <input type="number" id="orangeForm-number" name="accNo" class="form-control">
									          <label data-error="wrong" data-success="right" for="orangeForm">계좌번호</label>
									        </div>
									
									        <div class="md-form mb-4">
									          <i class="fas fa-lock prefix grey-text"></i>
									          <input type="password" id="orangeForm-pass" class="form-control" name="RRN">
									          <label data-error="wrong" data-success="right" for="orangeForm">주민등록번호(앞 7자리)</label>
									        </div>
											<select class="browser-default custom-select" name="bankCode">
							                        <option value="">은행명을 선택하세요</option>
							                        <option value="35">경남은행</option>
							                        <option value="29">광주은행</option>
							                        <option value="7">국민은행</option>
							                        <option value="5">기업은행</option>
							                        <option value="15">농협중앙회</option>
							                        <option value="25">대구은행</option>
							                        <option value="27">부산은행</option>
							                        <option value="3">산업은행</option>				                       
							                        <option value="37">새마을금고</option>
							                        <option value="11">수협중앙회</option>
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
							                        <option value="21">SC제일은행</option>
										</select>
										<!-- <button type="button" class="btn btn-info">계좌조회</button> -->
									      </div>
									      
									      <div class="modal-footer d-flex justify-content-center">
									        <button class="btn btn-deep-orange">출금신청</button>
									      </div>
									    </div>
									  </div>
									</div>
					</form>
			
				</div>
				
				
					
				
				
					
				
			</div>
			</div>
			</div>
		</div>
	</div>
		
</body>
</html>