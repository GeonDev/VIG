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

	
<style>
	body {
		
		margin-top: 70px;
		
		}
	
	#main { 
		width: 960px;
		margin: 0 auto;
	}
	
	#preview {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  border: 1px solid rgb(0, 0, 0);
	}


</style>


<script type="text/javascript">

$(function(){
	var file = document.querySelector('#getfile');

	$(file).on('change', function() {
	  var fileList = file.files;
		console.log("1");
	  // 읽기
	  var reader = new FileReader();
	  reader.readAsDataURL(fileList[0]);
	  console.log("2");

	  		//로드 한 후
		  reader.onload = function() {
			  console.log("3");
		    //로컬 이미지를 보여주기
		    document.querySelector('#preview').src = reader.result;
		
		    //썸네일 이미지 생성
		    var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
		    tempImage.src = reader.result; //data-uri를 이미지 객체에 주입

  	};
	});	
});

$(function(){
	
	$("#update").on('click', function(){
		alert("11");
		
		$(".myform").attr("method", "post").attr("action", "./updateEvent").attr( "enctype","multipart/form-data").submit();
			
	});
	
	
});


</script>


</head>
<body>

	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	
	
	<div id=main>
	<form class="myform" enctype="multipart/form-data">
	
	<h2 style="font-weight: bold;">  이벤트 수정 </h2>
	
	<div class="md-form form-lg">
	  <input type="text" id="inputLGEx" class="form-control form-control-lg" name="eventTitle" value="${event.eventTitle}">
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
	<img id="preview" src="/VIG/images/others/${event.eventImage}" width="700" alt="로컬에 있는 이미지가 보여지는 영역">
		
		<input type="file" id="getfile" name="uploadFile" accept="image/*">
	
	<hr/>
	<br/>
	
	<table>
		<tr>
			<td>
				태그  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				<input type="text" name="eventTags" size="70" value="${event.eventTags }">
			</td>
		</tr>
		<tr>
			<td>
				기간  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				<input type="date" name="eventStart" value="${event.eventStart }">	
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="date" name="eventEnd" value="${event.eventEnd }">	
			</td>
		</tr>
	</table>
	
	
	<table>
		<tr>
			<td>
				썸네일  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				<input type="file" name="uploadFile" accept="image/*">
			</td>
		</tr>
		<tr>
			<td>
				배너  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				<input type="file" name="uploadFile" accept="image/*">	
			</td>
		</tr>
	</table>
		


	</form>
	<input id="update" type="button" value="수정">
	
	</div>
	

</body>
</html>