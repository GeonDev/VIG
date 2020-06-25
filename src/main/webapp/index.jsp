<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<<<<<<< Updated upstream
=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!-- SocketJS CDN -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

<!-- 커스텀 스크립트 -->
<script src="./javascript/checkBrower.js"></script>


<script type="text/javascript">

	$(function(){
		checkbrower(); 
	});
	
	
	$("button:contains('로그인')").on("click",function(){
		$("form[name='login']").attr("method", "POST");		
			$("form[name='login']").submit();	
		
	});
	


</script>

</head>
>>>>>>> Stashed changes


<html>
<body>
<<<<<<< Updated upstream
<h2>Hello World!</h2>

<a href="ApiTestPage.jsp">테스트 코드로</a>
=======

<h1>Hello World!</h1>

<form action="VIG/testController/chatting" name="login">

	<div class="row">
		<div class="col-sm-6">
		<h3>아이디 : <input type="text" class="form-control" name="name"> </h3>
	 	
		</div>
		
		<div class="col-sm-6">
		<h3>비밀번호 : <input type="text" class="form-control" name="password"> </h3>
	 
		</div>
		
		<button type="button" >로그인</button>
	</div>

	


</form>



<br/>

<a href="ApiTestPage.jsp">테스트 코드로</a>
<br/><br/>

<a href="ChattingView.jsp">채팅 코드로</a>

<br/>
<br/>
<div id="disqus_thread"></div>

                         
>>>>>>> Stashed changes
</body>
</html>
