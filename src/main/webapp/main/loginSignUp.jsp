<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/sign up</title>
<title>VIG</title>

		<!-- Font Awesome -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
		<!-- Bootstrap core CSS -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
		<!-- Material Design Bootstrap -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
		
<style>
</style>

<script type="text/javascript">
	<!--
	$( function() {
			$("#email").focus();			
				$(".btn btn-info:contains('Log in')").on("click" , function() {
	
					var email=$("input:text").val();
					var pw=$("input:password").val();
					
					if(email == null || email.length <1) {
						alert('email 을 입력하지 않으셨습니다.');
						$("input:text").focus();
						return;
					}
					
					if(pw == null || pw.length <1) {
						alert('패스워드를 입력하지 않으셨습니다.');
						$("input:password").focus();
						return;
					}	
					$.ajax( 
							{
								url : "",
								method : "POST" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								data : JSON.stringify({
									email : email,
									password : pw
								}),
								success : function(JSONData , status) {
										//Debug...
										//alert(status);
										//alert("JSONData : \n"+JSONData);
										//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
										//alert( JSONData != null );									
									if( JSONData != null ){
										//[방법1]
										$(window.parent.document.location).attr("href",".jsp");
									}else{
										alert("아이디 , 패스워드를 다시 확인해주세요");
									}
								}
						}); 									
				});
			});
				-->

</script>

</head>


<body>
	
	<!-- JQuery -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	


<!--  모달 : 로그인/회원가입 -->

<!-- 모달 상단 로그인,회원가입 선택 탭 -->
	<div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog cascading-modal" role="document">
	    <!--Content-->
	    <div class="modal-content">
	
	      <!--Modal cascading tabs-->
	      <div class="modal-c-tabs">
	
	        <!-- Nav tabs -->
	        <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3" role="tablist">
	          <li class="nav-item">
	            <a class="nav-link active" data-toggle="tab" href="#loginPanel" role="tab"><i class="fas fa-user mr-1"></i>
	              Login</a>
	          </li>  
		      <li class="nav-item">
	            <a class="nav-link" data-toggle="tab" href="#signUpPanel" role="tab"><i class="fas fa-user-plus mr-1"></i>
	              SignUp</a>
	          </li>       
	        </ul>

<!--  탭 내용 -->
        <!-- Tab panels -->
        <div class="tab-content">        
<!-- 로그인 파트 -->     
          <div class="tab-pane fade in show active" id="loginPanel" role="tabpanel">
        
            <div class="modal-body mb-1">
              <div class="md-form form-sm mb-5">
                <i class="fas fa-envelope prefix"></i>
                <input type="email" id="email" name="email" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="email">Email</label>
              </div>

              <div class="md-form form-sm mb-4">
                <i class="fas fa-lock prefix"></i>
                <input type="password" id="password" name="password" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="password">password</label>
              </div>        
              <div class="text-center mt-2">
                <button type="submit" class="btn btn-info">Log in <i class="fas fa-sign-in ml-1"></i></button>
              </div>
	      </div>
	    </div>
<!-- 회원가입 파트 -->
          <div class="tab-pane fade" id="signUpPanel" role="tabpanel">
   <!--Body-->
            <div class="modal-body">      
            <div class="md-form form-sm mb-5">
                <input type="hidden" id="modalLRInput13" />              
              </div>          
 <!-- 닉네임 -->           
              <div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="text" id="nickName" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="nickName">nick name</label>
              </div>
              
              
              <div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="email" name="email" id="email" class="form-control form-control-sm validate" width:50px;>
                <label data-error="wrong" data-success="right" for="email">Your email</label>
                <button type="submit" value="Register" class="btn btn-info btn-sm">send email</button>		                    
              
       			<input type="text" class="username_input" name="useremail" check_result="fail" required />
				<button type="submit" class="btn btn-info btn-sm" onclick="id_overlap_check()">중복검사</button>
				<img id="id_check_sucess" style="display: none;"> 
			</div>
<!-- 비밀번호 -->
              <div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="password" id="password" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="password">Your password</label>
              </div>
<!-- 비밀번호확인 -->
              <div class="md-form form-sm mb-4">
                <i class=""></i>
                <input type="password" id="password2" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="password2">Repeat password</label>
              </div>
<!-- 생년월일 -->      
				<div class="md-form md-outline input-with-post-icon datepicker">
				  <input placeholder="Select date" type="date" id="example" class="form-control">
				  <label for="example">Try me...</label>
				</div>    
             <!-- <div class="md-form form-sm mb-5">
                <i class="fas fa-lock prefix"></i>
                <input type="password" id="password" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="password">Your password</label>
              </div> 
              -->                         
 <!-- 성별 -->            
              <div class="md-form form-sm mb-5">
               <i class=""></i>        
                <label data-error="wrong" data-success="right" for="modalLRInput18">Gender</label>         	                      
              </div>
 <!--  --> 
 				<div class="md-form form-sm mb-5">
                <i class=""></i>
                <input type="password" id="password" class="form-control form-control-sm validate">
                <label data-error="wrong" data-success="right" for="password">Your password</label>
              </div> 
 <!-- 회원가입버튼 -->          
              <div class="text-center form-sm mt-2">
                <button type="submit" class="btn btn-info">Sign up <i class="fas fa-sign-in ml-1"></i></button>
              </div>

            </div>
            <!--Footer-->
            <div class="modal-footer">
              <div class="options text-right">
                <p class="pt-1">Already have an account? <a href="#loginPanel" class="blue-text">Log In</a></p>
              </div>
              <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
            </div>
          </div>
          <!--/.Panel 8-->
  </div>
</div>
</div>
</div>
</div>
		


</body>
</html>