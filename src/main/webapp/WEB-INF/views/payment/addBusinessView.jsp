<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	body {
		
		font-family: "Nanum Gothic", sans-serif;

	
	}
	
	#main { 
		width: 80%;
		margin: 70px auto;
	}
	

	
	#priceRadio {
	
		margin: 3px auto;
	
	}




</style>


<script type="text/javascript">

$(function(){
	

	

	var IMP = window.IMP; // 생략가능
	IMP.init('imp09736662');
	
		
	
	$("button:contains('결제')").on("click", function(){
		
		
		
		var lastPrice = $("input[name='lastPrice']").val();
		
		var option = $("select option:selected").val();
		if(option == 'card'){
		$("input[name='paymentOption']").val(0);
		} else if(option == 'trans') {
		$("input[name='paymentOption']").val(1);
		}
		
		if($("#defaultUnchecked").is(":checked") == false ){
			
			swal("필수 동의 사항을 선택해주세요.");
			return false;
			
		}
		
		
			IMP.request_pay({
			    pg : 'inicis', // version 1.1.0부터 지원.
			    pay_method : option,
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : '주문명:결제테스트',
			    amount : 300,
			    buyer_email : 'iamport@siot.do',
			    buyer_name : "주문자이름",
			    buyer_tel : '010-1234-5678',
			    buyer_addr : '서울특별시 강남구 삼성동',
			    buyer_postcode : '123-456',
			    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			}, function(rsp) {
			    if ( rsp.success ) {
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			     //   $("input[name='lastPrice']").val(rsp.paid_amount);
			        $("input[name='paymentId']").val(rsp.imp_uid);
			        $("form").attr("action", "/vig/payment/addBusiness").attr("method", "post").submit();
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			    }
			    swal(msg);
			   
			    
			});
		
		
	});
	
	$("button:contains('취소')").on("click", function(){
		
		
		history.go(-1);
		
	
	});
	
	
	
});


</script>


</head>
<body>
	

	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	
	
	<div id="main">
	
			<div class="container">
				 <h3 class="font-weight-bold text-center dark-grey-text pb-2">비즈니스 계정 전환</h3>
			    <hr>
			  <!-- Section -->
			  <div class="row">
				  	<div class ="col-md-6">
				    <section class="text-center dark-grey-text">
	    
					    <div class="row text-center d-flex justify-content-center my-5">
					      <div class="col-lg-6 col-md-6 mb-4">
					        <i class="fas fa-object-ungroup fa-3x mb-4 grey-text"></i>
					        <h5 class="font-weight-normal mb-3">Prime Feed</h5>
					        <p class="text-muted mb-0"> 우선적으로 노출되는 Prime Feed 사용 가능</p>
					      </div>
					      <div class="col-lg-6 col-md-6 mb-4">
					        <i class="fas fa-gifts fa-3x mb-4 grey-text"></i>
					        <h5 class="font-weight-normal mb-3">1,000 Prime Count</h5>
					        <p class="text-muted mb-0"> Prime Feed Count 1,000건 제공</p>
					      </div>
					      <br>
					      <div class="col-lg-6 col-md-6 mb-4">
					        <i class="fas fa-chart-line fa-3x mb-4 grey-text"></i>
					        <h5 class="font-weight-normal mb-3">피드 통계 제공</h5>
					        <p class="text-muted mb-0">내 피드의 월별 통계를 제공합니다.</p>
					      </div>
					      <div class="col-lg-6 col-md-6 mb-4">
					        <i class="fas fa-comments-dollar fa-3x mb-4 grey-text"></i>
					        <h5 class="font-weight-normal mb-3">후원받기</h5>
					        <p class="text-muted mb-0"> 피드를 통해 후원을 받고 수익을 창출할 수 있습니다.</p>
					      </div>
					    </div>
					    
					  </section>
				  <!-- Section -->
				
					</div>
			
				
	
	<hr>
	<br>
					<div class ="col-md-6">
					<form class="donationform">
		
					<div class="row">
					<div class="col-3 md-3 mb-3">
					<div align="left"> <span style="font-size:120%; font-weight: bold;" > 상품명 :  </span> &nbsp;&nbsp;</div>
					<br>
					<div align="left"> <span style="font-size:120%; font-weight: bold;" > 금액 :  </span> &nbsp;&nbsp;</div>
					<br>
				
				
					<div align="left"> <span style="font-size:120%; font-weight: bold;" > 결제 수단 :   </span> &nbsp;&nbsp;</div>
					</div>
					<div class="col-9 md-9 mb-9">
		
					<span style="font-size:18px;">비즈니스 계정 전환</span>
					<br><br>
							30,000 원
						<br>
						<br>
				
							<select class="browser-default custom-select"  name="paymentType" style="width: 200px">  
							  <option value="card">카드결제</option>
							  <option value="trans">실시간 계좌이체</option>
							  <option value="phone">휴대폰 소액결제</option>
							</select>
							
							<hr/>
						
						<div id="selectPrice" > <span style="font-weight: bold">선택 금액 :</span><span id="select">30,000</span><p style="display:inline-block ; width: 200px">원</p></div>
						<div id="commissionPrice"><span style="font-weight: bold">수수료(VAT 10%) : </span><span id="commission">3,000</span><p style="display:inline-block ; width: 200px">원</p></div>
						<div id="lastPrice"><span style="font-weight: bold">총 결제 금액 : </span><span id="last">33,000</span><p style="display:inline-block ; width: 200px">원</p></div>
						</div>
						<input type="hidden" name="selectPrice" value="30000">
						<input type="hidden" name="lastPrice" value="33000">
						<input type="hidden" name="paymentId">
						<input type="hidden" name="paymentType">
						<input type="hidden" name="productType" value="1">
						
						
				
					</div>
					<hr>
					<p style="font-size: 14px; text-align:left;">
					결제를 위해 귀하의 개인정보를 제3자((주)아임포트)에 제공하는데 동의하십니까?<br>
					결제하시고자 하는 상품은 디지털 상품으로 결제와 동시에 사용되어 환불이 불가합니다.<br> 
					위 사항에 동의하십니까?
					(동의하지 않으면 결제가 진행되지 않을 수 있습니다.)
					</p>
					
					<div class="custom-control custom-checkbox" style="text-align:center">
					    <input type="checkbox" class="custom-control-input" id="defaultUnchecked">
					    <label class="custom-control-label" for="defaultUnchecked">예, 동의합니다.(필수)</label>
					</div>
					
					
					<hr/>
					
					<div align="center">
					<button type="button" class="btn btn-info">결제</button>
					<button type="button" class="btn btn-light">취소</button>
					</div>
					
					</form>
					</div>
	
	 </div>
	</div>
	</div>
	

</body>
</html>