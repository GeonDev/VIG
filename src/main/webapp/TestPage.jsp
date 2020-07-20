<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		#my_frame { 
		width: 1220px; 
		height: 100%
		
		}
		
		.col-md-12{
			padding:40px;
		}
		.col-md-3{
			background-color;
			height: 1000px;
			border-right: 2px solid;
		}
		#pImg{
		display:block;
		margin-left:auto;
		margin-right:auto;
		max-width:100;
		max-heigth:100;	
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
<!-- 상단 툴바 끝 =============================================== -->		

	 	<div class=" container-fluid">
 		<div class="col-md-12">
 		
<!-- 왼쪽 사이드 메뉴 시작 ========================================= -->	
 	<!-- 프로필 이미지 -->						
 		<div class="row">
 			<div class="col-md-3 "> 								
 				<img src="https://mdbootstrap.com/img/Photos/Avatars/img%20%2810%29.jpg" id="pImg" class="rounded-circle"  alt="profile_img">
 	<!-- 프로필 내용 -->
 				<div class="card-body">
 					<h4 class="user_name" align="center"> name </h4>
 					<hr>
 					<p class="user_bio" align="center"> self introduce </p>
 					<br><br/><hr/>
 					<p class="sign_date" align="center"> Member Since :: 2020.07.19</p>
 					<hr/><br/>
 			<!-- 소셜 아이콘 이미지 변경하기 -->
 					여기에 소셜 링크 아이콘 들어옴.MDB아이콘은 유료..
 					<button type="button" class="btn btn-mdb-white" href="#"></button>
 					<button type="button" class="btn btn-mdb-white" href="#"></button>
 					<button type="button" class="btn btn-mdb-white" href="#"></button>
 					<button type="button" class="btn btn-mdb-white" href="#"></button>
 					<br/><br/><hr/><br/>
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
 				 </div>						
 			</div>
<!-- 왼쪽 사이드 메뉴 끝 =============================================== -->		


<!-- 오른쪽 메인 시작 ================================================= -->		
				
				<div class="container">
						<iframe id="my_frame" frameborder="0" border="0" scrolling="no"></iframe>
				</div>
			
			
<!-- 오른쪽 메인 끝 ================================================== -->	
			</div>
		</div>
	</div>

</body>
</html>
