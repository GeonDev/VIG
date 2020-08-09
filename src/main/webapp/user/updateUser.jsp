<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
		
	<script src="/VIG/javascript/jQuery.tagify.min.js"></script>
 	<link rel="stylesheet" href="/VIG/css/tagify.css">
 	<!--  drag and drop -->
 	<script src="/VIG/javascript/dropify.js"></script>
 	<link rel="stylesheet" href="/VIG/css/dropify.min.css">
		<script type="text/javascript">
					
		$(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				alert("1");
				 $("form").attr("method", "POST").attr("enctype","multipart/form-data").attr("action", "updateUser").submit();
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
					var alert = "<p style='color:red;'>비밀번호가 다릅니다.</p>";
					$(".check").html(alert);					
				}				
			});			
		});
		
//===비밀번호 체크 이벤트   ================================================test 정리중   코드 정리하기
		$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		});
		
		$(function(){
			var file = document.querySelector('#getfile');

			$(file).on('change', function() {
			  var fileList = file.files;
				
			  // 읽기
			  var reader = new FileReader();
			  reader.readAsDataURL(fileList[0]);

			  		//로드 한 후
				  reader.onload = function() {
			  			
				    //로컬 이미지를 보여주기
				    document.querySelector('#preview').src = reader.result;
				
				    //썸네일 이미지 생성
				    var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
				    tempImage.src = reader.result; //data-uri를 이미지 객체에 주입					
		 	 	};
			});	
		});	
		
		//구글 로그인
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#googlelogin").on("click" , function() {
				location.href="https://accounts.google.com/o/oauth2/auth?client_id="+
				"82747934090-ljsrvma8goa9dskv7hchor1mt2atl1ao.apps.googleusercontent.com"+
				"&redirect_uri="+
				"http://localhost:8080/VIG/user/googleLogin" +
				"&response_type=code&scope=https://www.googleapis.com/auth/userinfo.email&approval_prompt=force&access_type=offline";				
			});
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
	.info_box {
    margin-left: 9%;
    }
	

	
	#pImg {	display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; max-width: 150px; max-height: 150px; border-radius:50%; }	
	#getfile { display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; }	
	#form-group { display:block; margin-left:auto; margin-right:auto; }	
		#myFeedMain { padding: 70px;}
	
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}	
		
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
				 
  			<!-- 타이틀 -->
			    <div class="col-md-10" id="mainMyFeedPage" >	
			<h1>내 정보 수정</h1><hr/>
			
			
		
		<form method="POST">
		
	<!-- 프로필 이미지 -->
		<div class="row_img" style="display: flex;-ms-flex-wrap: wrap; margin-left: -15px;">
	 		<div class="profile">
	 			<img src="/VIG/images/uploadFiles/${user.profileImg}" id="pImg" alt="profile_img">
		
	<!-- 업로드 파일 -->
 				<input type="file" id="getfile" name="uploadFile" accept="image/*"><br/>

 			</div>
 			
 			
 		</div>
 	<!-- 정보 리스트 -->
 	
	<div class="row" style="padding-left: 10%; padding-right: 10%; display: flex;-ms-flex-wrap: wrap;flex-wrap: wrap; margin-right: 100px; margin-left: -15px;" >
 					
 	<div class="info_box one" style="margin-right: 100px;">			
			<div class="form-group">
			    <label for="userCode" class="col-sm-offset-5 col-md-5 control-label">아 이 디</label>
			    <input type="text" class="form-control" id="userCode" name="userCode" value="${user.userCode }" readonly>
			</div>
			  
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-5 col-md-5 control-label">닉네임</label>
			    <input type="text" class="form-control" id="userName" name="userName" value="${user.userName }" >
			</div>
			 
			<div class="form-group" >
			<label for="psaaword" class="col-sm-offset-5 col-md-5 control-label">password</label>
		    <input type="password" id="password" name="password" class="form-control " placeholder="8자리 이하 입력" maxlength="8" >
			<label data-error="wrong" data-success="right" for="password"></label>
		</div>
		
		<!-- 비밀번호2 -->   
		<div class="form-group" >  
			 <input type="password" id="password2" name="password2" class="form-control " placeholder="check your password" >
		     <label data-error="wrong" data-success="right" for="password2"></label>
		     <span id="helpBlock" class="help-block">
				<span class="check"></span>
			</span>
		</div>
		</div>
		
		<div class="infor_box2 two">   
			<div class="form-group">
			    <label for="selfIntroduce" class="col-sm-offset-5 col-md-5 control-label">자기소개</label>
			    <textarea cols="40" rows="5" id="selfIntroduce" name="selfIntroduce" placeholder="${user.selfIntroduce }" 
			    style="width: 500px;" maxlength="330" onkeyup="return textarea_maxlength(this)"></textarea>
			</div>
		
	
	
	<div class="btn_grop" style="display: flex;justify-content: center;margin-bottom: 30px;">
		<!-- 비지니스 계정 번환 버튼 -->	
		<c:if test="${user.role=='user'}">  
	    	<button  class="btn btn-primary" id="business_btn" style="font-size: middle; margin-left: 0px; text-align: top;"
	    	> 비지니스 계정 전환</button>
			</c:if>
		<!-- 구글 로그인  -->
			<c:if test="${empty user.googleId}">  
			
	    	<button  class="btn btn-primary  " id="googlelogin" >
	    		<i class="fab fa-google" id="googlelogin" style="font-size: large; margin-left: 0px; text-align: top;"></i>&emsp; Google
	    		</button>
			</c:if>
	</div>
	<hr/>
			
			
			<div class="btn_group2" style="display: flex;justify-content: center;margin-bottom: 30px;">
				 	<button type="button" class="button btn btn-primary" id="updateUser_btn">수 &nbsp;정</button>		 
				     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#deleteCheckModal">탈 &nbsp;퇴</button> 
				</div>
		
		
		</div>	
	</form>
	

			
			
					</div>
					</div>
				
				  
				  </div>
			</div>
		</form>
		
			
	<!--회원탈퇴 모달 확인창
			<div class="modal fade" id="deleteCheckModal"  role="dialog" >
				<div class="modal-dialog modal-notify modal-warning" role="document">
					<div class="modal-content">				
						<div class="modal-header text-center">
							<h4 class="modal-title white-text w-100 font-weight-bold py-2">탈퇴</h4>
							 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						     <span aria-hidden="true" class="white-text">&times;</span>
						     </button>
						</div>
					 <div class="modal-body text-center mb-1">
						<div class="md-form ml-0 mr-0">
			<form class="deleteCheckForm" method="post" action="/user/json/chcekPw" >
						  <input type="password" id="deleteU_password" name="password" class="form-control form-control-sm ">
						  <label data-error="wrong" data-success="right" for="form29" class="ml-0">Enter password</label>
						   <span id="helpBlock" class="help-block">
								<span class="check"></span>
							</span>
			</form>
						</div>
						<div class="modal-footer justify-content-center" style="border:0;">
	        				 <a type="button" class="btn btn-outline-warning waves-effect" id="deleteCheck">탈퇴 <i class="fas fa-paper-plane-o ml-1"></i></a>
	        				 <a type="button" class="btn btn-outline-warning waves-effect" data-dismiss="modal">취소 <i class="fas fa-paper-plane-o ml-1"></i></a>
	     			 	 </div>
					  </div>
				    </div>
				 </div>
			 </div>
			</div>
		</div>
		</div>
		-->	
		
	 </div>



</body>
</html>