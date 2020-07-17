<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
    
<html>
<head>


<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js">
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
          	canvas { border: solid 1px black; display: block; }
        }
        
    </style>
<script type="text/javascript">
var clsImage;
var iCropLeft, iCropTop, iCropWidth, iCropHeight;



$(function() {
	//DOM Object GET 3���� ���  1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button.btn.btn-primary" ).on("click" , function() {
		document.detailForm.action='testController/upload';
		document.detailForm.submit();
	});
});	


//��� �̺�Ʈ ó��+����
$(function() {
	$("a[href='#' ]").on("click" , function() {
		$("form")[0].reset();
	});
});	
//Modal 
$('#myModal').on('shown.bs.modal', function () {
	  $('#myInput').focus()
	})
//div ��������	
	function add_div(){
    var div = document.createElement('div');
    div.innerHTML = document.getElementById('room_type').innerHTML;
    document.getElementById('field').appendChild(div);
}

function remove_div(obj){
document.getElementById('field').removeChild(obj.parentNode);
}




	// ���� �̹��� ������ Canvas �� �ε��Ѵ�.
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
//���� �̹��� ���ϰ� Crop �� ���� �簢�� �ڽ��� �׷��ش�.
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

// �̹����� crop �Ͽ��� �ϴ� Canvas �� �׷��ش�.
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

//���콺 �̵��� ���� Crop �簢 �ڽ��� �̵��ϱ� ���� �̺�Ʈ �ڵ鷯�� ����Ѵ�.
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
</script>
</head>
<body>

<div class="container">


<h1 class="bg-primary text-center">�ǵ��ۼ�</h1>
<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data" >


<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
		    <div class="col-sm-4">
		      <input type="prodName" class="form-control" id="prodName" name="prodName" >
		      <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">����ϻ���</button>
		    </div>
		  </div>
		
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�ǵ�Ÿ��Ʋ</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="prodDetail" >
		    </div>
		  </div>
		
	<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">�ǵ峻��</label>
		    <div class="col-sm-4">
		      <input type="manuDate" class="form-control" id="manuDate" name="manuDate" >
		      <img src="../images/ct_icon_date.gif" width="15" height="15" 
							onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
		    </div>
		  </div>
		
		
	
	<input type="button" value="�����" onclick="add_div()">
	
	<div class="form-group" id="room_type">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">�ǵ��̹���</label> 
		    <div class="col-sm-4">		     
		      <input	type="file" name="uploadFile" id="uploadFile" class="form-control" />							
		    </div>
		     <input type="button" value="����" onclick="remove_div(this)">
		  </div>
		 
	<div id="field" class="form-group"></div>
	
	<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">�±�</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="prodDetail" >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">������</label>
		    <div class="col-sm-4">
		      <input type="prodDetail" class="form-control" id="prodDetail" name="prodDetail" >
		    </div>
		  </div>
		  

	


<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�Խ��ϱ�</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		  </div>
		  
		  
		  
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">����ϻ���</h4>
	      </div>
	      <div class="modal-body">
	      		<form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">����ϻ���</label>
					    <div class="col-sm-6">
					      
					      <input type='file' id='image_file' class="form-control"/>
							<input type='button' value='Load' onclick='LoadImage();' />
							<canvas id="canvas"></canvas>

							<input type='button' value='ũ�ӹ̸�����' onclick='CropImage();' />
							<canvas id="canvas_crop"></canvas>
					    </div>
					  </div>
					  
					 
			
				</form>

	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary">�Ϸ�</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">���</button>
	        
	      </div>
	    </div>
	  </div>
	</div>	

</form>
</div>
</body>
</html>