
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


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
	
//=======회원가입
		function fncAddUser() {	
			//유효성 체크
			var id=$("input[name='userCode']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();	
			var name=$("input[name='userName']").val();
			var email=$("input[name='email']").val();
			
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
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='password2']").focus();
				return;
			}
			if(email == null){
				alert("이메일은 반드시 입력하셔야 합니다.");
				return;
			}
			
			$("form").attr("method" , "post").attr("action" , "addUser").submit();
		}
		
//=======================		
		//회원가입	이벤트
		$(function(){
			$( "#signUp_btn" ).on("click" , function() {	
				fncAddUser();
			});
		});
		
	//===비밀번호 체크 이벤트
		$(function(){
			$("input[name=password2]").keyup( function(){				 				
				var password = $("input[name=password]").val();
				var password2 = $("input[name=password2]").val();				
				if(password==password2){					
					var correct = "<p style='color:green;'>비밀번호가 확인되었습니다.</p>";
					$(".check").html(correct);					
				}else{										
					var alert = "<p style='color:red; margin-bottom:0;'>비밀번호가 다릅니다.</p>";
					$(".check").html(alert);					
				}				
			});			
		});	
	
	//ID중복확인 이벤트 
		$(function(){
			$("#userCode").blur(function() {
			var id = $("#userCode").val();
			var form = {
		            userCode: id
		            }
			$.ajax({
				url:"json/checkDuplication",
				type: "POST",
				data : form,
				success: function(data){
					console.log("00 "+ data);
					if (data== false) {
						$("#id_check").text("사용중인 아이디입니다.");
						$("#id_check").css("color", "red");
						$("#reg_submit").attr("disabled", true);
					}else{
						$("#id_check").text("사용 가능합니다");
						$("#id_check").css("color", "green");
						$("#reg_submit").attr("disabled", true);
					}
				},error:function(request,status,error){
					alert("fail");
			        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					}
				
			});
			
		});
			
		});
	
	///이메일 발송 이벤트
	
	$(function(){
		$("#emailcheck").on("click",function(){
			if($("#email").val() == ''){
				alert("이메일을 입력해주세요.");
			}else{
			
				$.ajax({
				type: "GET",
				url: "json/emailSend?email="+$("#email").val(),
				dataType : "json" ,
				headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
							}
				,success : function vcode(JSONData , status) {
					var json = JSONData.verifCode
					
				
				
					$("#inputVerification").val(json);
				//alert("1"+  $("#inputVerification").val(json).val())
					alert("메일이 발송 되었습니다.");
				},
				error : function( error ) {
					alert("없는 이메일 주소입니다.");
				}	
			});
			}
		});
	});
	
	$(function(){
	$("#verifBtn").on("click",function(){
		if( $("#inputVerification").val() != $("#verification").val()){
			alert("인증에 실패했습니다.");
		}else{
			alert("인증되었습니다.");
		}
	})
	});
		//로그인 페이지로 이동 이벤트
		 $( function() {
				$("#login_nav").on("click" , function() {
					location.href="/VIG/user/loginView.jsp";
				});
			});		
		//달력 setting
		$( function() {
			   $( "#datepicker" ).datepicker({
			    showMonthAfterYear: true, 
				 dateFormat: "yy-mm-dd"	    
			    });
			  });
		
</script>
<style type="text/css">
	
	.container { padding-right: 300px; padding-left: 300px; padding-top: 100px;' margin-right: auto; margin-left: auto; }
	 #variedCode { margin:auto; }
	#top_title { margin : 30px;}
	
	#emailcheck { margin: 5px 0 5px 0; display: block; float:left;}
	#verification { display: block; width: 250px;float: left; margin-left: 58px;}
	
	
	.btn.btn-primary.btn-sm { display: block;float: right; }
	
</style>
</head>
<body>

<jsp:include page="../main/toolbar.jsp"></jsp:include>

<form>
<div class="container">
	<div class="text-center border border-light p-4">
	  <div class="row" id="top_title">
	    <p class="h4 mb-6" style="margin:30px;">Sign up</p>
	  </div>
	  
		<!-- id -->  
		<div class="form-group"  style="height:70px; margin:0; ">
			<input type="text" id="userCode" name="userCode" class="form-control " placeholder="userCode" value="${user.userCode}" required>   
			<div class="check_font" id="id_check" style="margin:7px;"></div>
		</div>
			
		<!-- 비밀번호 -->
		<div class="form-group" style="height:70px; margin:0; ">
		    <input type="text" id="userName" name="userName" class="form-control" placeholder="userName" maxlength="8" required>
		</div>
		
		<!-- 비밀번호 -->
		<div class="form-group" style="height:70px; margin:0; ">
		    <input type="password" id="password" name="password" class="form-control" placeholder="password" maxlength="8" required>
		</div>
		
		<!-- 비밀번호2 -->   
		<div class="form-group" style="height: 70px;">  
			 <input type="password" id="password2" name="password2" class="form-control " placeholder="Password2" " required>
		     <label data-error="wrong" data-success="right" for="password2"></label>
		     <span id="helpBlock" class="help-block" >
				<span class="check" style="margin-bottom:0px;"></span>
			</span>
		</div>
			
		<!-- 플필 -->  
		     <input type="hidden" id="profileImg" name="profileImg" class="form-control " value="profile_img.jpg">
		
		<!-- 성별 -->
		<div class="form-group" style="height: 40px; margin-bottom:0;">
			  <input type="radio" id="check_userSex" name="sex" value="female" ><label for="sex">female</label>
			  <input type="radio" id="check_userSex" name="sex" value="male"><label for="sex">male</label>
			</div>

		<!-- 생년월일-->
		<div class="form-group" style="height: 50px;">
			<hr/>
			<p>Birth: <input type="text" id="datepicker" name="birth" placeholder="click"></p>
			<label data-error="wrong" data-success="right" for="birth"></label>
		</div>	
		<!--  -->
		     <input type="hidden" id="state" name="state" class="form-control " value="0">
		     <input type="hidden" id="primeCount" name="primeCount" class="form-control mb-4" value="0">
		     
		<!-- 이메일 -->
		<div class="form-group" style="margin-bottom:0px;">
		   	<input type="email" id="email" name="email" class="form-control bt " placeholder="email" value="${user.email}" 
		   	style="display: block;float: left; width: 70%;">
		    <label data-error="wrong" data-success="right" for="email"></label> 
		
		<button type="button" class="btn btn-sm" id="emailcheck" >이메일발송</button>  
		  <input type="hidden" id="inputVerification" name ="inputVerification" placeholder="${inputVerification}"> 
			
			</div> 
                <input type="text" id="verification" name="verification" class="form-control bt" placeholder="variedCode" 
                style="display: block;float: left; width: 70%;">               
                <button type="button" id="verifBtn" class="btn btn-sm">인증번호확인</button> 
           
	
		<!-- role -->
			<input type="hidden" id="role" name="role" class="form-control"  value="user">
			
		<!-- google -->	
			<input type="hidden" id="googleId" name="googleId" class="form-control "  value="${user.googleId}">
			
		<!-- 가입버튼 -->
		    <button  class="btn btn-block my-4" id="signUp_btn" style="background-color: #212121; color: white;" >Sign up</button>   
				<p >Already a member? </p>
		          <span id="login_nav" class="blue-text ml-1" href="#" > login</span>
				</div>
			</div>
		

</form> 


</body>
</html>