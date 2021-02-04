
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

//뒤로가기 방지
window.history.forward();
function noBack(){window.history.forward();}
	
//=======회원가입
		function fncAddUser() {	
			//유효성 체크
			var id=$("input[name='userCode']").val();
			var pw=$("input[name='password']").val();
			var pw_confirm=$("input[name='password2']").val();	
			var name=$("input[name='userName']").val();
			var email = document.getElementById("email");
			
			
			if(id == null || id.length <2){
				alert("아이디는 2글자 이상입니다.");
				return;
			}
			if(name == null || name.length <1){
				alert("이름은 반드시 입력하셔야 합니다.");
				return;
			}
			if(pw == null || pw.length <4){
				alert("패스워드는 4자리 이상 입니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <4){
				alert("패스워드 확인은 반드시 입력하셔야 합니다.");
				return;
			}
		
			if( pw != pw_confirm ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:text[name='password2']").focus();
				return;
			}
	
			if(email.value=="") {
		           alert("이메일을 입력해 주세요");
		           email.focus();
		           return false;
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
				$("input:email[name='email']").focus();
				alert("이메일을 입력해주세요!");
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
					alert("메일이 발송되었습니다!");
				},
				error : function( error ) {
					alert("이메일 주소를 확인해주세요!");
				}	
			});
			}
		});
	});
	
	$(function(){
	$("#verifBtn").on("click",function(){
		if( $("#inputVerification").val() != $("#verification").val()){
			alert("인증에 실패했습니다");
		}else{
			alert("인증되었습니다");
		}
	})
	});
		

		
		$(function(){
			$('#theModal').on('show.bs.modal', function(e) {		
				var button = $(e.relatedTarget);
				var modal = $(this);
				
				modal.find('.modal-body').load(button.data("remote"));			
		});
		});
		
</script>
<style type="text/css">
	
	
	 #variedCode { margin:auto; }
	#top_title { margin : 30px;}
	
	
	#verification { display: block; width: 250px;float: left;}
	
	.container_addUser {     width: 650px;
    display: block;
    margin: auto;
    margin-top: 100px;}
	.btn.btn-primary.btn-sm { display: block;float: right; }
	.container_addUser{ background-color:white;}
	
	/* 회원가입 바탕 CSS */
	@import url(https://fonts.googleapis.com/css?family=Open+Sans);

	* { -webkit-box-sizing:border-box; -moz-box-sizing:border-box; -ms-box-sizing:border-box; -o-box-sizing:border-box; box-sizing:border-box; }

	html { width: 100%; height:100%; overflow:hidden; }

	body { 
    width: 100%;
    height:100%;
    font-family: 'Open Sans', sans-serif;
    background: #092756;
    background: -moz-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%),-moz-linear-gradient(top,  rgba(57,173,219,.25) 0%, rgba(42,60,87,.4) 100%), -moz-linear-gradient(-45deg,  #670d10 0%, #092756 100%);
    background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -webkit-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -webkit-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
    background: -o-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -o-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -o-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
    background: -ms-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), -ms-linear-gradient(top,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), -ms-linear-gradient(-45deg,  #670d10 0%,#092756 100%);
    background: -webkit-radial-gradient(0% 100%, ellipse cover, rgba(104,128,138,.4) 10%,rgba(138,114,76,0) 40%), linear-gradient(to bottom,  rgba(57,173,219,.25) 0%,rgba(42,60,87,.4) 100%), linear-gradient(135deg,  #670d10 0%,#092756 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3E1D6D', endColorstr='#092756',GradientType=1 );
	}

	input { 
    width: 100%; 
    margin-bottom: 10px; 
    background: rgba(0,0,0,0.3);
    border: none;
    outline: none;
    padding: 10px;
    font-size: 13px;
    color: #fff;
    text-shadow: 1px 1px 1px rgba(0,0,0,0.3);
    border: 1px solid rgba(0,0,0,0.3);
    border-radius: 4px;
    box-shadow: inset 0 -5px 45px rgba(100,100,100,0.2), 0 1px 1px rgba(255,255,255,0.2);
    -webkit-transition: box-shadow .5s ease;
    -moz-transition: box-shadow .5s ease;
    -o-transition: box-shadow .5s ease;
    -ms-transition: box-shadow .5s ease;
    transition: box-shadow .5s ease;
	}
	input:focus { box-shadow: inset 0 -5px 45px rgba(100,100,100,0.4), 0 1px 1px rgba(255,255,255,0.2); }
	

	
	
</style>
</head>
<!-- 뒤로가기방지 -->
	<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">

<jsp:include page="../main/toolbar.jsp"></jsp:include>

<form>


	
<div class="container_addUser">
	<div class="text-center border border-light p-4">
	<div id="logo" >
	  <div class="row" id="top_title">
	    <p class="h4 mb-6" style="margin:30px;">Sign up</p>
	  </div>
	  </div>
		<!-- id -->  
		<div class="form-group"  style="height:70px; margin:0; ">
			<input type="text" id="userCode" name="userCode" class="form-control " placeholder="id" value="${user.userCode}" required>   
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
			
			 
                <input type="text" id="verification" name="verification" class="form-control bt" placeholder="verificationCode" 
                style="display: block;float: left; width: 70%;">               
                <button type="button" id="verifBtn" class="btn btn-sm">인증번호확인</button> 
           </div>
	
		<!-- role -->
			<input type="hidden" id="role" name="role" class="form-control"  value="user">
			
		<!-- google -->	
			<input type="hidden" id="googleId" name="googleId" class="form-control "  value="${user.googleId}">
			
		<!-- 가입버튼 -->
		    <button  class="btn btn-block my-4" id="signUp_btn" style="background-color: #212121; color: white;" >Sign up</button>   
				<p >Already a member? </p>
		          <span id="login_nav" class="blue-text ml-1"  data-remote="/vig/user/loginView.jsp"
				data-toggle="modal" data-target="#theModal" > login</span>
				</div>
			</div>
		

</form> 


</body>
		<div class="modal fade" id="theModal" role="dialog" >
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header"></div>
							<form action="/vig/user/login" method="POST">
							<div class="modal-body"></div>
								</form>
							<div class="modal-footer">
							</div>
						</div>
					</div>
				</div>
</html>