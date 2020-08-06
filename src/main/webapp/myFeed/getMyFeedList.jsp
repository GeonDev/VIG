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
	
	<script type="text/javascript">




	</script>
	
	<style>
	
	#myFeedMain { padding: 70px;}
	
	</style>

</head>
<body>

<!-- 상단 툴바 자리 --> 															  <!-- 코드 정리하기 -->
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
		    
		    
	<!--  본문 자리 -->	      	    
		    <div class="col-md-10" id="myFeedMain">
		      2 of 3
				<div class="title_h1"><h1>${user.userName} 님의 마이피드</h1></div><hr/>
	 				<div class="row">
			 		<div id="btn_group">
			 			<div class="text-center">
			 			 <button class="btn btn-light ml-5 mr-5" data-toggle="modal" data-target="#theModal">
							   팔로워</button>
						<button class="btn btn-light ml-5 mr-5" data-toggle="modal" data-target="#theModal2">
							   팔로잉</button>
						<a type="button" class="btn btn-light ml-5 mr-5" href="#">
							   채 팅</a>
						</div>	 			
				 		</div>
		    		</div>
		     
		    
		    
			</div>
			
			</div>
	</div>



</body>
</html>
