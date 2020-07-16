<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>
		
		<script type="text/javascript">
		
		function fncAddUser() {
			var id=$("input[name='email']").val();
			if(id == null || id.length <1){
				alert("이메일 입력해주세요.");
				return;
			}
			$("form").attr("method","POST").attr("action", "/user/addUser").submit();
		}
	
		//============= "가입"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button" ).on("click" , function() {
				fncAddUser();
			});
		});	
		
		</script>
</head>
<body>

회원가입 페이지

	<div class="container">
		<div class="row">
			email &nbsp;&nbsp;
				<input type="email" name="email"><br/>
		</div>
		<div class="row">
			password &nbsp;
				<input type="password" name="password"><br/>
		</div>
		<div class="row">
			bio &nbsp;&nbsp;&nbsp;
				<input type="text" name="email"><br/>
		</div>
		<div class="row">
			sex &nbsp;&nbsp;&nbsp;
				<input type="radio" name="sex" value="male"> male &nbsp;
				<input type="radio" name="sex" value="female">female<br/>
		</div>
		
	</div>
		<div class="container">
			<div class="row">
				<button type="button">버튼</button>		
			</div>
		</div>

</body>
</html>