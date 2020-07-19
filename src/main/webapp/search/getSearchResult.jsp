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
	
	
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
	
	<script type="text/javascript">

	function funcGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("action", "/reportController/getReportListFromUser");
		$("form").submit();
	}
	
	
	$(function(){		


	
	});
	
	
	</script>
		

    
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../main/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container-lg-fluid">
	
		<div class="row align-items-center justify-content-md-center">
			<div class="col-sm-10">
				<div class="input-group md-form form-sm form-1 pl-5">
				  <div class="input-group-prepend">
				    <span class="input-group-text cyan lighten-2" id="basic-text1"><i class="fas fa-search text-white"
				        aria-hidden="true"></i></span>
				  </div>
				  <input class="form-control my-0 py-1" type="text" placeholder="Search" aria-label="Search">
				</div>	
			</div>			
			
			
			<div class="col-sm-2">
				<div class="btn-group btn-group-sm" role="group" aria-label="Basic">
				  <button type="button" class="btn  btn-cyan">Feed</button>
				  <button type="button" class="btn  btn-cyan">Image</button>
				  <button type="button" class="btn  btn-cyan">Writer</button>
				</div>
			</div>
		</div>
		
		<div class="row">
		
		<hr/>
		</div>
		
		<div class="row">
		
		</div>
	
	</div>

</body>
</html>