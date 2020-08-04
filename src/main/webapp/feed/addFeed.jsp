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
 	<link rel="stylesheet" href="/VIG/fonts/dropify.woff">
 	<link rel="stylesheet" href="/VIG/fonts/dropify.ttf">
 	<!-- crop -->
 	<script src="/VIG/javascript/pixelarity-face.js"></script>
 	
 	<link rel="stylesheet" href="/VIG/css/pixelarity.css">
 	
 	
 	
 	<script src="/VIG/javascript/rcrop.min.js"></script>
 	<link rel="stylesheet" href="/VIG/css/rcrop.min.css">
 	
 	<script src="/VIG/javascript/jquery.Jcrop.js"></script>
 	<link rel="stylesheet" href="/VIG/css/jquery.Jcrop.css"  type="text/css" />
 	<link rel="stylesheet" href="/VIG/css/jquery.Jcrop.min.css"  type="text/css" />
 	<!-- check Box -->
 	<script src="/VIG/javascript/justselect.min.js"></script>
 	<link rel="stylesheet" href="/VIG/css/justselect.css" >
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
		margin: 110px ;
			
	}
	#categoryList{
		float:right;
		
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
			   
			   var jcrop_api,
		        boundx,
		        boundy,
		        
		        $preview = $('#preview-pane'),
		        $pcnt = $('#preview-pane .preview-container'),
		        $pimg = $('#preview-pane .preview-container img'), 
			    
		        xsize = $pcnt.width(),
		        ysize = $pcnt.height();
			   
			   

				$('#target').Jcrop({
					
		            bgColor:     'black',
		            bgOpacity:   .4,
				onChange: updatePreview,
				onSelect: updatePreview,
				aspectRatio: 4/3 
				},function(){
				console.log(200);
			      // Use the API to get the real image size
			      var bounds = this.getBounds();
			      boundx = bounds[0];
			      boundy = bounds[1];
			      // Store the API in the jcrop_api variable
			      jcrop_api = this;

			      // Move the preview into the jcrop container for css positioning
			      $preview.appendTo(jcrop_api.ui.holder);
			    });
			    
				
				function updatePreview(c)
		  	    {
		  			
		  	      if (parseInt(c.w) > 0)
		  	      {
		  	        var rx = xsize / c.w;
		  	        var ry = ysize / c.h;

		  	        $pimg.css({
		  	          width: Math.round(rx * boundx) + 'px',
		  	          height: Math.round(ry * boundy) + 'px',
		  	          marginLeft: '-' + Math.round(rx * c.x) + 'px',
		  	          marginTop: '-' + Math.round(ry * c.y) + 'px'
		  	        });
		  	      };
		  	    };
			    
		  		};
		  		
		  		
			    
		
	});
	
	
	
	
	
	
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
			
		
			<div class="form-group">
					<input type="file" id="demo" class="dropify" name="uploadFile" accept="image/*" onchange='fileCheck(this)'>
							
							
						
			
						
		</div>
							
							
							<div class="md-form md-bg">
							<input name='keyword' value='' placeholder="Please enter your tags" class="form-control">
							
							</div>
							
							<div class="md-form md-bg input-with-pre-icon">
  											<i class="fas fa-user input-prefix"></i>
  														<input type="text" id="prefixInside4" class="form-control" placeholder="Please enter a collaborator">
 									 <label for="prefixInside4"> </label>
 									  
 									
										</div>
									<select class="justselect">
  <option selected="selected" value="jquery">카테고리</option>
  <option name="category" value="css">CSS3</option>
  <option name="category" value="html">HTML5</option>
</select>
											
 									 </div>		
 										<div id= "side" >
 											
 										</div>		
							</div>
						
				
				<div class="row">
				
				<div class="col-md-4" >
				
							
		</div>
	

	</div>
	
	</div>
	

	
	
	
	
	
	<!-- 모달시작 -->
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="thumbnailModal">
 	 <div class="modal-dialog modal-lg">
    		<div class="modal-content">
    					<div>
													 <img id="target" src="" width="700" alt="로컬에 있는 이미지가 보여지는 영역">
													<input type="file" id="getfile" accept="image/*">
													
													</div>
													<div id="preview-pane">
   												 <div class="preview-container">
    									  <img src="" class="jcrop-preview" alt="Preview" />
    										</div>
 												 </div>
 									
  					    <button type="button" class="btn btn-elegant">Save</button>
    						
					    <button type="button" class="btn btn-elegant">Cancel</button>
      
    		</div>
 	 </div>
</div>
	</form>
	<!--  모달끝 -->