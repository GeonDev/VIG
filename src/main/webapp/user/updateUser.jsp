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
		
		//============= 수정
		 $(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdateUser();
			});
		});		
		//============= 탈퇴
		$(function() {
			$("btn.btn-outline-warning.waves-effect").on("click" , function() {
				fncDelete;
			});
		//======			
			$("#deleteCheck").on('hidden.bs.modal', function(){
			    alert("계정이 삭제되었습니다.");
			});		
		});
		function fncDelete(){
			$(location).attr("action","VIG/user/deleteUser").submit();
		}	
			
		function fncUpdateUser() {		
		$("form").attr("enctype", "multipart/form-data").attr("method" , "POST").attr("action", "updateUser").submit();
		}
		
		//=========
		/*	
		$(function(){
			var file = document.querySelector('#getfile');

			$(file).on('change', function() {
			  var fileList = file.files;
				console.log("1");
			  // 읽기
			  var reader = new FileReader();
			  reader.readAsDataURL(fileList[0]);
			  console.log("2");

			  		//로드 한 후
				  reader.onload = function() {
					  console.log("3");
				    //로컬 이미지를 보여주기
				    document.querySelector('#preview').src = reader.result;
				
				    //썸네일 이미지 생성
				    var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
				    tempImage.src = reader.result; //data-uri를 이미지 객체에 주입

		  	}
			});	
		});
		*/
	
		</script>
	<!-- 스타일 태그 정리하고 수정하기 -->	       <!-- 그리드 완전 엉망 정리하기 -->
		<style type="text/css">
		.col-md-12{
			padding: 100px 70px 70px;
		}
		.col-md-10{
			padding: 20px auto;
		}
		#preview{		
			display:block;	margin:auto;	margin-left:auto;	margin-right:auto;
			width: auto; height: auto;	 max-width: 300px;	 max-height: 200px;
			border-radius:100%;	position: relative; z-index: 2;
	    }
		#getfile{
		   padding: auto;
		}
		.uuu, .row_n{
		    margin:0; padding:0; margin-left:auto; margin-right:auto; position:relative;
	      }
		   #imgUpdate{
		    position: absolute; top:0; left:0;
		   }
		    
		    #update{
		    position: absolute; top:0; left:0;
		    }
		  hr {
			  height: 2px; background-color: gray;
			}
			.infoList{					
			margin: 70px auto; width: auto;  height: auto; max-width: 300px; max-height: 200px;
			}
			#userInfo.1{
			padding: auto;
			}
			.infoList{
				margin: auto;
			}

			.btn.btn-elegant{
			display:block; margin-left:auto; margin-right:auto;
			}
			 #sns_nav{
		   display:flex; margin: 70px auto; flex-direction: row; justify-content: center;
		   }
		</style>
				
</head>
<body>

	
	
	<div class="container">
<form >
	<div class="row">
		<div class="col-md-12">
		<div class="sangdan"><h1>내 정보 수정</h1></div>
		<hr/>
		</div>
		</div>
	<div class="row">
 			<div class="col-md-12 "> 
 	<!-- 프로필 사진 -->	
 	<div class="uuu">					
 				<div class="profile">
			<img id="preview" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg"  alt="profile_img">
 				</div>
		<!--//////////////  -->
 					<input type="file" id="getfile" name="file" accept="image/*">
 				
 				<br/>
	<div class="row" >
 		<div class="col-md-12">
 			<div class="infoList">
 			<p class="sign_date" align="center"> Member Since :: ${user.regDate}</p>
 					<hr/><br/>
 					
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
		    <textarea cols="40" rows="5" id="selfIntroduce" name="selfIntroduce" placeholder="Hello. my name is ${user.userName }">${user.selfIntroduce }</textarea>
	
		  <div class="form-group">
		    <label for="account" class="col-sm-offset-5 col-md-5 control-label">계좌번호</label>
		      <input type="text" class="form-control" id="account" name="account" value="${user.account }" >
		  </div>
	
	<!-- 비지니스 계정으로 전환 버튼 넣기-->	
		<c:if test="${sessionScope.user.role=='user'}">  
		  <div class="form-group">
		    <label for="account" class="col-sm-offset-5 col-md-5 control-label">비지니스</label>
		    <button type="button" class="upgrade_btn" >비지니스전환</button>
		  </div>
		  </c:if>

			<div class="form-group">		 
		      <button type="button" class="button btn btn-primary"  >수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button" data-toggle="modal" data-target="#deleteCheck">탈 &nbsp;퇴</a>
				
				
		<!--회원탈퇴 모달 확인창-->
						<div class="modal fade" id="deleteCheck"  role="dialog" >
						  <div class="modal-dialog modal-notify modal-warning" role="document">
						    <!--Content-->
						    <div class="modal-content">				
						      <!--프로필-->
						      <div class="modal-header text-center">
							<h4 class="modal-title white-text w-100 font-weight-bold py-2">Subscribe</h4>
							 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true" class="white-text">&times;</span>
						        </button>
						      </div>
						      <!--Body-->
						      <div class="modal-body text-center mb-1">
				       
						        <div class="md-form ml-0 mr-0">
						          <input type="password" type="text" id="form29" class="form-control form-control-sm validate ml-0">
						          <label data-error="wrong" data-success="right" for="form29" class="ml-0">Enter password</label>
						        </div>
						
						        <div class="modal-footer justify-content-center">
        							<a type="button" class="btn btn-outline-warning waves-effect">탈퇴 <i class="fas fa-paper-plane-o ml-1"></i></a>
     							 </div>
						      </div>
						
						    </div>
						    <!--/.Content-->
						  </div>
						</div>
						<!--Modal: Login with Avatar Form-->
		  </div>
		  </div>
		  </div>
		  </div>
		  
	</div>
	</div>
	</div>
	</div>
	</form>
	</div>
	
	


</body>
</html>