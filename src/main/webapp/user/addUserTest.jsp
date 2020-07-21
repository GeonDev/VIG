<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>


		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>	
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
 <!-- 회원가입버튼 -->          
              <div class="text-center form-sm mt-2">
                <input type="button" id="signUp_btn"  class="btn btn-info"><i class="fas fa-sign-in ml-1"></i></button>
              </div>
	</form>
</body>
</html>