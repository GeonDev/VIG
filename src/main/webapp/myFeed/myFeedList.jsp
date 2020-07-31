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
		.lightbox{
			 width:350px; height:250px;
		}		
		.container-fulid{
			padding-right:50px; padding-left:50px;
		}
		.row.1{
			margin: 50px;
		}
		.col-md-10{
			margin: auto;
		}
	    .title_h1{
			padding:30px;
		}
		#btn_group{
			margin: auto; text-align: center;
		}
		.lightbox{
			padding:50; width:300px; height:200px;
		}
	</style>

</head>
<body>
	 	
		<!-- 페이지 타이틀 ========================================== -->
			<div class="col-md-10">
						<div class="row 1">
							<div class="title_h1"><h1>${user.userName} 님의 마이피드</h1></div>	
	 					</div>
	 					<hr/>
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

		<!-- 모달창 -->		
						
				<div class="modal fade" id="theModal" role="dialog" >
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header text-center">
				        <h4 class="modal-title w-100 font-weight-bold">follower</h4>		
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body"> 
				     ㅁㅁㅁㅁㅁㅁㅁ
				      
				       </div>
				      <div class="modal-footer d-flex justify-content-center">
				        <button type="button" class="btn btn-deep-orange" data-dismiss="modal" aria-label="Close">확인</button>
				      </div>
				    </div>
				  </div>
				</div>
				
		
		<!-- 피드 리스트 -->				
			
	</div>


</body>
</html>
