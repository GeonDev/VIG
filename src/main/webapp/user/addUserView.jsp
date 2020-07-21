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
		
		function fncAddUser() {
			
			$("form").attr("method" , "POST").attr("action" , "addUser").submit();
		}
		
	
			$(function() {
				$( "#signUp_btn" ).on("click" , function() {
					fncAddUser();
				});
			});	
				
		</script>
</head>
<body>

회원가입 페이지

<form>
			<div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="text" id="userCode" name="userCode" class="form-control form-control-sm validate" >
                <label data-error="wrong" data-success="right" for="userCode">id</label>
              </div>
              
<!-- 비밀번호 -->
              <div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="password" id="password" name=" pssword" class="form-control form-control-sm validate" >
                <label data-error="wrong" data-success="right" for="password">Your password</label>
              </div>
<!-- 비밀번호확인 -->
              <div class="md-form form-sm mb-4">
                <i class=""></i>
                <input type="text" id="userName" name="userName" class="form-control form-control-sm validate" >
                <label data-error="wrong" data-success="right" for="password2">userName</label>
              </div>              
<!-- 이메일 -->             
              <div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="email" name="email" id="email" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="email">Your email</label>            
			</div>
<!-- 생년월일 -->      
			                    
 <!-- 성별 -->            
              <div class="md-form form-sm mb-5">
               <i class=""></i>        
                <label data-error="wrong" data-success="right" for="modalLRInput18">Gender</label><br/> 
               male <input type="radio" id="sex" name="sex" value="male"/> 
               female <input type="radio" id="sex" name="sex" value="female"/>                       
              </div>
              
              <!--  -->
             <div class="modal-footer mx-5 pt-3 mb-1">
          <p class="font-small grey-text d-flex justify-content-end">Already a member? <a href="../user/login" class="blue-text ml-1">
              Sign In</a></p>
        </div>
              
 <!-- 회원가입버튼 -->          
              <div class="text-center form-sm mt-2">
                <input type="button" id="signUp_btn"  class="btn btn-info" value="sign up"><i class="fas fa-sign-in ml-5"></i></button>
              </div>
              
   
	</form>
</body>
</html>