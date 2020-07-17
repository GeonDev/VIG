<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

		<!-- Font Awesome -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
		<!-- Bootstrap core CSS -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
		<!-- Material Design Bootstrap -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
		
		<script type="text/javascript">
		
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

          
         

</body>
</html>