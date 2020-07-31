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
	
	<!-- Tag  -->
	<script src="/VIG/javascript/jQuery.tagify.min.js"></script>
 	<link rel="stylesheet" href="/VIG/css/tagify.css">
 	<!--  drag and drop -->
 	<script src="/VIG/javascript/dropify.js"></script>
 	<link rel="stylesheet" href="/VIG/css/dropify.min.css">
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>


	
<style>
	
	
	body{
	    
	}
	
	#main { 
		width: 1000px;
		margin: 100px ;
	}
	
	#side{
		margin: 100px ;
			
	}
	#categoryList{
		float:right;
		
	}
	#thumbnail{
		background-color: #333333 !important;
	}
	
</style>
<script type="text/javascript">

//업로드 동적생성
function add_div(){
    var div = document.createElement('div');
    div.innerHTML = document.getElementById('room_type').innerHTML;
    document.getElementById('field').appendChild(div);
}
//업로드 동적제거(This)
function remove_div(obj){

document.getElementById('field').removeChild(obj.parentNode);

}
//이미지 파일 유효성검사
function fileCheck(el) { 
    if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
        alert('이미지 파일만 업로드 가능합니다.'); 
        el.value = ''; 
        el.focus(); 
        
    }
}
//태그
	$(function (){
		var input = document.querySelector('input[name=keyword]');
		new Tagify(input)
	});

//drag and drop
$(function (){
	$('.dropify').dropify();
	});
</script>






</head>
<body>


	<!-- 툴바  -->
	<jsp:include page="../main/toolbar.jsp" />
	<!--  툴바 -->
	
	
	<form class="myform" enctype="multipart/form-data">
	<div class="container-fluid">
	
	
		<div class="row">
			
				<div class ="col-md-8" id="main">
				<h1><strong> Feed Creation </strong></h1>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg" id="thumbnail">Create Thumbnail</button>
	
				<i class="fas fa-align-justify" id='categoryList'></i>
	
	<div class="md-form form-lg">
		   <input type="text" id="inputLGEx" class="form-control form-control-lg" name="feedTitle">
		   <label for="inputLGEx">Write Feed Title</label>
	</div>
	<div class="md-form">
	 	   <input type="text" id="inputMDEx" class="form-control" name="feedExplanation">
	   	   <label for="inputMDEx">Write Feed Explanation</label>
	</div>
			
		<div id="room_type">
			<div class="form-group">
					
						<input type="file" id="title" name="uploadFile" class="form-control" accept="image/*" onchange='fileCheck(this)'></input>
			</div>
						<input type="button" value="삭제" onclick="remove_div(this)">
		</div>
							<div id="field"></div>
							<input type="file" id="demo" class="dropify">
							<div class="md-form md-bg">
							<input name='keyword' value='' placeholder="Please enter your tags" class="form-control">
							
							</div>
							
							<div class="md-form md-bg input-with-pre-icon">
  											<i class="fas fa-user input-prefix"></i>
  														<input type="text" id="prefixInside4" class="form-control" placeholder="Please enter a collaborator">
 									 <label for="prefixInside4"> </label>
							</div>
							
				</div>
				<div class="row">
				
				<div class="col-md-4" id="side">
				
	<div>
	
	<span class="fas fa-cloud-upload-alt">
	<input type="button" onclick="add_div()">
	
	</span>
	</div>
	
		</div>
	

	</div>
	</div>
	
	</div>
	
	
	
	
	
	<!-- 모달시작 -->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="thumbnailModal">
 	 <div class="modal-dialog modal-lg">
    		<div class="modal-content">
    
  					    <button type="button" class="btn btn-elegant">Save</button>
    
					    <button type="button" class="btn btn-elegant">Cancel</button>
      
    		</div>
 	 </div>
</div>
	</form>
	<!--  모달끝 -->