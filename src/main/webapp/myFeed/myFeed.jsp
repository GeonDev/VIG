<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

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
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script>

//jQuery===================================//


//각 메뉴 페이지로 navigation
	
	function nav_myFeedList(url) {
	$('#my_frame').attr('src', url);
	}	
	function nav_history(url) {
		$('#my_frame').attr('src', url);
	}
	function nav_payment(url) {
		$('#my_frame').attr('src', url);
	}
	function nav_analysis(url) {
		$('#my_frame').attr('src', url);
	}
	
	

	</script>
	
<!-- style part======================== -->	
	<style>
		
		
		.col-md-12{
			padding:40px;
		}
		.col-md-3{
			padding-right:10;
			background-color;
			height: 100%;
			border-right: 2px solid;
		}
		.card-img-top{
			padding:0;
		}
		#pImg{
			display:block;
			margin-left:auto;
			margin-right:auto;
			width: auto; height: auto;
		    max-width: 150px;
		    max-height: 150px;
		    border-radius:50%;
		}
	</style>
<!-- style part end =====================-->		

</head>

<body>
<!-- 상단 툴바 ================================================= -->
	<div class=" container-fluid">
		<div class="col-md-12">
			<div class="row">
			<jsp:include page="/main/toolbar.jsp"></jsp:include>
			</div>
		</div>
	</div>
	

 		
<!-- 왼쪽 사이드 메뉴 시작 ========================================= -->	
 	<!-- 프로필 이미지 -->						
 		<div class="row">
 			<div class="col-md-2 "> 							
 				<img class="card-img-top" src="https://mdbootstrap.com/img/Photos/Avatars/img%20%2810%29.jpg" id="pImg"  alt="profile_img">
 	<!-- 프로필 내용 -->
 				<div class="card-body">
 					<h4 class="user_name" align="center"> name </h4>
 					<hr>
 					<p class="user_bio" align="center"> self introduce </p>
 					<br><br/><hr/>
 					<p class="sign_date" align="center"> Member Since :: 2020.07.19</p>
 					<hr/><br/>
 			<!-- 소셜 아이콘 이미지 변경하기 -->
 					여기에 소셜 링크 아이콘 들어옴.
 					<p>MDB아이콘은 유료..</p>
 					<button type="button" class="btn btn-mdb-white btn-sm" href="#"></button>
 					<button type="button" class="btn btn-mdb-white btn-sm" href="#"></button>
 					<button type="button" class="btn btn-mdb-white btn-sm" href="#"></button>
 					<br/><br/><hr/><br/>
 				</div>
 	<!-- 메뉴 네비게이션 -->
 					<button type="button" class="btn btn-block" onclick='nav_myFeedList("myFeedList.jsp")'>
 						마이피드 목록</button>
 					<br/>
 					<button type="button" class="btn btn-block" onclick='nav_history("history.jsp")'>
 						<a href="#">내 활동 보기</a></button>
 					 <br/>
 					<button type="button" class="btn btn-block" onclick='nav_payment("follow.jsp")'>
 						<a href="#">결 제</a></button>
 					<br/>
 					<button type="button" class="btn btn-block" onclick='nav_analysis(".jsp")'>
 						<a href="#">통 계</a></button>	
 
<!-- 일단 관리자용 신고 네비 여기다 표시 -->			
 			<c:choose>
 				<c:when test="${ user.role == 'admin' })">
 					<button type="button" class="btn btn-block" onclick='nav_payment("follow.jsp")'>
 						<a href="#">신 고</a></button>
 				</c:when>
 			</c:choose>
 		
 					<br/>						
 			</div>
	


<!-- 오른쪽 메인 시작 ================================================= -->		
				
			
	
			</div>
		</div>
	</div>

</body>
</html>
