<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


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
	  #myFeedMain { padding: 70px;} 
	.col-md-12_top {	width: 100%; height: 100%; position: relative; margin:50px; }	
	body {
		
		font-family: "Nanum Gothic", sans-serif;

	
	}
	
	
	

	
	#priceRadio {
	
		margin: 3px auto;
	
	}
	
	#content {
	
		align: center;
		
	
	}
	
	table {
	
	text-align: center;
	
	}
	#myFeedMain { padding: 70px;}

		body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
		h1 { margin-left: 100px;}
		/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}


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
	

<!-- 툴바 -->
		      <div class="container-fluid">  
		      	 <div class="row">
		      		<div class="col-md-12">
		      			<jsp:include page="/main/toolbar.jsp"></jsp:include>
		     		</div>
				</div>
		
		
			<!-- 사이드바  -->		
				<div class="col-md-2 sideBarPlace">		
				 <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
				 </div>
  			<!-- 타이틀 -->
			    <div class="col-md-10" id="mainMyFeedPage" >	
	
	<h1> 전체 결제 목록 </h1>
	<hr>
	
					<div class="row justify-content-end"  style="margin: 45px 10px 27px 10px;">							
					<div class="input-group md-form form-sm form-1 pl-0 col-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text cyan lighten-2" id="basic-text1"><i id="searchIcon" class="fas fa-search text-white" aria-hidden="true"></i></span>
					  </div>
					</div>					
				</div>
	
		<div class="row">
		<table class="table" >

        <thead class="grey lighten-2">
		    <tr>
		      <th scope="col">결제번호</th>
		      <th scope="col">결제자</th>
		      <th scope="col">결제유형</th>
		      <th scope="col">상품유형</th>
		      <th scope="col">후원자</th>
		      <th scope="col">결제금액</th>
		      <th scope="col">결제일</th>
		      <th scope="col">취소</th>
		    </tr>
		  </thead>
		  <tbody>
			<c:if test="${list != null }">
				<c:forEach var="payment" items="${list}">
				<c:set var="i" value="0"/>
				<c:set var="i" value="${i+1}"/>
				
				
					<tr>
					<th scope="row"><div style="width: 120px">${payment.paymentId}</div></th>
					<td>${payment.buyer.userCode }</td>
					<td>
						<c:if test="${payment.paymentOption== '0' }">
						카드결제
						</c:if>
						<c:if test="${payment.paymentOption== '1' }">
						실시간계좌이체
						</c:if>
					</td>
					<td>
						<c:if test="${payment.productType== '0' }">
						프라임피드추가
						</c:if>
						<c:if test="${payment.productType== '1' }">
						비즈니스전환
						</c:if>
						<c:if test="${payment.productType== '2' }">
						후원
						</c:if>
					</td>
					<td>
						<c:if test="${payment.beneficiary !=  null }">
						
						${payment.beneficiary }
						<br>
						( ${payment.feedId } )
						
						
						</c:if>
					</td>
					<td>
						${payment.lastPrice} 원
					</td>
					<td>
						${payment.paymentDate }
					</td>
					<td>
					<c:if test="${payment.isCancel == '0' }">
					<c:if test="${payment.isWithdraw == '0' }">
					<button class="btn blue-gradient" onclick="fncdeletepay('${payment.paymentId}')" >결제취소</button>
					</c:if>
					<c:if test="${payment.isWithdraw == '1' }">
						취소불가
					</c:if>
					</c:if>
					<c:if test="${payment.isCancel == '1' }">
					취소됨
					</c:if>
					</td>
				
					</tr>
				
				
				</c:forEach>
			</c:if>
		
		</tbody>
		</table>
		
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value=""/>	
				</div>
			
				
			<div class="row justify-content-md-center">
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>
			
	</div>
	</div>
	</div>
	</div>
	
	

	
</div>


</body>
</html>