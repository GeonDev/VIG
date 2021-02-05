<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
	
 	<!--  drag and drop -->
 	<script src="/javascript/dropify.js"></script>
 	<link rel="stylesheet" href="/css/dropify.min.css">
 	
 	<!--  태그 사용 -->
 	<script src="/vig/javascript/jquery.tagsinput-revisited.js"></script>
	
	<link rel="stylesheet" href="/css/jquery.tagsinput-revisited.css">
	
	<!-- 알러트 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	
<style>
	
	
	#main { 
		width: 1300px;
		margin: 70px auto;
		padding: 20px auto;
	}
	
    
    .dropify-wrapper {
	
	 min-height: 600px;
     

	}
	
	.info {
	
	margin: 10px auto;
		
	}
	
	.info> .dropify-wrapper {
	
	min-width: 100px;
	min-height: 50px;
	
	}
	


</style>


<script type="text/javascript">

//등록
$(function(){
	
	$("button:contains('등록')").on('click', function(){
		
		if($("input[name='eventTitle']").val()==''){
			
			swal("제목을 입력해주세요");
			return false;
		}
		if($("input[name='eventSub']").val()==''){
			
			swal("내용을 입력해주세요");
			return false;
		}
		if($("input[name='eventTags']").val()==''){
			
			swal("태그를 입력해주세요");
			return false;
		}
		if($("input[name='eventStart']").val()==''){
					
			swal("시작일을 설정해주세요");
			return false;
		}
		if($("input[name='eventEnd']").val()==''){
			
			swal("종료일을 설정해주세요");
			return false;
		}

		$(".myform").attr("method", "post").attr("action", "./addEvent").attr( "enctype","multipart/form-data").submit();
			
	});
	
	
	
	
	
});

//태그 처리
$(function (){

	
	$('#example').tagsInput({
		'onAddTag': function(input, value) {
			console.log('tag added', input, value);
		},
		'onRemoveTag': function(input, value) {
			console.log('tag removed', input, value);
		},
		'onChange': function(input, value) {
			console.log('change triggered', input, value);
		}
	});
	

});

//drag and drop
$(function (){
	

$('.dropify').dropify();



});

</script>


</head>
<body>


	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	
	<form class="myform" enctype="multipart/form-data">
	<div id="outline">
		<div id=main>
		
			<div class="row" >
					<div class="col-8" style="padding-right: 20px;">
						<h1 style="font-weight: bold"> 이벤트 등록 </h1>
						
					
						
						<div class="md-form form-lg">
						  <input type="text" id="inputLGEx" class="form-control form-control-lg" name="eventTitle">
						  <label for="inputLGEx">제목을 입력해주세요</label>
						</div>
						
						<!-- Medium input -->
						<div class="md-form">
						  <input type="text" id="inputMDEx" class="form-control" name="eventSub">
						  <label for="inputMDEx">설명을 입력해주세요</label>
						</div>
						
						<div class="form-check">
						  <input type="radio" class="form-check-input" id="materialChecked2" name="eventType" value="0" checked>
						  <label class="form-check-label" for="materialChecked2">이벤트</label>
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   <input type="radio" class="form-check-input" id="materialChecked2" name="eventType" value="1" >
						  <label class="form-check-label" for="materialChecked2">당첨자 발표</label>
						</div>
					
						
						<hr/>
						
						<div id="field"></div>
						
						<input type="file" id="demo" name="uploadFile" class="dropify">
					
											
							
						<hr/>
						<br/>
						
						</div>
				<div class="col-4" style="margin-top: 30px; padding-left: 20px; border-left: 1px solid #E6E8EF ">
								<div class="info">
									<h5>태그</h5>
									<br>
									<input id="example" name="eventTags" type="text" value="">
								</div>
								<br>
								<div class="info">
									<h5>기간</h5>
									<br>			
									<input type="date" name="eventStart" >	
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="date" name="eventEnd" >	
								</div>
								
								<br>
					
								<div class="info">
									<h5>썸네일</h5>
									<br>
									<input type="file" id="demo" name="uploadFile" class="dropify">
								</div>
								
							<br>
								
								<div class="info">
									<h5>배너</h5>
									<br>
									<input type="file" id="demo" name="uploadFile" class="dropify">
								</div>
							<div >
								<button type="button" class="btn btn-dark" style="align: center;">등록</button>
							</div>
				</div>
			</div>
		</div>
	</div>
</form>

</body>
</html>