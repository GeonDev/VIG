<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>addDonationView</title>

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
	}
	

	
	#priceRadio {
	
		margin: 3px auto;
	
	}
	



</style>


<script type="text/javascript">

$(function(){
	
	
	//아래부터는 input text에 금액 입력하는 곳
	function addCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	 
	//모든 콤마 제거
	function removeCommas(x) {
	    if(!x || x.length == 0) return "";
	    else return x.split(",").join("");
	}

	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val(addCommas($(this).val().replace(/[^0-9]/g,"")));
	});

	
	$("input:text[numberOnly]").on("focus", function() {
	    var x = $(this).val();
	    x = removeCommas(x);
	    $(this).val(x);
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        x = addCommas(x);
	        $(this).val(x);
	    }
	}).on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});


});

$(function(){
	
	
	$("#after").on("click", function(){
		
		
		var num = $("#after");
		
		if(num.is(':checked')==true){
			
			$("input:text[numberOnly]").removeAttr('disabled');
			
		} else {
			
			$("input:text[numberOnly]").attr("disabled").val("");
			$("#before").val("");
			
		}

		
	});
	
		

	

	var IMP = window.IMP; // 생략가능
	IMP.init('imp09736662');
	
	
	$('input:radio').on("change", function(){
		
		var selectPrice;
		if($('input[name="price"]:checked').val() != '0'){
			
		selectPrice = $('input[name="price"]:checked').val();
		var commission = selectPrice*0.1;
		var lastPrice = parseInt(selectPrice)+parseInt(commission);
		$("#select").text(selectPrice);
		$("input[name='selectPrice']").val(selectPrice);
		$("#commission").text(commission);
		$("#last").text(lastPrice);
		
		
		} 
		else {
			
		$("#before").on("keyup", function(){
			
			var change = parseInt($("#before").val());
			$("#after").val(change);
			selectPrice = $("#after").val();
			var commission = selectPrice*0.1;
			var lastPrice = parseInt(selectPrice)+parseInt(commission);
			$("#select").text(selectPrice);
			$("#commission").text(commission);
			$("#last").text(lastPrice);
		
		});

		}
		
	});
	
	

	
	$("button:contains('결제')").on("click", function(){
		
		
		
		var lastPrice = parseInt($("#last").text());
		
		var option = $("select option:selected").val();
		if(option == 'card'){
		$("input[name='paymentOption']").val(0);
		} else if(option == 'trans') {
		$("input[name='paymentOption']").val(1);
		}
		
		
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : option,
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : lastPrice,
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
		        $("input[name='lastPrice']").val(rsp.paid_amount);
		        $("input[name='paymentId']").val(rsp.merchant_uid);
		        $("form").attr("action", "/VIG/payment/addDonation").attr("method", "post").submit();
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		   
		    
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

	
	
	<div id=main>
	
	
	<h2 align="center" style="font-weight: bold;" > 후원결제 </h2>
	<hr>
	<br>
	<form class="donationform">
	<div class="container">
	<div class="row">
	<div class="col-6">
	<div align="right"> <span style="font-size:20px; font-weight: bold;" > 후원 유저 코드 (피드ID) :  </span> &nbsp;&nbsp;</div>
	<br>
	<div align="right"> <span style="font-size:20px; font-weight: bold;" > 금액 :  </span> &nbsp;&nbsp;</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div align="right"> <span style="font-size:20px; font-weight: bold;" > 결제 수단 :   </span> &nbsp;&nbsp;</div>
	</div>
	
	
	
	<div class="col-6">
	
	
	<input type="hidden" name="beneficiary" value="${feed.writer.userCode}">
	<input type="hidden" name="feedId" value="${feed.feedId}">
	<span style="font-size:18px;">${feed.writer.userCode} (${feed.feedId})</span>
		${session.user.userCode}
	<br><br>
		<div class="form-check" align="left" style=" font-weight: bold; padding-top: 10px">
		<div id="priceRadio">
		  <input type="radio" class="form-check-input" id="materialChecked2" name="price" value="1000" checked> 1,000원
		  </div>
		  
		  <div id="priceRadio">
		   <input type="radio" class="form-check-input" id="materialChecked2" name="price" value="3000" > 3,000원
		  </div>
		    
		    <div id="priceRadio">
		   <input type="radio" class="form-check-input" id="materialChecked2" name="price" value="5000" > 5,000원
		  </div>
		    
		    <div id="priceRadio">
		   <input type="radio" class="form-check-input" id="materialChecked2" name="price" value="10000" > 10,000원
		  </div>
		    
		    <div id="priceRadio">
		   <input type="radio" class="form-check-input" id="after" name="price" value="0" >기타 :
		   <input type="text" id="before" name="price" numberOnly disabled="disabled" placeholder="금액을 입력하세요"> 원
		  </div>
		</div>
		<br>
			<select class="browser-default custom-select"  name="paymentType" style="width: 200px">  
			  <option value="card">카드결제</option>
			  <option value="trans">실시간 계좌이체</option>
			  <option value="phone">휴대폰 소액결제</option>
			</select>
			
			<hr/>
		
		<div id="selectPrice" > <span style="font-weight: bold">선택 금액 : </span><span id="select"></span><p style="display:inline-block ; width: 200px">원</p></div>
		<div id="commissionPrice"><span style="font-weight: bold">수수료(VAT 10%) : </span><span id="commission"></span><p style="display:inline-block ; width: 200px">원</p></div>
		<div id="lastPrice"><span style="font-weight: bold">총 결제 금액 : </span><span id="last"></span><p style="display:inline-block ; width: 200px">원</p></div>
		</div>
		<input type="hidden" name="selectPrice">
		<input type="hidden" name="lastPrice">
		<input type="hidden" name="paymentId">
		<input type="hidden" name="paymentType">
		<input type="hidden" name="productType" value="2">
	
	
	</div>
	
	<hr/>
	
	<div align="center">
	<button type="button" class="btn btn-info">결제</button>
	<button type="button" class="btn btn-light">취소</button>
	</div>
	</div>
	</form>
	</div>
	

</body>
</html>