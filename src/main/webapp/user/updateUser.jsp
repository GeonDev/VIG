<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

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
		
		<script type="text/javascript">
		
		
		function fncDelete(){
			$(location).attr("action","VIG/user/deleteUser").submit();
		}	
			
		function fncUpdateUser() {		
		$("form").attr("enctype", "multipart/form-data").attr("method" , "POST").attr("action", "./updateUser").submit();
		}
			
//============= 업데이트 
			
		$(function(){
			$("#business_btn").on("click",function(){
				alert("결제창?");
			});
		});

//===비밀번호 체크 이벤트   ================================================test 정리중   코드 정리하기

	$(function(){
		$("#deleteCheck").on("click",function(){	
			var pw = $("input[id=deleteU_password]").val();
			if(pw == null || pw.length <1) {
				alert('패스워드를 입력하지 않으셨습니다.');
				$("#password").focus();
				return;
			}
		$("#deleteU_password").blur(function(){
			var pw = $("input[id=deleteU_password]").val();
			alert("1");
			//===========================ㅁajax
			$.ajax({
				url : "/json/chcekPw",
				method : "POST" ,
				data : {
					password : 'pw'
				},
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(data , status) {
					alert(data);
					alert("ok");
					
					if($(data==0)){					
						var correct = "<p style='color:green;'>비밀번호가 확인되었습니다.</p>";
						$(".check").html(correct);					
					}else{										
						var alert = "<p style='color:red;'>비밀번호가 다릅니다.</p>";
						$(".check").html(alert);
					}
				},error:function(request,status,error){
					alert("json 연결 fail");
			        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					}
				});	
			//====ajax
			});
		});
			
				
		//=========
		
			/*
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
		*/
	
		</script>
	
<style type="text/css">
	
	.col-md-12_top {	width: 100%; height: 100%; position: relative; margin:50px; }		
	.profile {	width: 100%; height: 100%; position: relative; margin:50px; }
	.col-md-12_List { padding:50; margin: auto;}
	.profile {	margin:50px;}
	
	#pImg {	display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; max-width: 150px; max-height: 150px; border-radius:50%; }	
	#getfile { display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; }	
	#form-group { display:block; margin-left:auto; margin-right:auto; }	
		#myFeedMain { padding: 70px;}
</style>		
	
</head>
<body>
	
	
	
	<!-- 상단 툴바 자리 -->
      <div class="container-fluid">  
      	 <div class="row">
      		<div class="col-md-12">
      			<jsp:include page="/main/toolbar.jsp" />
     		</div>
		</div>
		
		<div class="col-md-12">
			<div class="row">
	<!-- 사이드바 자리 -->		
			<div class="col-md-2">		
		      1 of 3 아 그리드 뭔데...ㅠㅠ
		    <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
		    </div>  
	
 <div class="col-md-10" id="myFeedMain">
	<!-- 상단 타이틀 -->
		<div class="row">
			<div class="col-md-12_top">
			<h1>내 정보 수정</h1><hr/>
			</div>
		</div>
		<form>
	<!-- 프로필 이미지 -->
		<div class="row">
	 		<div class="profile">
	 			<img class="card-img-top" src="/VIG/images/uploadFiles/${user.profileImg }" id="pImg" alt="profile_img">
				<!-- <img src="/VIG/images/uploadFiles/${user.profileImg}" id="pImg"  alt="profile_img"> -->
	<!-- 업로드 파일 -->
 				<input type="file" id="getfile" name="uploadFile" accept="image/*"><br/>
 			</div>
 		</div>
 	<!-- 정보 리스트 -->
		<div class="row" >
 			<div class="col-md-12_List" >
 	
 			<div class="form-group">
 				<p class="sign_date" align="center"> Member Since :: ${sessionScope.user.regDate}</p><hr/><br/>
 				
 			</div>
 					
			<div class="form-group">
			    <label for="userCode" class="col-sm-offset-5 col-md-5 control-label">아 이 디</label>
			    <input type="text" class="form-control" id="userCode" name="userCode" value="${user.userCode }" readonly>
			</div>
			  
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-5 col-md-5 control-label">닉네임</label>
			    <input type="text" class="form-control" id="userName" name="userName" value="${user.userName }" >
			</div>
			  
			<div class="form-group">
			    <label for="password" class="col-sm-offset-5 col-md-5 control-label">비밀번호</label>
			    <input type="text" class="form-control" id="user_password" name="password"  >
			</div>
			   
			<div class="form-group">
			    <label for="selfIntroduce" class="col-sm-offset-5 col-md-5 control-label">자기소개</label>
			    <textarea cols="40" rows="5" id="selfIntroduce" name="selfIntroduce" placeholder="${user.selfIntroduce }"></textarea>
			</div>
		
			<div class="form-group">
			    <label for="account" class="col-sm-offset-5 col-md-5 control-label">계좌번호</label>
			    <input type="text" class="form-control" id="account" name="account" value="${user.account }" >
			</div>
	
	<!-- 비지니스 계정으로 전환 버튼 넣기-->	
		<c:if test="${sessionScope.user.role=='user'}">  
			<div class="form-group">
			    <button type="button" class="button btn btn-primary" id="business_btn">비지니스전환</button>
			</div>
		</c:if>
	
	
	<!-- 수정 및 탈퇴 버튼 -->
			<div class="form-group">
				<button type="button" class="button btn btn-primary" id="updateUser_btn">수 &nbsp;정</button>		 
			     <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#deleteCheckModal">탈 &nbsp;퇴</button>
				<!--  <a class="btn btn-primary btn" href="#" role="button" data-toggle="modal" data-target="#deleteCheckModal">탈 &nbsp;퇴</a> -->
			</div>
					
				  
				  </div>
			</div>
		</form>
		
			
	<!--회원탈퇴 모달 확인창-->
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
			<form method="post" action="/user/json/chcekPw" >
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



</body>
</html>