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
		
		<style>
		@media (min-width: 768px) {
		.carousel-multi-item-2 .col-md-3 {
		float: left;
		width: 25%;
		max-width: 100%; } }
		
		.carousel-multi-item-2 .card img {
		border-radius: 2px; }
		</style>
</head>
<body>

	<!-- JQuery -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<!-- 상단 툴 바 들어갈 공간/없으면 카테고리 부분이 상단바랑 겹침 -->
		<div class="container-lg">
			<br/>
			<br/>
			<br/>		
		</div>
		
		<!--Carousel Wrapper-->
		<div class="container-lg">
		
		<div id="multi-item-example" class="carousel slide carousel-multi-item carousel-multi-item-2" data-ride="carousel">
		
		  <!--Controls-->
		  <div class="controls-top">
		    <a class="carousel-control-prev" href="#multi-item-example" data-slide="prev"><i class="fas fa-angle-left fa-3x pr-3"></i></a>
		    <a class="carousel-control-next" href="#multi-item-example" data-slide="next"><i class="fas fa-angle-right fa-3x pl-3"></i></a>
		  </div>
		  <!--/.Controls-->
		
		  <!--Slides-->
		  <div class="carousel-inner" role="listbox">
		
		    <!--First slide-->
		    <div class="carousel-item active">
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		        	 <a href="#">
			          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(38).jpg"
			            alt="Card image cap">
			         </a>
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		        	 <a href="#">
			          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(19).jpg"
			            alt="Card image cap">
			         </a>
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(42).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(8).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		    </div>
		    <!--/.First slide-->
		
		    <!--Second slide-->
		    <div class="carousel-item">
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(53).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(25).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(47).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(26).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		    </div>
		    <!--/.Second slide-->
		
		    <!--Third slide-->
		    <div class="carousel-item">
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(64).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(51).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(59).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		      <div class="col-md-3 mb-3">
		        <div class="card">
		          <img class="img-fluid" src="https://mdbootstrap.com/img/Photos/Horizontal/Nature/4-col/img%20(63).jpg"
		            alt="Card image cap">
		        </div>
		      </div>
		
		    </div>
		    <!--/.Third slide-->
		
		  </div>
		  <!--/.Slides-->
		
		</div>
		<!--/.Carousel Wrapper-->


</body>
</html>