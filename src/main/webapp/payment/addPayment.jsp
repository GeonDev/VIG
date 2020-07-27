<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%-- <%@ page import="com.VIG.mvc.service.domain.*" %>

<%
	
	Payment payment = new Payment();
	payment.setProductType(1);
	request.setAttribute("payment", payment);

%> --%>

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
		margin: 70px auto;
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

$(function (){
	
	var afterPrime = ${user.primeCount};
	var beforePrime = parseInt(afterPrime) - 1000;
	alter(beforePrime);
	$("#beforePrime").text(beforePrime);
	
	
	
	$("button:contains('확인')").on("click", function(){
		

		self.location="/VIG";
		
	
	});
	
	
	
});


</script>


</head>
<body>
	

	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	
	
<div id=main>
	
	
	<h2 align="center" style="font-weight: bold;" > 
		
		<c:if test="${payment.productType == '0' }">
			프라임피드 추가 결제
		</c:if>
		
		<c:if test="${payment.productType == '1' }">
			비즈니스 전환 결제
		</c:if>
		
		<c:if test="${payment.productType == '2' }">
			후원결제
		</c:if>
	
	 </h2>
	<hr>
	<br>
	<br>
	<br>
	<div>
	
		<h4 align="center" style="font-weight: bold;">결제가 완료되었습니다.</h4>
		
	</div>
	<br>
	<br>
	<br>
	<c:if test="${payment.productType == '0' }">
			
			<div id="content">
			<div align="center">
			기존 프라임 피드 카운트 : <p id="beforePrime"></p>
			<br>
			현재 프라임 피드 카운트 : <p>${user.primeCount }</p>
			</div>
			</div>
	</c:if>
	<c:if test="${payment.productType == '1' }">
			
			<div id="content">
			<div align="center">
			<h6>비즈니스user만의 혜택</h6>
			<br>
			- 프라임피드 설정
			<br>
			- 프라임피드 노출 횟수 1000건
			<br>
			- 다른 사용자로 부터 후원 받기!
			<br>
			모두 누릴 수 있습니다!
			</div>
			</div>

			
	</c:if>
	<c:if test="${payment.productType == '2' }">
			
			<div id="content">
			<div align="center">
			후원 대상 : ${payment.beneficiary} ( ${payment.feedId} )
			<br>
			후원 금액 : ${payment.selectPrice}
			<br>
			<br>
			<br>
			
			<h5 style="align:center;">소중한 후원
			<br>
			감사합니다.
			</h5>
			</div>
			
			
			</div>
			
			
	</c:if>	
		
			<br>
			<br>
			<br>
	
	
	
	
	
	
	
	
	
		<!-- 하단 버튼 -->
		<hr>
		<div align="center">
		<button type="button" class="btn btn-primary">확인</button>
		</div>
	

	
</div>


</body>
</html>