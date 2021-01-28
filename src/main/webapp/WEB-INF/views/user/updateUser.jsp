<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
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
	<!-- sweet Alert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


 	<!--  drag and drop -->
 	<script src="/VIG/javascript/dropify.js"></script>
 	<link rel="stylesheet" href="/VIG/css/dropify.min.css">
 	
 	
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script type="text/javascript">
		
		
		//탈퇴 페이지로 이동 
		$(function() {
			$( "#deleteUser_nav" ).on("click" , function() {
				location.href="/VIG/user/deleteUser.jsp";
			});
		});	
		
		
		//업데이트 이벤트 
		$(function() {
		$("#updateUser_btn").on("click", function(){		
				var password = $("input[name='password']").val();
				
				if( password===null | password.length <1 ){
					
					swal("Aww..", "비밀번호를 입력해주세요!", "warning", {
						  button: "확인",
						});
					
					return false;
					
				}
				$(".myform").attr("method","POST").attr("enctype","multipart/form-data").attr("action","/VIG/user/updateUser").submit();			
			});
		});

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

		
		
	//구글 로그인
	$( function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("#googlelogin").on("click" , function() {
			location.href="https://accounts.google.com/o/oauth2/auth?client_id="+
			"153642235365-kg8rl6mmbhk7rh4tuefg790id1llegd1.apps.googleusercontent.com"+
			"&redirect_uri="+
			"http://localhost:8080/VIG/user/googleLogin" +
			"&response_type=code&scope=https://www.googleapis.com/auth/userinfo.email&approval_prompt=force&access_type=offline";				
		});
	});
	
		//비지니스 계정 전환
		$( function() {
			
			$("#business_btn").on("click", function(){		
				var cf = confirm("비지니스 계정으로 전환 하시겠습니까?");
				
				if(cf==true){				
				self.location="/VIG/payment/addPayment?productType=1"; //세션에서 user코드를 가져온다.			
				} else if (cf==false) {				
				}		
			});
		});
		
		//프라임 피드 추가 결제
		$( function() {
			
			$("#addPrimeFeed_btn").on("click", function(){		
				var cf = confirm("프라임 피드 추가 결제를 진행 하시겠습니까?");
				
				if(cf==true){				
				self.location="/VIG/payment/addPayment?productType=0"; 			
				} else if (cf==false) {				
				}		
			});
		
		});
		//drag and drop
		$(function (){
			

		$('.dropify').dropify();



		});
	
		</script>
	
<style type="text/css">
		
	body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
	
	h1 { margin-left: 100px;}
	
	.col-md-12{ margin-bottom: 50px;}
	
	.col-md-12_top {	width: 100%; height: 100%; position: relative; margin:50px; }	
		
	.profile {	width: 100%; height: 100%; position: relative; margin:50px; }
	
	.col-md-12_List {
    margin-left: 20%;
    margin-right: 20%;
    width: 800px;
    }
	.profile {	margin:30px; margin-right: 90px; margin-bottom:0;}
	.form-group{    width: 500px;
	    margin-left: auto;
	    margin-right: auto;
	    margin-bottom: 30px;}
	

	#form-group { display:block; margin-left:auto; margin-right:auto; }	
		#myFeedMain { padding: 70px;}
	
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}	
	
	.info_box.two { margin:50px;}	
	
	.dropify-wrapper {
     display:block; margin: auto; height: 300px; max-width: 300px; max-height: 300px; padding:0;
	}
	
	.info {	
	margin: 10px auto;		
	}
	
	.file-icon p{
	
		visibility: hidden;
	
	}
	.file-icon p:after{
		
		font-size: 15px;
		visibility: visible;
		content: "이미지업로드";
		padding-right: 100px;
	
	}
	
	label {
	
	font-size: 20px;
	
	}
	.btn-primary{ background-color: #3F729B !important;}
	.btn.a{ color: #fafafa;}

</style>		
	
</head>
<body>

		<!-- 툴바 -->
	      <div class="container-fluid">  
		    <div class="row">
		    	<div class="col-md-12">
		      			<jsp:include page="/main/toolbar.jsp"></jsp:include>
		     	</div>
			</div>
		
		
			<!-- 사이드바  -->		
			<div class="col-md-2 sideBarPlace">		
				 <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
			</div>
				 
				 
	 			<!-- 타이틀 -->
			<div class="col-md-10 col-md-offset-4"  id="mainMyFeedPage" >	
				<h1>내 정보 수정</h1>
				
			<hr/>			
				
			
				<form class="myform" enctype="multipart/form-data">
					<br/>
					<!-- 프로필 이미지 설정 -->
					<!--  <img class="card-img-top" src="/VIG/images/uploadFiles/${user.profileImg}" id="pImg" alt="profile_img"> -->
					<input type="file" id="demo" name="uploadFile" class="dropify"  data-default-file="/VIG/images/uploadFiles/${user.profileImg}">
					<br/>
							
			 			
			 		<hr/>	
			 		
			 
								
			 		<div class="info_box one" style="margin: auto;">			
						<div class="form-group">
						    <label for="userCode" class="font-weight-bold col-sm-offset-7 col-md-5 control-label">아 이 디</label>
						    <input type="text" class="form-control" id="userCode" name="userCode" value="${user.userCode }" readonly>
						</div>
						  
						<div class="form-group">
						    <label for="userName" class="font-weight-bold col-sm-offset-7 col-md-5 control-label">닉네임</label>
						    <input type="text" class="form-control" id="userName" name="userName" value="${user.userName }" >
						   
						</div>
						 
						
					<div class="form-group" style="height:70px;  ">
					<label for="userName" class="font-weight-bold col-sm-offset-7 col-md-5 control-label">비밀번호</label>
					    <input type="password" id="password" name="password" class="form-control" placeholder="password" maxlength="8" required >
					    
					</div>
					
					  
					<div class="form-group" style="height: 70px;">  
					<label for="userName" class="font-weight-bold col-sm-offset-7 col-md-5 control-label">비밀번호확인</label>
						 <input type="password" id="password2" name="password2" class="form-control " placeholder="Password"  required>
					     <label data-error="wrong" data-success="right" for="password2"></label>
					     <span id="helpBlock" class="help-block" >
							<span class="check" style="margin-bottom:0px;"></span>
						</span>
					</div>
					</div>
					<div class="info_box two" style="margin: auto;">   
						<div class="form-group">
						    <label for="selfIntroduce" class="font-weight-bold col-sm-offset-7 col-md-5 control-label" style="padding-top: 20px;">자기소개</label>
						    <textarea cols="40" rows="5" id="selfIntroduce" name="selfIntroduce"
						    style="width: 500px;" maxlength="330" onkeyup="return textarea_maxlength(this)">${user.selfIntroduce }</textarea>
						</div>
					
				
				 
					<c:if test="${sessionScope.user.role =='user'}">  
						<div class="form-group">
						    <button type="button" class="button btn btn-primary" id="business_btn">비즈니스전환</button>
						</div>
					</c:if>
					
					<c:if test="${sessionScope.user.role =='business'}">  
						<div class="form-group">
						    <button type="button" class="button btn a btn-primary" id="addPrimeFeed_btn">프라임피드 추가 결제</button>
						</div>
					</c:if>					
					
					<c:if test="${user.googleId == null}"> 		
					<div class="form-group">			
				    	<button  class="button btn a btn-primary" id="googlelogin" style="width: 500px; margin:auto; ">
				    		<i class="fab fa-google" style="font-size: large; text-align: top;"></i>&emsp; Sign in With Google
				    	</button>
				    	</div>
					</c:if>				
				
				
					<div class="btn_group2" style="display: flex;justify-content: center;margin-bottom: 30px;">
						 	<button type="button" class="btn" id="updateUser_btn">수 &nbsp;정</button>		 
						     <button type="button" class="btn" id="deleteUser_nav">탈 &nbsp;퇴</button> 
					</div>
							
						
					</div>
						
					
			</form>
		</div>
	</div>
	
		




</body>
</html>