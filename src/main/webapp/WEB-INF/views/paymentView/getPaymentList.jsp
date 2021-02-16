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
	<!-- 알러트 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
<style>
	
	body {padding-top : 100px;}
    h1 { margin-left: 100px;}  
    
    /*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	.col-md-12{ margin-bottom: 50px;} 
      
	#priceRadio {
	
		margin: 3px auto;
	
	}
	
	#content {
	
		align: center;
		
	
	}
	
	


/* 버튼 CSS */
		.box_body_m {box-sizing: border-box; font-family: "Futura PT", "Futura", sans-serif; -webkit-font-smoothing: antialiased;}
		.wrap_m {text-align: center;}
		#btn_ch_m { padding: 12px 50px;text-decoration: none;font-size: 12px; ;margin: 3px 20px; display:flex; float:left;}
		.btn:hover, .btn:link:hover, .btn:visited:hover {box-shadow: 0 4em 0 0 #2c3e50 inset, 0em 0em 0 0 #bbb;-webkit-transform: translate(0.3em, 0.2em);transform: translate(0.3em, 0.2em); color: #fff;}
		.btn3, .btn3:link, .btn3:visited {color: #333;font-size: .8em;text-transform: uppercase;min-width: 100px;position: relative;
		  	margin: 0 auto;border: 2px solid transparent;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:after, .btn3:before, .btn3:link:after, .btn3:link:before, .btn3:visited:after, .btn3:visited:before { content: "";position: absolute;letter-spacing: .1em;left: -1em;top: -2px; height: 3em; width: 0;
			border: 1px solid #c75842;-webkit-transition: inherit;transition: inherit;}
		.btn3:after, .btn3:link:after, .btn3:visited:after {left: auto;right: -1em;}
		.btn3:hover, .btn3:link:hover, .btn3:visited:hover {border-color: #c75842;-webkit-transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:hover:after, .btn3:hover:before, .btn3:link:hover:after, .btn3:link:hover:before, .btn3:visited:hover:after, .btn3:visited:hover:before {
		  right: -2px;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:hover:before, .btn3:link:hover:before, .btn3:visited:hover:before {left: -2px;right: auto;}
		@-webkit-keyframes gelatine {
		  from,to {-webkit-transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);}
		  from,to {-webkit-transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);}}
		@keyframes gelatine {from,to {-webkit-transform: scale(1, 1); transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1); transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);t}
			/* 버튼 CSS */


</style>


<script type="text/javascript">



 function fncdeletepay(paymentId){
	 

		swal({
			  text: "결제를 취소하시겠습니까?",
			  icon: "info",
			  buttons: true,
			})
			.then((willDelete) => {
			  if (willDelete) {

				 swal({text: "완료되었습니다.",
					  icon: "info",}) 
				  self.location="/vig/payment/cancelPayment?paymentId="+paymentId;
				  
			  } else {
			    
			  }
			});
	 
	 //아임포트 ajax 환불하는 곳
	 
	 
	 
 }
 
function funcGetList(currentPage) {
	$("#currentPage").val(currentPage);
	$("form").attr("action", "./getPaymentList");
	$("form").submit();
}



</script>


</head>
<body>
	

	<!-- 툴바 -->
		      <div class="container-fluid">  
		      	 <div class="row">
		      		<div class="col-md-12">
		      			<jsp:include page="../mainView/toolbar.jsp"></jsp:include>
		     		</div>
				</div>
		
		
			<!-- 사이드바  -->		
				<div class="col-md-2 sideBarPlace">		
				 <jsp:include page="../myFeedView/sideBar.jsp"></jsp:include>
				 </div>
  			<!-- 타이틀 -->
			    <div class="col-md-10" id="mainMyFeedPage" >
	
				<h1> 내 결제 목록 </h1>
				<hr>
				

	
	
			<div class="container">
					
					<table class="table">
					  <thead>
						    <tr>
						      <th scope="col">결제번호</th>
						      <th scope="col">결제자</th>
						      <th scope="col">결제유형</th>
						      <th scope="col">상품유형</th>
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
										${payment.lastPrice}
									</td>
									<td>
										${payment.paymentDate }
									</td>
									<td>
									<c:if test="${payment.isCancel == '0' }">
									<c:if test="${payment.isWithdraw == '0' }">
									<c:if test="${payment.productType!='1' }">
									<c:if test="${payment.productType!='0' }">
									<button class="btn blue-gradient" onclick="fncdeletepay('${payment.paymentId}')" >결제취소</button>
									</c:if>
									</c:if>
									</c:if>
									<c:if test="${payment.isWithdraw == '1' || payment.productType == '1' || payment.productType=='0' }">
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
						<c:if test="${empty list}">
						<p style="text-align:center; font-weight: bold; height: 30px">결제내역이 없습니다.</p>
						</c:if>
						<hr>		
								<form method="POST">
								
										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
											<input type="hidden" id="currentPage" name="currentPage" value=""/>	
								</form>	
						
						</div>
					
					
				<div class="row justify-content-md-center">
					<jsp:include page="../common/pageNavigator.jsp"/>
				</div>
			</div>
</div>

</body>
</html>