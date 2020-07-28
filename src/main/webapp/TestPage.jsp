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
		
		function fncUpdateUser() {
			$("form").attr("method" , "POST").attr("action" , "/user/updateUser").submit();
		}
		
		function fncUpdateUser() {
			var name=$("input[name='userName']").val();
			
			if(name == null || name.length <1){
				alert("이름은  반드시 입력하셔야 합니다.");
				return;
			}
			
			$("form").attr("method" , "POST").attr("action" , "/user/updateUser").submit();
		}
		
		
		$( function(){
		$(document).ready(function(){
			$.ajax( 
					{
						url : "/user/json/getUser/"+userCode ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(user) {
							var displayValue ='';
							var displayValue = 
							"<div class='form-group row'>"+
						    "<label for='userName' class='col-md-5 col-form-label'></label>"+
						    "<div class='col-sm-10'>"+
						    "<input type='text' class='form-control' name='userName' id='userName' value="+${user.userName}+">"+
						    "</div></div>";													

						}
				});
		
		
		
		
		

		$( function(){
			$("#update_btn").on("click",function(){
				alert("업뎃?");
				self.location="../user/updateUser.jsp"
			});
		});
		
		$(function(){
			$("#back").on("click",function(){
				alert("history-1")
			});
		});
		
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

		  	};
			});	
		

		</script>
		
		
		<style>
		.col-md-12{
			padding: 100px 70px 70px;
		}
		.col-md-10{
			padding: 20px auto;
		}
		#preview{
			display:block;
			margin-left:auto;
			margin-right:auto;
			width: auto; height: auto;
		    max-width: 300px;
		    max-height: 200px;
		    border-radius:100%;
		    position: relative; 
		    z-index: 2;
		    }
		   #getfile{
		   padding: auto;
		   }
		    .uuu{
		    margin:0;
		    padding:0;
		    margin-left:auto;
			margin-right:auto;
			position:relative;
		    }
		   #imgUpdate{
		    position: absolute;
		    top:0;
		    left:0;
		    }
		    
		    #update{
		    position: absolute;
		    top:0;
		    left:0;
		    }
		  hr {
			  height: 2px;
			  background-color: gray;
			}
			.infoList{					
			margin: 70px auto;
			width: auto; 
			height: auto;
			max-width: 300px;
			max-height: 200px;
			}
			#userInfo.1{
			padding: auto;
			}
			.infoList{
				margin: auto;
			}
			.userInfo{
			text-align: center;
			}
			.btn_1{
			margin:auto;			
			}
			#sns_nav{
		   display:flex;
		   margin-left:auto;
			margin-right:auto;
			flex-direction: row;
			justify-content: center;
		   }
			}
			.btn.btn-elegant{
			display:block;
			margin-left:auto;
			margin-right:auto;
			}
		</style>
		
</head>
<body>

<form>

<div class="container">

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
 				
 					<div class="input-group">
					  <div class="input-group-prepend">
					    <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
					  </div>
					  <div class="custom-file">
					    <input type="file" class="custom-file-input" id="getfile"
					      aria-describedby="inputGroupFileAddon01">
					    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
					  </div>
					</div>
					
 				<img id="preview" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg"  alt="profile_img">
 				</div>
 				
 				
 					<input type="file" id="getfile" name="uploadFile" accept="image/*">
 				
 				<br/>
 	<!-- 내 정보 보기 -->
 	<div class="row">
 			<div class="infoList">
 				<div class="list-group">
 							
 							1:${user.role}
 							2:${session.role}
 							3:${sessionScope.role}
 							4:${sessionScope }
 					  <div class="form-group row">
 				 <!-- Default input -->
				    <label for="userCode" class="col-sm-5 col-form-label">userCode</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="userCode" value="${user.userCode}" readonly="readonly">
				    </div>
				  </div> 	
				  				
 					 <div class="form-group row">
 				 <!-- Default input -->
				    <label for="userName" class="col-md-5 col-form-label">userName</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" name="userName" id="userName" value="${user.userName}">
				    </div>
				  </div>
				  
				  
				  <div class="form-group row">
				  <label for="self introduce">self introduce</label>
					  <input type="text" class="form-control" 
					  	width="120" height="50" name="selfIntroduce" id="selfIntroduce" value=" ${user.selfIntroduce}">
					</div> 
					
					
				  	 <div class="form-group row">
				 <!-- Default input -->
				    <label for="account" class="col-sm-5 col-form-label">account</label>
				    <div class="col-sm-10">
				      <input type="text" name="account" class="form-control" id="account" value="${user.account}">
				    </div>
				  </div>	
				  
				  
				   <div class="form-group row">
				  <button  class="btn" id="state_btn" name="state" value="1"> 비지니스</button>
				  </div>
				  			 
 					 <div class="userInfo">Member Since : ${user.regDate}</div>
 				</div>    
 			</div>
 		</div>	
	</div>
	
	<div class="row">
 			
			<div class="row" id="sns_nav">
 					<a href="#"><i class="fab fa-facebook-f fa-lg blue-text ml-3 mr-3 fa-1x"></i></a>
 					<a href="#"><i class="fab fa-twitter fa-lg blue-text ml-3 mr-3  fa-1x"></i></a>
 					<a href="#"><i class="fab fa-instagram fa-lg blue-text ml-3 mr-3 fa-1x"></i></a>
 			</div>
 			

 	<div class="btn_1">
 	<button  class="btn btn-elegant" id="update_btn" >수정완료</button>
 	<button  class="btn btn-elegant" id="back" >취소</button>
	</div>
	
		</div>
	</div>
</div>
</div>
</form>
</body>
</html>