<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

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
		
		function fncAddUser() {	
			
			var id=$("input[name='userCode']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();	
			
			if(id == null || id.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
				return;
			}
			
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='password2']").focus();
				return;
			}
			$("form").attr("method" , "post").attr("action" , "addUser").submit();
		}
	    
		
		$(function(){
			$( "#signUp_btn" ).on("click" , function() {	
				fncAddUser();
			});
		});
		
		$( function() {
			   $( "#datepicker" ).datepicker({
			    showMonthAfterYear: true, 
				 dateFormat: "yy-mm-dd"	    
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

    <p class="h4 mb-6">Sign up</p>


<!-- id -->  
	<label data-error="wrong" data-success="right" for="userCode"></label>
	<input type="text" id="userCode" name="userCode" class="form-control mb-4" placeholder="userCode" required>   
	<div class="check_font" id="id_check"></div>
<!-- name -->
	<input type="text" id="userName" name="userName" class="form-control mb-4" placeholder="nickName" required>
	<label data-error="wrong" data-success="right" for="nickName"></label>   
<!-- 비밀번호 -->
    <input type="password" id="password" name="password" class="form-control mb-4" placeholder="Password" required>
	<label data-error="wrong" data-success="right" for="password"></label>
<!-- 비밀번호2 -->      
	 <input type="password" id="password2" name="password2" class="form-control mb-4" placeholder="Password2" required>
     <label data-error="wrong" data-success="right" for="password2"></label>
     <!-- 플필 -->
     <input type="hidden" id="profileImg" name="profileImg" class="form-control mb-4" value="profile_img.jpg">
 <!-- 성별 -->
 	<div class="row">
 	<div class="form-control mb-4" id="genderBox">
	  <input type="radio" id="sex" name="sex" value="female" >
	  <label for="sex">female</label>
	  <input type="radio" id="sex" name="sex" value="male">
	  <label for="sex">male</label>
	  </div>
	</div>
<!-- 생년월일-->
	<hr/>
	<p>Date: <input type="text" id="datepicker" name="birth"></p>
	<label data-error="wrong" data-success="right" for="birth"></label>
	<!--  -->
     <input type="hidden" id="state" name="state" class="form-control mb-4" value="0">
     <!--  -->
     <input type="hidden" id="primeCount" name="primeCount" class="form-control mb-4" value="0">
     
 <!-- 이메ㄴ일 -->	 
   	<input type="email" id="email" name="email" class="form-control mb-4" placeholder="email">
    <label data-error="wrong" data-success="right" for="email"></label>   
    
    
    
<!-- 가입버튼 -->
        <button  class="btn btn-info btn-block my-4" id="signUp_btn" >Sign up</button>   
         
          <p >Already a member? </p>
          <a href="/VIG/user/loginView.jsp" id="ty" class="blue-text ml-1"> login</span></a>
 

	</div>
	</div>
	</div>

</form>


</body>
</html>