<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>addFeed</title>

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
	
	}
	
	#outline {
	
		width: 1300px;
		margin: 0 auto;
	
	}
	
	#main { 
		
		width: 960px;
		margin: 0 auto;
		
	}
	
	img {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  border: 1px solid rgb(0, 0, 0);
	}
	
	

</style>
        
        
  
        
    
<script type="text/javascript">
var clsImage;
var iCropLeft, iCropTop, iCropWidth, iCropHeight;



$(function() {
	//DOM Object GET 3가지 방법  1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button.btn.btn-primary" ).on("click" , function() {
		document.detailForm.action='feedController/addFeed';
		document.detailForm.submit();
	});
});	


//취소 이벤트 처리+연결
$(function() {
	$("a[href='#' ]").on("click" , function() {
		$("form")[0].reset();
	});
});	
//Modal 
$('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').focus()
	})
//div 동적생성	
	function add_div(){
    var div = document.createElement('div');
    div.innerHTML = document.getElementById('room_type').innerHTML;
    document.getElementById('field').appendChild(div);
}

function remove_div(obj){
document.getElementById('field').removeChild(obj.parentNode);
}




//로컬 이미지 파일을 Canvas 에 로드한다.
function LoadImage()
	{
	
		if( typeof window.FileReader !== 'function' )
		{
			alert("FileReader is not supported");
			return;
		}

		var inputFile = document.getElementById('image_file');
		var clsFileReader = new FileReader();
		clsFileReader.onload = function(){
			clsImage = new Image();
			clsImage.onload = function(){
				var canvas = document.getElementById("canvas");
				canvas.width = clsImage.width;
				canvas.height = clsImage.height;

				iCropLeft = 100;
				iCropTop = 100;
				iCropWidth = clsImage.width - 200;
				iCropHeight = clsImage.height - 200;
				iImageWidth = clsImage.width;
				iImageHeight = clsImage.height;

				DrawCropRect();
				AddCropMoveEvent();
			};

			clsImage.src = clsFileReader.result;
		};

		clsFileReader.readAsDataURL(inputFile.files[0]);
	}
//로컬 이미지 파일과 Crop 을 위한 사각형 박스를 그려준다.
function DrawCropRect()
{
	var canvas = document.getElementById("canvas");
	var ctx = canvas.getContext("2d");
	
	
	ctx.drawImage( clsImage, 0, 0 );
	ctx.setLineDash([4, 2]);
	ctx.strokeStyle = "#ff0000";
	ctx.beginPath();
	ctx.rect( iCropLeft, iCropTop, iCropWidth, iCropHeight );
	ctx.stroke();
}

// 이미지를 crop 하여서 하단 Canvas 에 그려준다.
function CropImage()
{
	var canvas = document.getElementById("canvas");

	img = new Image();
	img.onload = function(){
		var canvas = document.getElementById("canvas_crop");
		canvas.width = iCropWidth;
		canvas.height = iCropHeight;
		var ctx = canvas.getContext("2d");
		ctx.drawImage( img, iCropLeft, iCropTop, iCropWidth, iCropHeight, 0, 0, iCropWidth, iCropHeight );
	};

	img.src = canvas.toDataURL();
}

//마우스 이동에 따른 Crop 사각 박스을 이동하기 위한 이벤트 핸들러를 등록한다.
function AddCropMoveEvent()
{
	var canvas = document.getElementById("canvas");
	var bDrag = false;
	var iOldX, iOldY;
	var iCropLeftOld, iCropTopOld;

	canvas.onmousedown = function(e){
		bDrag = true;
		iOldX = e.clientX;
		iOldY = e.clientY;
		iCropLeftOld = iCropLeft;
		iCropTopOld = iCropTop;
	};

	canvas.onmousemove = function(e){
		if( bDrag == false ) return;

		var iX = e.clientX - iOldX;
		var iY = e.clientY - iOldY;

		iCropLeft = iCropLeftOld + iX;
		if( iCropLeft < 0 )
		{
			iCropLeft = 0;
		}
		else if( iCropLeft + iCropWidth > clsImage.width )
		{
			iCropLeft = clsImage.width - iCropWidth;
		}

		iCropTop = iCropTopOld + iY;
		if( iCropTop < 0 )
		{
			iCropTop = 0;
		}
		else if( iCropTop + iCropHeight > clsImage.height )
		{
			iCropTop = clsImage.height - iCropHeight;
		}

		DrawCropRect();
	};

	canvas.onmouseup = function(e){
		bDrag = false;
	};
}

//이미지파일 유효성체크 
function fileCheck(el) { 
    if(!/\.(jpeg|jpg|png|gif|bmp)$/i.test(el.value)){ 
        alert('이미지 파일만 업로드 가능합니다.'); 
        el.value = ''; 
        el.focus(); 
        
    }
}



//미리보기 썸네일X
$(function(){
	var file = document.querySelector('#uploadFile');

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


</script>
</head>
<body>
<!--Navbar-->
<nav class="navbar navbar-light purple lighten-4 mb-4">

  <!-- Navbar brand -->
  <a class="navbar-brand" href="#">Navbar</a>

  <!-- Collapse button -->

</nav>
<!--/.Navbar-->








<div id=main>
<form class="myform" name="detailForm" method="post" enctype="multipart/form-data" >
<h1> 피드작성TEST  
		    <div>
		      <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">썸네일생성</button>
		      <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal2">카테고리모달</button>
		    </div>
		  
</h1>

<div class="md-form form-lg">
	  <input type="text" id="feedTitle" class="form-control form-control-lg" name="feedTitle">
	  <label for="feedTitle">제목을 입력해주세요</label>
	</div>
	
	<div class="md-form">
	  <input type="text" id="feedExplanation" class="form-control" name="feedExplanation">
	  <label for="feedExplanation">설명을 입력해주세요</label>
	</div>

<input type="button" value="한장더" onclick="add_div()" class="form-control">
	<div id="room_type">
		    <div class="form-control">		     
		      <input	type="file" name="uploadFile" id="uploadFile"  />							
		    </div>
		    <img id="preview" src="" width="700" >
		     <input type="button" value="삭제" onclick="remove_div(this)" class="form-control">
		  </div>
		 
	<div id="field" class="form-group"></div>



		  
		 
		
	
	
		
		
	
	
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">태그</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="prodDetail" >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">협업자</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="prodDetail" >
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">사용장비</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="feedUseGears" >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">프라임피드여부</label>
		    <div class="col-sm-4">
		      <input type="radio"  id="prodDetail" name="feedIsPrime" checked="checked" value="0">일반
		      <input type="radio"  id="prodDetail" name="feedIsPrime" value="1">프라임
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">댓글권한</label>
		    <div class="col-sm-4">
		      <input type="radio"  id="prodDetail" name="commentRange" checked="checked" value="0">모두허용
		      <input type="radio"  id="prodDetail" name="commentRange" value="1">팔로워에게만허용
		      <input type="radio"  id="prodDetail" name="commentRange" value="2">댓글허용금지
		    </div>
		  </div>
		  

	


<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >게시하기</button>
		      <button type="button">임시저장</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		  </div>
		  
		  
		  
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document" style="max-width:100%; width:auto; display:table;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">썸네일생성</h4>
	      </div>
	      <div class="modal-body">
	      		<form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="ThumbNail" class="col-sm-4 control-label">썸네일생성</label>
					    <div class="col-sm-6">
					      
					      <input type='file' id='image_file' accept="image/*" class="form-control" name="uploadFile" onchange='fileCheck(this);LoadImage()'/>
							<canvas id="canvas"></canvas>

							<input type='button' value='크롭미리보기' onclick='CropImage();' />
							<canvas id="canvas_crop"></canvas>
					    </div>
					  </div>
					  
					 
			
				</form>

	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary">완료</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        
	      </div>
	    </div>
	  </div>
	</div>	
		<!-- Modal -->
		


</form>
</div>
</div>
</body>
</html>