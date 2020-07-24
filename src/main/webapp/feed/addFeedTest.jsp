<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<html>
<head>


<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js">
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
          	canvas { border: solid 1px black; display: block; }
        }
        </style>
        <style>
    * {
        margin: 0;
        padding: 0;
        list-style: none;
    }

    ul {
        padding: 16px 0;
    }

    ul li {
        display: inline-block;
        margin: 0 5px;
        font-size: 14px;
        letter-spacing: -.5px;
    }
    
    form {
        padding-top: 16px;
    }

    ul li.tag-item {
        padding: 4px 8px;
        background-color: #777;
        color: #000;
    }

    .tag-item:hover {
        background-color: #262626;
        color: #fff;
    }

    .del-btn {
        font-size: 12px;
        font-weight: bold;
        cursor: pointer;
        margin-left: 8px;
    }
</style>
        
  
        
    
<script type="text/javascript">
var clsImage;
var iCropLeft, iCropTop, iCropWidth, iCropHeight;
//Tag
 $(document).ready(function () {

        var tag = {};
        var counter = 0;

        // 태그를 추가한다.
        function addTag (value) {
            tag[counter] = value; // 태그를 Object 안에 추가
            counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
        }

        // 최종적으로 서버에 넘길때 tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
        function marginTag () {
            return Object.values(tag).filter(function (word) {
                return word !== "";
            });
        }
    
        // 서버에 넘기기
        $("#tag-form").on("submit", function (e) {
            var value = marginTag(); // return array
            $("#rdTag").val(value); 

            $(this).submit();
        });

        $("#tag").on("keypress", function (e) {
            var self = $(this);

            // input 에 focus 되있을 때 엔터 및 스페이스바 입력시 구동
            if (e.key === "Enter" || e.keyCode == 32) {

                var tagValue = self.val(); // 값 가져오기

                // 값이 없으면 동작 ㄴㄴ
                if (tagValue !== "") {

                    // 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
                    var result = Object.values(tag).filter(function (word) {
                        return word === tagValue;
                    })
                
                    // 태그 중복 검사
                    if (result.length == 0) { 
                        $("#tag-list").append("<li class='tag-item'>"+tagValue+"<span class='del-btn' idx='"+counter+"'>x</span></li>");
                        addTag(tagValue);
                        self.val("");
                    } else {
                        alert("태그값이 중복됩니다.");
                    }
                }
                e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
            }
        });

        // 삭제 버튼 
        // 삭제 버튼은 비동기적 생성이므로 document 최초 생성시가 아닌 검색을 통해 이벤트를 구현시킨다.
        $(document).on("click", ".del-btn", function (e) {
            var index = $(this).attr("idx");
            tag[index] = "";
            $(this).parent().remove();
        });
})
//Tag


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






</script>
</head>
<body>

<div class="container">


<h1 class="bg-primary text-center">피드작성</h1>
<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data" >





<div class="form-group">
		    <label for="ThumbNail" class="col-sm-offset-1 col-sm-3 control-label">썸네일</label>
		    <div class="col-sm-4">
		      <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">썸네일생성</button>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="category" class="col-sm-offset-1 col-sm-3 control-label">카테고리</label>
		    <div class="col-sm-4">
		      <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal2">카테고리모달</button>
		    </div>
		  </div>
		
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">피드타이틀</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="feedTitle" name="feedTitle" >
		    </div>
		  </div>
		
	<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">피드설명</label>
		    <div class="col-sm-4">
		      <input type="manuDate" class="form-control" id="feedExplanation" name="feedExplanation" >
		      
		    </div>
		  </div>
		
		
	
	<input type="button" value="한장더" onclick="add_div()">
	
	<div class="form-group" id="room_type">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">피드이미지</label> 
		    <div class="col-sm-4">		     
		      <input	type="file" name="uploadFile" id="uploadFile" class="form-control" />							
		    </div>
		     <input type="button" value="삭제" onclick="remove_div(this)">
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
		  
		  <!--  tag -->
			<div class="content">
        
            <input type="hidden" value="" name="tag" id="rdTag" />
            <button type="submit">태그등록</button>
        </form>

        <ul id="tag-list">
        </ul>

        <div>
            <input type="text" id="tag" size="7" placeholder="태그입력" />
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
</body>
</html>