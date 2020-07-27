<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>

	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">		
		
	<!-- JQuery -->	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	

	<!-- SocketJS CDN -->
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

	<!-- 커스텀 스크립트 -->
	<script src="/VIG/javascript/checkBrower.js"></script>

<script type="text/javascript">	
	
	$(function(){
		
		checkBrower();			
		
		
		$("button:contains('구글')").on("click", function() {			
			location.href="https://accounts.google.com/o/oauth2/auth?client_id="+
			"82747934090-ljsrvma8goa9dskv7hchor1mt2atl1ao.apps.googleusercontent.com"+
			"&redirect_uri="+
			"http://localhost:8080/VIG/redirect.jsp" +
			"&response_type=code&scope=https://www.googleapis.com/auth/userinfo.email&approval_prompt=force&access_type=offline";
			
		});
		
		
		$("button:contains('로그인')").on("click", function() {			
			$("form[name='Login']").attr("method", "POST");		
			$("form[name='Login']").submit();	
		});			
		
	});

</script>
</head>

<body>
<h1>Hello World!</h1>

	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="./main/toolbar.jsp" />

	<br/>
	<br/>
	<div class="container">
		<form action="testController/chatting" name="Login">
			<div class="row">		
				<label for="userId" class="col-md-4 control-label">아 이 디 :</label>	
					
				<div class="col-md-3">
					 <input type="text" class="form-control" name="name">	 	
				</div>
			</div>
			
			<br/>
			
			<div class="row">	
				<label for="userPw" class="col-md-4 control-label">비밀번호 :</label>
				
				<div class="col-md-3">
					<input type="text" class="form-control" name="password">	 
				</div>
			</div>					
		</form>
		
		<br/>
		<div class="row">
			<button type="button">로그인</button>	
			<button type="button">구글</button>			
		</div>
		
		<br/>
		
		<div class="row">
			<a href="ApiTestPage.jsp">테스트 코드로</a>
		</div>	
		
		<div class="row">
			<a href="testController/setImage">이미지 키워드 추출</a>
		</div>
		
		<div class="row">
			<a href="report/getReportList">신고 조회</a>
		</div>
		
		<div class="row">
			<a href="search/getSearchList">검색 페이지</a>
		</div>	
		
		<div class="row">
			<a href="history/getMyHistoryList">히스토리</a>
		</div>	
		
		
	</div>	
</body>
</html>
