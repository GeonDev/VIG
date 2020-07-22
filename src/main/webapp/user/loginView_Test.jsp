<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
				
	<!-- JQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
			

		<script type="text/javascript">
		
	function fncLogin() {		
			$("form").attr("method" , "POST").attr("action" , "login").submit();
		}
		$( function(){
			$("#login_btn").on("click" ,function(){
				var code=$("input[name='userCode']").val();
				var pw=$("input[name='password']").val();
				fncLogin();
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
								userCode : code,
								password : pw
								}),
							success : function(JSONData , status) {			
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								//alert( JSONData != null );
								alert("로그인완료");
								if( JSONData != null ){								
									//$(self.location).attr("href","../myFeed/myFeed.jsp");		
									
								}else{
									alert("아이디 또는 비밀번호가 틀렸습니다.");
									}
								}
							}); 
						});
					});
			
		$( function() {
			$("#signUp_btn").on("click" , function() {
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

<form >

<div class="container">
<div class="text-center border border-light p-5">
  <div class="row">

    <p class="h4 mb-6">Sign in</p>

    <!-- id -->
    <input type="text" id="userCode" name="userCode" class="form-control mb-5" placeholder="id">

    <!-- Password -->
    <input type="password" id="password" name="password" class="form-control mb-5" placeholder="Password">

    <div class="d-flex justify-content-around">
        <div>
            <!-- Remember me -->
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="defaultLoginFormRemember">
                <label class="custom-control-label" for="defaultLoginFormRemember">Remember me</label>
            </div>
        </div>
        <div>
            <!-- Forgot password -->
          
        </div>
    </div>

    <!-- Sign in button -->
    <button class="btn btn-info btn-block my-4" id="login_btn" type="submit">Sign in</button>

    <!-- Register -->
  
    <p>Not a member?
        <a href="../user/addUser">Register</a>
    </p>
	<hr/>

    <!-- Social login -->
    <p>or sign in with:</p>

    <a href="#" class="mx-2" role="button"><i class="fab fa-facebook-f light-blue-text"></i></a>
    <a href="#" class="mx-2" role="button"><i class="fab fa-twitter light-blue-text"></i></a>
    <a href="#" class="mx-2" role="button"><i class="fab fa-linkedin-in light-blue-text"></i></a>
    <a href="#" class="mx-2" role="button"><i class="fab fa-github light-blue-text"></i></a>
	</div>
	</div>
	</div>
</form>

</body>
</html>