<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
		
		function fncUpdateUserInfo(){
			alert("업뎃?");
			$("form").attr("method","post").sttr("action","update").submit();
		}
		$( function(){
			#("#update_btn").on("click",function(){
				$.ajax( 
						
			});
		});

		</script>
		
		
		<style>
		.col-md-12{
			padding: 100px 70px 70px;
		}
		.col-md-10{
			padding: 20px auto;
		}
		#pImg{
			display:block;
			margin-left:auto;
			margin-right:auto;
			width: auto; height: auto;
		    max-width: 300px;
		    max-height: 300px;
		    border-radius:50%;
		    position: relative; 
		    z-index: 2;
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
			.list-group-item{
				margin: 5px;
			}
			.userInfo{
			text-align: center;
			}
			.btn_1{
			
			
			}
			.btn.btn-elegant{
			display:block;
			margin-left:auto;
			margin-right:auto;
			}
		</style>
		
</head>
<body>

<div class="container">
<div class="row">
			<jsp:include page="/main/toolbar.jsp"></jsp:include>
			</div>
	<div class="row">
		<div class="col-md-12">
		<div class="sangdan"><h1>내 정보 수정</h1></div>
		<hr/>
	<div class="row">
 			<div class="col-md-12 "> 
 	<!-- 프로필 사진 -->	
 	<div class="uuu">					
 				<div class="profile">
 				<img class="card-img-top" src="https://mdbootstrap.com/img/Photos/Avatars/img%20%2810%29.jpg" id="pImg"  alt="profile_img">
 				</div>
 				
 				</div>	
 				<br/>
 	<!-- 내 정보 보기 -->
 	<div class="row">
 			<div class="infoList">
 				<div class="list-group">
 					<div class="userInfo" >user code</div><br/>
 					 <div class="userInfo">user name</div><br/>
 					 <div class="userInfo">self introduce</div><br/>
 					 <div class="userInfo">bank name</div><br/>
 					 <div class="userInfo">account</div>
 				</div>    
 			</div>
 	</div>
 	<div class="btn_1">
 	<button  class="btn btn-elegant" id="update_btn" >Edit Profile</button>
	</div>
	</div>
		</div>
	</div>
</div>
</div>

</body>
</html>