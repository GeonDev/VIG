<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/VIG/css/animate.min.css" rel="stylesheet">
   <link href="/VIG/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/VIG/javascript/bootstrap-dropdownhover.min.js"></script>
   
   	<script type="text/javascript">
   	
   	
   	$(function() {
		
   		$("button:contains('번역')").on("click", function() {
   			
   			$("form[name='TransCode']").attr("method", "POST");		
   			$("form[name='TransCode']").submit();	
   		});

   		$("button:contains('등록')").on("click", function() {
   			
   			$("form[name='fileCode']").attr("method", "POST");		
   			$("form[name='fileCode']").submit();	
   		});
   		
   		
	});   	
   	


   	</script>
   	
   	
</head>

<body>

	<div class="container">
		
	<br/>
	<br/>
	<br/>	
		
		
	<form name="TransCode" action="VIG/testController/trans" method="POST">
		<div class="row">
			<div class="col-sm-6">
		 	<input type="text" class="form-control" name="Trans" id="Transword"  placeholder="번역할 단어" >
			</div>
			<button type="button" class="btn btn-primary">번역</button>
		</div>
	
	</form>	
	
	
	<br/>
	<br/>
	<br/>
	<br/>
	<br/>
	
	
	<form name="fileCode" action="VIG/testController/upload" enctype="multipart/form-data">
		<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
		<div class="col-xs-8 col-md-4">
			<input type="file" class="form-control" name="uploadFile" placeholder="상품명 입력"  multiple/>
		</div>
		<button type="button" class="btn btn-primary">등록</button>	 
		</div>
	
	</form>	
		

	 
	 </div>	
	
</body>

</html>