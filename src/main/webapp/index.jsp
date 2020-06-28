<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>

<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/VIG/css/animate.min.css" rel="stylesheet">
   <link href="/VIG/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/VIG/javascript/bootstrap-dropdownhover.min.js"></script>

	<!-- SocketJS CDN -->
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

	<!-- 커스텀 스크립트 -->
	<script src="/VIG/javascript/checkBrower.js"></script>

<script type="text/javascript">	
	
	$(function(){
		$("button:contains('로그인')").on("click", function() {			
			$("form[name='Login']").attr("method", "POST");		
			$("form[name='Login']").submit();	
		});	
	});

</script>


</head>

<h1>Hello World!</h1>


	<div class="container">
		<form action="./testController/chatting" name="Login">
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
		</div>
		
		<br/>
		
		<div class="row">
			<a href="ApiTestPage.jsp">테스트 코드로</a>
		</div>	
		
	</div>	
</body>
</html>
