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

//jQuery===================================//

	$(function(){
		$( "button.btn.btn-block:contains('마이피드 목록')").on("click",function(){
			self.location.href="#";
		});
	});
	$(function(){
		$( "button.btn.btn-block:contains('내 활동 보기')").on("click",function(){
			self.location.href="#";
		});
	});
	$(function(){
		$( "button.btn.btn-block:contains('결 제')").on("click",function(){
			self.location.href="#";
		});
	});
	$(function(){
		$( "button.btn.btn-block:contains('통 계')").on("click",function(){
			self.location.href="#";
		});
	});

	</script>
	
<!-- style part======================== -->	
	<style>
	
		.col-md-10{
			
		}
	    .title_h1{
				padding:30px;
			}
			
			#btn_group{
			padding:30px;
			text-align: center;
			}
	.lightbox{
		padding:50;
		 width:300px;
		 height:200px;
	}

	</style>
<!-- style part end =====================-->		

</head>

<body>
		

	 	
<!-- 페이지 타이틀 ========================================== -->
			<div class="col-md-10">
						<div class="row">
							<div class="title_h1"><h1>${user.userName} 님의 마이피드</h1></div>	
	 					</div>
	 				<div class="row">
			 		<div id="btn_group">
			 			<button type="button" class="btn btn-light ml-5 mr-5">팔로워</button>
			 			<button type="button" class="btn btn-light ml-5 mr-5">팔로잉</button>
			 			<button type="button" class="btn btn-light ml-5 mr-5">채 팅</button>
			 		</div>
					</div>
	
		<div class="row">
			<figure class="col-md-3 ">
				<a herf="#" data-size="1600X1050">
				<img alt="picture" img src="https://mdbootstrap.com/img/Photos/Lightbox/Thumbnail/img%20(150).jpg"  class="lightbox"/>
				</a>
			</figure>
			
			<figure class="col-md-3 ">
				<a herf="#" data-size="1600X1050">
				<img alt="picture" img src="https://mdbootstrap.com/img/Photos/Lightbox/Thumbnail/img%20(150).jpg"  class="lightbox"/>
				</a>
			</figure>
			
			<figure class="col-md-3 ">
				<a herf="#" data-size="1600X1050">
				<img alt="picture" img src="https://mdbootstrap.com/img/Photos/Lightbox/Thumbnail/img%20(150).jpg"  class="lightbox"/>
				</a>
			</figure>
 
 			</div>
					</div>

</body>
</html>
