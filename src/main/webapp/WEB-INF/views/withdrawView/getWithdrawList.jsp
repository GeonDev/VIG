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
	
	
	

	
	#priceRadio {
	
		margin: 3px auto;
	
	}
	
	#content {
	
		align: center;
		
	
	}
	
	body {padding-top : 100px;}
    h1 { margin-left: 100px;}  
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	.col-md-12 { margin-bottom: 50px;}


</style>


<script type="text/javascript">



 function fncdeletepay(paymentId){
	 

	 alert("취소합니다.");
	 alert(paymentId);
	 
	 //아임포트 ajax 환불하는 곳
	 
	 self.location="/payment/cancelPayment?paymentId="+paymentId;
	 
 }
 
 $(function(){
	
	 
	 $("button:contains('출금신청')").on("click", function(){
		 console.log("aaa");
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
		$("#withdrawForm").attr("method", "post").attr("action", "/withdraw/addWithdraw").submit();
		 }
		 
	 });
	 
	 
	 
 });
 
 
 



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
					<c:if test="${user.role == 'admin' }">
					<h1> 전체 출금 신청 목록 </h1>
					</c:if>
					<c:if test="${user.role == 'business' }">
					<h1> 출금 목록 </h1>
					</c:if>
					<hr>
	
			<div class="container">
				
				<table class="table">
				  <thead>
				    <tr>
				      <th scope="col">No.</th>
				      <th scope="col">출금ID</th>
				      <th scope="col">예금주</th>
				      <th scope="col">출금계좌</th>
				      <th scope="col">은행명</th>
				      <th scope="col">출금금액</th>
				      <th scope="col">출금일시</th>
				    </tr>
				  </thead>
				  <tbody>
					<c:set var="i" value="0"/>
					<c:if test="${list != null }">
						<c:forEach var="withdraw" items="${list}">
						
						<c:set var="i" value="${i+1}"/>
						
						
							<tr>
								<th scope="row">${i}</th>
								<td>
									${withdraw.withdrawId}
								</td>
								<td>
									${withdraw.holder}
								</td>
								<td>
									${withdraw.accNo}
								</td>
								<td>
									<c:if test="${withdraw.bankCode == 35}">
									경남은행
									</c:if>
									<c:if test="${withdraw.bankCode == 29}">
									광주은행
									</c:if>
									<c:if test="${withdraw.bankCode == 7}">
									국민은행
									</c:if>
									<c:if test="${withdraw.bankCode == 5}">
									기업은행
									</c:if>
									<c:if test="${withdraw.bankCode == 15}">
									농협중앙회
									</c:if>
									<c:if test="${withdraw.bankCode == 25}">
									대구은행
									</c:if>
									<c:if test="${withdraw.bankCode == 27}">
									부산은행
									</c:if>
									<c:if test="${withdraw.bankCode == 3}">
									산업은행
									</c:if>
									<c:if test="${withdraw.bankCode == 37}">
									새마을금고
									</c:if>
									<c:if test="${withdraw.bankCode == 11}">
									수협중앙회
									</c:if>
									<c:if test="${withdraw.bankCode == 39}">
									신협중앙회
									</c:if>
									<c:if test="${withdraw.bankCode == 60}">
									신한은행
									</c:if>
									<c:if test="${withdraw.bankCode == 9}">
									외환은행
									</c:if>
									<c:if test="${withdraw.bankCode == 19}">
									우리은행
									</c:if>
									<c:if test="${withdraw.bankCode == 56}">
									우체국
									</c:if>
									<c:if test="${withdraw.bankCode == 33}">
									전북은행
									</c:if>
									<c:if test="${withdraw.bankCode == 31}">
									제주은행
									</c:if>
									<c:if test="${withdraw.bankCode == 68}">
									카카오뱅크
									</c:if>
									<c:if test="${withdraw.bankCode == 67}">
									케이뱅크
									</c:if>
									<c:if test="${withdraw.bankCode == 59}">
									하나은행
									</c:if>
									<c:if test="${withdraw.bankCode == 23}">
									한국시티은행
									</c:if>
									<c:if test="${withdraw.bankCode == 21}">
									SC제일은행
									</c:if>
		
								</td>
								<td>
									${withdraw.amount }
								</td>
								<td>
									${withdraw.withdrawDate }
								</td>
						
							</tr>
						
						
						</c:forEach>
					</c:if>
		
				
				</tbody>
		
				
				</table>
						<c:if test="${empty list}">
						<p style="text-align:center; font-weight: bold; height: 30px">신청내역이 없습니다.</p>
						</c:if>
				<hr>		
					<div class="row justify-content-md-center">
						<jsp:include page="../common/pageNavigator.jsp"/>
					</div>
				
				
			
		
		
			</div>
	
	</div>
		
	
	
		
	
</div>
		
		
</body>
</html>