<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>VIG</title>

<!-- JQuery -->
	
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
 	<script src="/javascript/jquery.tagsinput-revisited.js"></script>
	
	<link rel="stylesheet" href="/css/jquery.tagsinput-revisited.css">

	
<style>
	body {
		
		margin-top: 70px;
		
		}
	
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


$(function(){
	
	$("button:contains('수정')").on('click', function(){
		
		$(".myform").attr("method", "post").attr("action", "/event/updateEvent").attr( "enctype","multipart/form-data").submit();
			
	});
	
	
});

//태그
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
	<jsp:include page="../mainView/toolbar.jsp" />

	
	<form class="myform" enctype="multipart/form-data">
	<div id="outline">
		<div id=main>
		
			<div class="row" >
					<div class="col-8" style="padding-right: 20px;">
						<h2 style="font-weight: bold;">  이벤트 수정 </h2>
						
						<div class="md-form form-lg">
						  <input type="text" id="inputLGEx" class="form-control form-control-lg" name="eventTitle" value="${event.eventTitle}">
						  <input type="hidden" name="eventId" value="${event.eventId }">
						</div>
						
						<!-- Medium input -->
						<div class="md-form">
						  <input type="text" id="inputMDEx" class="form-control" name="eventSub" value="${event.eventSub}">
						</div>
						
						<div class="form-check">
						  <input type="radio" class="form-check-input" id="materialChecked2" name="eventType" value="0" ${fn:contains(event.eventType, 'false')? "checked" : "" }>
						  <label class="form-check-label" for="materialChecked2">이벤트</label>
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   <input type="radio" class="form-check-input" id="materialChecked2" name="eventType" value="1" ${fn:contains(event.eventType, 'true')? "checked" : "" }>
						  <label class="form-check-label" for="materialChecked2">당첨자 발표</label>
						</div>

	
	

	
	
	<hr/>
		<input type="file" id="demo" name="uploadFile" class="dropify"  data-default-file="/images/others/${event.eventImage }">
	
	<hr/>
	<br/>
	
		</div>
	
				<div class="col-4" style="margin-top: 30px; padding-left: 20px; border-left: 1px solid #E6E8EF ">
								<div class="info">
									<h5>태그</h5>
									<br>
									<input id="example" name="eventTags" type="text" value="${event.eventTags }">
								</div>
								<br>
								<div class="info">
									<h5>기간</h5>
									<br>		
									<input type="date" name="eventStart" value="${event.eventStart }">	
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="date" name="eventEnd" value="${event.eventEnd }">	
									</div>
								
								<br>
	
	
								<div class="info">
									<h5>썸네일</h5>
									<br>
									<input type="file" id="demo" name="uploadFile" class="dropify"  data-default-file="/images/others/${event.eventThumb }">
								</div>
								
							<br>
				
								<div class="info">
									<h5>배너</h5>
									<br>
									<input type="file" id="demo" name="uploadFile" class="dropify"  data-default-file="/images/others/${event.banner }">
								</div>
								<div >
									<button type="button" class="btn btn-dark" style="align: center;">수정</button>
								</div>
								
							<div >
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

</body>
</html>