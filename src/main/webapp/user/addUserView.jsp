<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>
		
		<script type="text/javascript">
		
		function fncAddUser() {			
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}
	
		//============= "가입"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.bt:contains()'버튼')" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		</script>
</head>
<body>

회원가입 페이지

	<div class="container">
		<div class="row">
			user name &nbsp;&nbsp;
				<input type="text" name="userName"><br/>
		</div>
		<div class="row">
			password &nbsp;
				<input type="password" name="password"><br/>
		</div>
		<div class="row">
			profile img &nbsp;&nbsp;&nbsp;
				<input type="text" name="profileImg"><br/>
		</div>
		<div class="row">
			self introduce 
				<input type="text name="selfIntroduce"/><br/>
		</div>
		<div class="row">
			profile img
				<input type="radio" name="profileImg" >female<br/>
		</div>
			
	</div>
		<div class="container">
			<div class="row">
				<button type="button" id="bt" >버튼</button>		
			</div>
		</div>

</body>
</html>