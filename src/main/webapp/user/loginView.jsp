<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

		<!-- Font Awesome -->
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
			
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
	
		$( function(){
			$("#userName").focus();
			
			$("#login_btn").on("click" ,function(){
				
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력해주세요.');
					$("input:text").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('비밀번호를 입력해주세요.');
					$("input:password").focus();
					return;
				}
			});
		});
	
	</script>

</head>
<body>

					<div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
			  aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header text-center">
			        <h4 class="modal-title w-100 font-weight-bold">Sign in</h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body mx-3">
			        <div class="md-form mb-5">
			          <i class="fas fa-envelope prefix grey-text"></i>
			          <input type="text" id="id" name=" id" class="form-control validate">
			          <label data-error="wrong" data-success="right" for="defaultForm-email">Your id</label>
			        </div>
			
			        <div class="md-form mb-4">
			          <i class="fas fa-lock prefix grey-text"></i>
			          <input type="password" id="password" name="password" class="form-control validate">
			          <label data-error="wrong" data-success="right" for="defaultForm-pass">Your password</label>
			        </div>
			
			      </div>
			      <div class="modal-footer d-flex justify-content-center">
			        <button class="btn btn-default" id="login_btn">Login</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<div class="text-center">
			
			  <a href="" class="btn btn-default btn-rounded mb-4" data-toggle="modal" data-target="#modalLoginForm" >
			  <i class="fas fa-user"></i>
			  </a>
			</div>



</body>
</html>