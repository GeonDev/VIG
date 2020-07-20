<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		$( function(){
			$("#userName").focus();
			
			$("#login_btn").on("click" ,function(){
				
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력해주세요.');
					$("input:text").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('비밀번호를 입력해주세요.');
					$("input:password").focus();
					return;
				}
			});
		});
	
	</script>

</head>
<body>

	id<input type="text" class="input_userName" id="userName" name="userName" ><br/>
	pw <input type="password" class="input_password" id="password" name="password"><br/>	
	 <button type="button" id="login_btn" name="login_btn" >login</button>

</body>
</html>