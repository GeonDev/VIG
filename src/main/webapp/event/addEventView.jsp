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


	
<style>
	
	#main { 
		width: 960px;
		margin: 70px auto;
	}
	
	#preview {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  border: 1px solid rgb(0, 0, 0);
	}
	
	
	  .file-upload-wrapper
    {
        border:2px dotted #3292A2;
        width:90%;
        height:300px;
        color:#92AAB0;
        text-align:center;
        font-size:24px;
        padding-top:12px;
        margin-top:10px;
    }


</style>


<script type="text/javascript">

$(function(){
	var file = document.querySelector('#getfile');

	$(file).on('change', function() {
	  var fileList = file.files;

	  // 읽기
	  var reader = new FileReader();
	  reader.readAsDataURL(fileList[0]);


	  		//로드 한 후
		  reader.onload = function() {

		    //로컬 이미지를 보여주기
		    document.querySelector('#preview').src = reader.result;
		
		    //썸네일 이미지 생성
		    var tempImage = new Image(); //drawImage 메서드에 넣기 위해 이미지 객체화
		    tempImage.src = reader.result; //data-uri를 이미지 객체에 주입

  	};
	});	
}); 

$(function(){
	
	$("button:contains('등록')").on('click', function(){
		alert("11");
		
		$(".myform").attr("method", "post").attr("action", "./addEvent").attr( "enctype","multipart/form-data").submit();
			
	});
	
	
	
});


</script>


</head>
<body>


	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	
	
	<div id=main>
	<form class="myform" enctype="multipart/form-data">
	
	<h1> 여긴 이벤트 페이지 등록 화면~ </h1>
	<p> ${message} </p>
	
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
	
	<div class="file-upload-wrapper">
	   <input type="file" id="input-file-now-custom-2" class="file-upload"
	  data-height="500" />
	</div>
	
	<img id="preview" src="" width="700" alt="로컬에 있는 이미지가 보여지는 영역">
		
		<input type="file" id="getfile" name="uploadFile" accept="image/*">
	
	<hr/>
	<br/>
	
	<table>
		<tr>
			<td>
				태그  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				<input type="text" size="70" name="eventTags">
			</td>
		</tr>
		<tr>
			<td>
				기간  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				<input type="date" name="eventStart" >	
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="date" name="eventEnd" >	
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
	<button type="button" class="btn btn-info">등록</button>
	
	</div>
	

</body>
</html>