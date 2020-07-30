<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

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
			
		
	<script type="text/javascript">
	
//=====
	$( function() {
		$("#ty").on("click" , function() {
			self.location = "/VIG/user/addUserView";
		});
	});
//====	
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
			$.ajax( 
					{
						url : "/json/login",
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : JSON.stringify({
							userId : id,
							password : pw
						}),
						success : function(JSONData ) {

							alert("TT");
							if( JSONData != null ){
								//$(window.parent.document.location).attr("href","");
							}else{
								alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
							}
						}
			
			//$("form").attr("method","POST").attr("action","login").submit();
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
	</style>

</head>
<body>
<jsp:include page="../main/toolbar.jsp"></jsp:include>

<form method="post">
<div class="container">
<div class="text-center border border-light p-5">
  <div class="row">

    <p class="h4 mb-6">Login</p>

    <!-- id -->
    <input type="text" id="userCode" name="userCode" class="form-control mb-5" placeholder="id">
    <span class="glyphicon glyphicon-ok form-control-feedback"></span>

    <!-- Password -->
    <input type="password" id="password" name="password" class="form-control mb-5" placeholder="Password">

    <!-- Sign in button -->
    <button  class="btn btn-info btn-block my-4" id="login" >Sign in</button>

    <!-- Register -->
  
    <p>Not a member?
        <!-- <a href="../user/addUser">Register</a> -->
        <span id="ty" class="blue-text ml-1">Register</span>
    </p>
	</div>
	</div>
	</div>
</form>


</body>
</html>