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
	
		<!--  태그 사용 -->
 	<script src="/VIG/javascript/jquery.tagsinput-revisited.js"></script>
	
	<link rel="stylesheet" href="/VIG/css/jquery.tagsinput-revisited.css">
 	
 	<!--  drag and drop -->
 	<script src="/VIG/javascript/dropify.js"></script>
 	<link rel="stylesheet" href="/VIG/css/dropify.min.css">
 	<link rel="stylesheet" href="/VIG/fonts/dropify.woff">
 	<link rel="stylesheet" href="/VIG/fonts/dropify.ttf">
 	
 	<!-- crop -->	
 	<script src="/VIG/javascript/jquery.Jcrop.js"></script>
 	<link rel="stylesheet" href="/VIG/css/jquery.Jcrop.css"  type="text/css" />
 	<link rel="stylesheet" href="/VIG/css/jquery.Jcrop.min.css"  type="text/css" />
 	
 	<!-- crop2 -->
 	<script src="/VIG/javascript/cropper.min.js"></script>
 	<link rel="stylesheet" href="/VIG/css/cropper.min.css"  type="text/css" />
 	<!-- select -->
 	<script src="/VIG/javascript/justselect.min.js"></script>
 	<link rel="stylesheet" href="/VIG/css/justselect.css" >
 	
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	


	
<style>
	
	
	body{
	   
	}
	
	#target{
	display : block;  
	
	max-width : 100%; 
	
	}
		
	#feedend{
		 position:absolute;
		 bottom : -400px;	
	}
	
	#main { 
		width: 1000px;
		margin: 100px ;
	}
	
	#side{
		position:relative;
		margin: 110px ;
			
	}
	
	#thumbnail{
		background-color: #333333 !important;
	}
	
	.jcrop-holder #preview-pane {
  display: block;
  position: absolute;
  z-index: 2000;
  top: 10px;
  right: -280px;
  padding: 6px;
  border: 1px rgba(0,0,0,.4) solid;
  background-color: white;

  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  border-radius: 6px;

  -webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
  box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
}

#preview-pane .preview-container {
  width: 250px;
  height: 170px;
  overflow: hidden;
}
	
	
</style>
<script type="text/javascript">
//업로드 
$(function() {
	$( "#feedend" ).on("click" , function() {
		document.myform.action='addFeed';
		document.myform.submit();
	});
});


//이미지 파일 유효성검사
function fileCheck(el) { 
    if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
        alert('이미지 파일만 업로드 가능합니다.'); 
        el.value = ''; 
        el.focus(); 
        
    }
}
//태그 처리
$(function (){

	
	$('#keyword').tagsInput({
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
</script>

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
			 document.querySelector('#target').src = reader.result;
			     		
			    
			
			 const image = document.getElementById('target');
			 const cropper = new Cropper(image, {
			   aspectRatio: 4 / 3,
			   viewMode: 3,
			   modal:true,
			   guides:true,
			   background:true,
			   
			   crop(event) {
			     console.log(event.detail.x);
			     console.log(event.detail.y);
			     console.log(event.detail.width);
			     console.log(event.detail.height);
			     console.log(event.detail.rotate);
			     console.log(event.detail.scaleX);
			     console.log(event.detail.scaleY);
			     console.log(cropper);
			     
			     cropper.getCroppedCanvas();
			     console.log(cropper);
			   },
			  
			   
					


		
			   
			   
			 });
			 
			 
		
	};
		
	
  });
});


</script>

<script>
//DIV 동적추가 제거
var arrInput = new Array(0);
  var arrInputValue = new Array(0);
 
function addInput() {
  arrInput.push(arrInput.length);
  arrInputValue.push("");
  display();
}
 
function display() {
  document.getElementById('parah').innerHTML="";
  for (intI=0;intI<arrInput.length;intI++) {
    document.getElementById('parah').innerHTML+=createInput(arrInput[intI], arrInputValue[intI]);
  }
}

function createInput(id) {
	$(function (){
		$('.dropify').dropify();
		
		});
	return  "<input type='file' id='demo"+id+"' class='dropify' name='uploadFile' accept='image/*' onchange='fileCheck(this)' data-height='400'><hr>";
	
	}
	
function deleteInput() {
	  if (arrInput.length > 0) { 
	     arrInput.pop(); 
	     arrInputValue.pop();
	  }
	  display(); 
	}
	
	
	
	//닉네임검색 자동검색 !!
	function getkeywords() {
		
		
		$.ajax("/VIG/search/json/getSearchKeyword",
		  {
			method : "POST",
			dataType : "Json",							
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data :  JSON.stringify({keyword : $("#test123").val(), mode : "Writer" }),						
			success : function(JSONData, status) {
				//검색 결과가 있으면 처리			
				if(JSONData.length != 0){
					
						console.log( JSONData );
					
					 	$("#test123").autocomplete({			 		
					        source: JSONData
					    });		
				}
			}							
		});
	}
	
	//자동검색
	$(function(){	
	$("#test123").on("keyup", function(){				
				if($("#test123").val().length >= 1){
					getkeywords();
					console.log("dd");
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


	<!-- 툴바  -->
	<jsp:include page="../main/toolbar.jsp" />
	<!--  툴바 -->
	
	
	<form class="myform" enctype="multipart/form-data" name="myform" method="post">
	<div class="container-fluid">
	
	
		<div class="row">
			
				<div class ="col-md-8" >
				<div id="main">
				<h1><strong> Feed Creation </strong></h1>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg" id="thumbnail">Create Thumbnail</button>
	
				
	
	<div class="md-form form-lg">
		   <input type="text" id="inputLGEx" class="form-control form-control-lg" name="feedTitle">
		   <label for="inputLGEx">Write Feed Title</label>
	</div>
	<div class="md-form">
	 	   <input type="text" id="inputMDEx" class="form-control" name="feedExplanation">
	   	   <label for="inputMDEx">Write Feed Explanation</label>
	</div>
			
		
			<div class="form-group">
					
							
							
						
			
						
		</div>
							<div id="parah"></div>
							<input type="button" value="추가" onclick="addInput();" />
<input type="button" value="삭제" onclick="deleteInput();"/>
							<div class="md-form md-bg">
							<input name='keyword' value='' placeholder="Please enter your tags" class="form-control" id="keyword">
							
							</div>
							
							<div class="md-form md-bg input-with-pre-icon">
  											<i class="fas fa-user input-prefix"></i>
  														<input type="text" id="test123" class="form-control" placeholder="Please enter a collaborator" name="joinUser">
 									 <label for="prefixInside4"> </label>
 									  
 									
										</div>
									
											
 									 </div>	
 									 </div>
 									 	<div class="col-md-4">
 									 	<div id="side">
 									 	<div>
									<select class="justselect" name="categoryId">
  									<option  selected="selected" value="">Category</option>
  									<option  value="10000">일러스트레이션</option>
  									<option  value="10001">그래픽디자인</option>
  									<option  value="10002">건축</option>
  									<option  value="10003">제품디자인</option>
  									<option  value="10004">패션</option>
  									<option  value="10005">광고</option>
  									<option  value="10006">포토그래피</option>
  									<option  value="10007">미술</option>
  									<option  value="10008">게임디자인</option>
  									<option  value="10009">공예</option>
  									<option  value="10010">타이포그래피</option>
  									<option  value="10011">UI/UX</option>
  									
									</select>
									
									</div>
									<br>
									<!-- Default inline 1-->
									<strong>commentRange</strong>
					<div>
							<div class="custom-control custom-radio custom-control-inline">
  							<input type="radio" class="custom-control-input" id="defaultInline1" name="commentRange" checked="checked" value="0">
  							<label class="custom-control-label" for="defaultInline1">All</label>
							</div>
				<br>
									<!-- Default inline 2-->
							<div class="custom-control custom-radio custom-control-inline">
 							 <input type="radio" class="custom-control-input" id="defaultInline2" name="commentRange" value="1">
 							 <label class="custom-control-label" for="defaultInline2">Follower</label>
							</div>
				<br>

									<!-- Default inline 3-->
							<div class="custom-control custom-radio custom-control-inline">
  							<input type="radio" class="custom-control-input" id="defaultInline3" name="commentRange" value="2">
 							 <label class="custom-control-label" for="defaultInline3">Disabled</label>
							</div>

				</div>
				<hr>
				<hr>
				<strong>UseGears</strong>
		<div class="form-group">
  <label for="exampleFormControlTextarea2"></label>
  <textarea class="form-control rounded-0" id="feedUseGears" rows="3" name="feedUseGears"></textarea>
</div>
		
<hr>
<hr>
					<c:if test="${sessionScope.user.role=='business'}">
							<strong>isPrimeFeed</strong>
		<div>
		
		<div class="custom-control custom-radio custom-control-inline">
  							<input type="radio" class="custom-control-input" id="defaultInline4" name="feedIsPrime" checked="checked" value="0">
  							<label class="custom-control-label" for="defaultInline4">Feed</label>
							</div>
							
		<div class="custom-control custom-radio custom-control-inline">
  							<input type="radio" class="custom-control-input" id="defaultInline5" name="feedIsPrime" value="1">
  							<label class="custom-control-label" for="defaultInline5">PrimeFeed</label>
							</div>
		</div>
		</c:if>
		
		
		
		<button type="button" class="btn btn-info" id="feedend">UpLoad</button>
 										</div>
 										
 									 </div>
 											</div>
 										</div>
							
						
				
				<div class="row">
				
 												
				
							
		
	

	</div>
	
	
	

	
	
	
	
	
	<!-- 모달시작 -->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="thumbnailModal">
 	 <div class="modal-dialog modal-lg">
    		<div class="modal-content">
    											<div>
													 <strong>썸네일 크기는 4:3으로 업로드 해주세요.</strong>
													<input type='file' class='dropify' name='uploadFile' accept='image/*' onchange='fileCheck(this)' data-height='400'>
													<button type="button" class="btn btn-elegant" data-dismiss="modal">완료</button>
													</div>
													
 									
  					    
      
    		</div>
 	 </div>
</div>

	
	</form>
	
	<!--  모달끝 -->