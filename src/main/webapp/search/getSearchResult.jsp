<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">		
		
	<!-- JQuery -->	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	

	
	<style>
	body {
        padding-top : 50px;
        }        
        
    .img_image {
	    width: auto; height: auto;
	    max-width: 600px;
	    max-height: 300px;	  
		}
		
	.img_feed {	  
	    max-width: 400px;
	    max-height: 300px;	
		}
		
	.view {	  
	margin: 5px 10px;
		}
        

    </style>
	
	<script type="text/javascript">
	
	//최초 입장시 모드 지정
	var Mode = 'Feed';
	
	//최초 페이지는 0으로 설정
	var page = 0; 	
	
	//페이지의 끝인지 체크
	var isPageEnd = false;
	
	function getItemList() {
		
		if(isPageEnd == true){
			//페이지의 끝이라면 실행안함
			return;
		}		
		page += 1;
		console.log(page);		
		
		
		$.ajax( 
				{
					url : "/VIG/searchController/json/getSearchResultList",
					method : "POST",
					dataType : "Json",
					async: false,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data :  JSON.stringify({keyword : $("#Keyword").val(), mode : Mode, currentPage : page}),
					success : function(JSONData , status) {
						
						//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
						if (JSONData.list.length < 10){
							isPageEnd = true;
						}
						
 						$.each(JSONData.list, function(index, item) {						
							
							if(Mode == 'Feed'){
								
								var thumbnail = '';								
								
								$.each(item.images, function(index, item){
									if(item.isThumbnail == 1){
										thumbnail = item.imageFile
									}									
								});								
								
								
								var displayValue ="<div class = 'view overlay'>"
									+"<div class = 'img_feed'>"
									+ "<img src='/VIG/images/uploadFiles/"
									+ thumbnail 
									+ "' alt='thumbnail' class='img-fluid rounded-sm' style='width: 400px; height: 300px;'>"
									+"<div class='mask flex-center waves-effect waves-light rgba-black-strong'>"
									+"<p class='white-text'>"
									+ item.feedTitle
									+"</p>"
									+"</div>"									
									+"</div>"
									+"</div>";
															
								
							}else if(Mode == 'Image'){			
								var displayValue = "<div class = 'view overlay'>"
								+"<div class = 'img_image'>"
								+ "<img src='/VIG/images/uploadFiles/"
								+ item.imageFile 
								+ "' alt='thumbnail' class='img-fluid rounded-sm' style='width: auto; height: 300px;'>"
								+"<div class='mask flex-center waves-effect waves-light rgba-black-strong'>"
								+"<p class='white-text'>"
								+ '이것은 이미지'
								+"</p>"
								+"</div>"									
								+"</div>"
								+"</div>";
							}
							
						
							console.log(displayValue)						              		
							$(".row:last").append(displayValue);							
						
						});	 									
					}
			});
		
	}
	
	
	function getkeywords() {
		$.ajax("/VIG/searchController/json/getSearchKeyword",
		  {
			method : "POST",
			dataType : "Json",							
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data :  JSON.stringify({keyword : $("#Keyword").val(), mode : Mode }),						
			success : function(JSONData, status) {
			var arraylist = JSONData;
				console.log( JSONData );
			//alert(JSONData);
			 	$( "#Keyword" ).autocomplete({
			 		
			        source: arraylist
			    });		
			}							
		});
	}
	
	
	$(function(){			
			// 최초 진입시 첫번째 페이지 로딩
			getItemList();
		
			//모드 버튼을 누르는 경우 페이지 초기화
			$("button").on("click",function(){				
				Mode = $(this).text();
				$( 'div' ).remove('.view');			
				page = 0;
				isPageEnd = false;
				$("#Keyword").val("");
				getItemList();
			});	
			
   			
			$(window).scroll(function() {
   			    if ($(window).scrollTop() == $(document).height() - $(window).height()) {     			     
	   				getItemList();   			    	
   			    }
   			});		
		
		
			$("#Keyword").on("keyup", function(){				
				if($("#Keyword").val().length >= 2){
					getkeywords();
				}					
			});	
			
	       $("#Keyword").keydown(function(key) {
	            if (key.keyCode == 13) {
	            	$( 'div' ).remove( '.view' );
					page = 0;
					isPageEnd = false;
	            	getItemList();
	            }
	        });			
			
	});	
	
	</script>
		

    
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
		<%-- <jsp:include page="../main/toolbar.jsp" /> --%>
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container-lg-fluid">
	
		<div class="row align-items-center justify-content-md-center">
			<div class="col-sm-10">
				<div class="input-group md-form form-sm form-1 pl-5">
				  <div class="input-group-prepend">
				    <span class="input-group-text cyan lighten-2" >
				    	<i class="fas fa-search text-white" aria-hidden="true"></i>
				    </span>
				  </div>
				  <input id="Keyword" class="form-control my-0 py-1" type="text" placeholder="Search" aria-label="Search">
				</div>	
			</div>			
			
			
			<div class="col-sm-2">
				<div class="btn-group btn-group-sm" role="group" aria-label="Basic">
				  <button type="button" class="btn  btn-cyan">Feed</button>
				  <button type="button" class="btn  btn-cyan">Image</button>
				  <button type="button" class="btn  btn-cyan">Writer</button>
				</div>
			</div>
		</div>
		
		<div class="row">
		
		
		<hr/>
		</div>
		
		<div class="row justify-content-center" style = "margin: 5px;">
		
		</div>
	
	</div>

</body>
</html>