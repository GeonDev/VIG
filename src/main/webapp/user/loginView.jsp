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
		

	function fncloginGo(){
		$("form").attr("method", "post").attr("action", "login").submit();
	}
	function fncReset(){
		//로그인 실패하면 input내용 지워주기
	}
	
	
		$( function(){
			$("#userCode").focus();
			$("#login").on("click" ,function(){
				
				var id=$("input[name='userCode']").val();
				var pw=$("input[name='password']").val();
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}	
				
				$.ajax( 
						{
							url : "json/login",
							method : "POST" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
								},
							data : JSON.stringify({
								userCode : id,
								password : pw
								}),
							success : function(JSONData , status) {										
								alert(JSONData.userCode);
								//if( JSONData != null ){
								 if(JSONData.userCode == id && JSONData.password == pw ){
									alert("로그인성공");	
									$(self.location).attr("href","../main/main.jsp");	
									}else{
									alert("아이디 또는 비밀번호를 확인해주세요.");
									$("#userId").focus();
									return;
									}
								}
							}); 
				
				fncloginGo();
				
						});
					});
		$( function() {
			$("#ty").on("click" , function() {
				self.location = "../user/addUserView.jsp";
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

<form>
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