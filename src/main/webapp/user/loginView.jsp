<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>
<meta name="viewport" content="width=device-width, initial-scale=1">


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

	
//=====회원가입으로 이동
	$( function() {
		$("#ty").on("click" , function() {
			//location.href="addUserView";
			self.location="/VIG/user/addUserView.jsp"
		});
	});
//=======로그인 이벤트
	$( function() {		
		$("#userCode").focus();	
		$("#login").on("click" , function() {
			var id=$("input:text").val();
			var pw=$("input:password").val();
			
			if(id == null || id.length <1) {
				alert('ID 를 입력하지 않으셨습니다.');
				$("#userCode").focus();
				return;
			}
			if(pw == null || pw.length <1) {
				alert('패스워드를 입력하지 않으셨습니다.');
				$("#password").focus();
				return;
			}
		////ajax 연결 안됨/ 로그인은 되는데 비번이나 아이디 다르면 모달이 다시 리로드 되어서 풀화면으로 나옴 
			$.ajax({
				url : "/json/login",
				method : "POST" ,
				data : JSON.stringify({
					userCode : id,
					password : pw
				}),
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(data , status) {
					alert("ok");
				},error:function(request,status,error){
					alert("json 연결 fail");
			        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					}
				});
			
	});
	});
	
	</script>
	<style type="text/css">
	.container{
	  padding-right: 300px;
	  padding-left: 300px;
	  padding-top: 100px;'
	  margin-right: auto;
	  margin-left: auto;
	  }
	 .fail_text{
	 	margin:10px;
	}
	</style>

</head>
<body>

<form action="/VIG/user/login" method="POST">
	<div class="container-fluid">
	
		<div class="text-center border border-light p-5">
  			<div class="row">
    <p class="h4 mb-6">Login</p>
			
			
    <!-- id -->
	    <input type="text" id="userCode" name="userCode" class="form-control mb-5" placeholder="id" required>
	    <span class="glyphicon glyphicon-ok form-control-feedback"></span>

    <!-- Password -->
   		<input type="password" id="password" name="password" class="form-control mb-2" placeholder="Password" required>
		<c:if test="${msg == 'fail' }">
    		<div class="fail_text" style="color:red">
    		아이디 또는 비밀번호를 확인해주세요.
    		</div>
    		</c:if>


    <!-- Sign in button -->
    	<button  class="btn btn-info btn-block my-4" id="login" >Sign in</button>
    
    <!-- Register -->
  
	    <p>Not a member?
	        <!-- <a href="../user/addUser">Register</a> -->
	        <span id="ty" class="blue-text ml-1"  >Register</span>
	    </p>
	    
	</div>
	</div>
	</div>
</form>


</body>
</html>