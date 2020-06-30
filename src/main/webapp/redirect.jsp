<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	<script>
	// 주소 창에 있는 parameter를 취득한다.
		function getParameter(name){
			var list = location.search.substring(1).split('&');
			
			for(var i=0;i<list.length;i++){
				var data = list[i].split('=');
				if(data.length === 2){
					if(data[0] === name){
						return data[1];
					}
				}
			}
		
		return null;
		}
		
		$(function() {
			$("input[name=code]").val(decodeURIComponent(getParameter('code')));
			
		});
		
		
	</script>


</head>

	<body>
		<form method="POST" action="https://accounts.google.com/o/oauth2/token">
	
		<input type="text" name="code"> <br />
	
		<input type="text" name="client_id" value="클라이언트 ID"> <br />
	
		<input type="text" name="client_secret" value="클라이언트 보안 key"> <br />
	
		<input type="text" name="redirect_uri" value="http://localhost:8080/VIG/redirect.jsp"> <br />
		
		<!-- 고정값 -->
		<input type="text" name="grant_type" value="authorization_code"> <br />
		<input type="submit">
		</form>	
		
		
		<br/>
		<br/>
		
		<form method="GET" action="https://www.googleapis.com/oauth2/v1/userinfo">
			<input type="text" name="access_token">
			<input type="submit">
		</form>


	</body>
</html>

