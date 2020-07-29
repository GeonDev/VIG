<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>아이디 중복 확인</title>

	<!-- Font Awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<!-- Bootstrap core CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
				
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
	
	/*
		$(function() {
			
			$("#userId").focus();
		
			//==> keydown Event 연결
			//==> CallBackFunction  :  EventObject 인자로 받을수 있다.
			//==> 본실습 에서는
			//==> - Event Object 를 인자로 받을 수 있는 것 확인.
			//==> - keyCode 값 alert() 확인하는 것 으로 종료
			$("#userId").on("keydown" , function(event) {
				
				alert("keyCode  : "+event.keyCode);
				
				if(event.keyCode == '13'){
					//fncCheckDuplication();
				}
			});
			
		});
		*/
		
		//==> "중복확인"  Event 처리
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.				
			$("#iDcheck_btn").on("click" , function() {
				
				//==>Debug
				//alert($("td.ct_btn:contains('중복확인')").html())
				
				// Form 유효성 검증
				if( $("#userCode").val() != null && $("#userCode").val().length >0) {
					$("form").attr("method" , "POST");
				    $("form").attr("action" , "/VIG/user/checkDuplication");
				    $("form").submit();
				}else {
					alert('아이디는 반드시 입력하셔야 합니다.');
				}
				$("#userCode").focus();
			});
		});
		
		
		//==>"사용"  Event 처리
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$("#iDcheck_ok").on("click" , function() {
				
				//==>Debug
				//alert($("td.ct_btn01:contains('사용')").html())
				
				if(opener) {
					opener.$("input[name='userCode']").val("${userCode}");
					opener.$("input[name='userName']").focus();
				}
				
				window.close();
			});
		});
		
		
		//==> "닫기"  Event  처리
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$("#iDcheck_no").on("click" , function() {
				//==>Debug
				//alert($("td.ct_btn01:contains('닫기')").html())
				window.close();
			});
		});

	</script>		
	
</head>

<body>

<form>

<!-- 타이틀 시작 -->
	<span>아이디 체크</span>
<!-- 타이틀 끝 -->

<!-- 검색결과 시작 -->
					<span>
						<c:if test="${ ! empty result }">
							${userId} 는 사용
							${ result ? "" : "불" }가능 합니다.
						</c:if>
					</span>
<!-- 검색결과 끝 -->

<!-- 등록 테이블시작 -->

		<span>아이디</span>
		
						<input type="text" name="userCode" id="userCode" value="${ ! empty result && result ? userCode : '' }" 
						class="ct_input_g" style="width:100px; height:19px"  maxLength="20" >		
						<hr/>
						<button type="button" class="btn btn-primary btn-sm" id="iDcheck_btn">중복확인</button>								
					

<!-- 버튼 시작 -->

					<c:if test="${ ! empty result && result }">
						<td width="17" height="23">
							<button type="button" class="btn btn-primary btn-sm" id="iDcheck_ok">사용</button>
					</c:if>
							<button type="button" class="btn btn-primary btn-sm" id="iDcheck_no">닫기</button>

</form>

</body>

</html>