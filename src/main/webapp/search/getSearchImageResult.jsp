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
		
	.view {	  
	margin: 5px 10px;
		}       

    </style>
	
	<script type="text/javascript">	

	//최초 페이지는 0으로 설정
	var page = 0; 	
	
	//페이지의 끝인지 체크
	var isPageEnd = false;
	
	var baseImageId = ${baseImage.imageId};

	
	function getImagelistFromAjax(item){
		var displayValue = 
			"<div class = 'view overlay'>"
			+"<div class = 'img_image'>"
			+ "<img src='/VIG/images/uploadFiles/" + item.imageFile + "' alt='thumbnail' class='img-fluid rounded-sm' style='width: auto; height: 300px;'>"
				+"<div class='mask flex-center waves-effect waves-light rgba-black-strong'>"
					+"<p class='white-text'>"
					+"<a href='/VIG/search/getSearchImages?imageId="+ item.imageId +"'/>"
					+ '이것은 이미지'
					+"</p>"
				+"</div>"									
			+"</div>"
		+"</div>";
			
			$(".row:last").append(displayValue);		
	}	

	
	
	function getImageItemList() {
		
		if(isPageEnd == true){
			//페이지의 끝이라면 실행안함
			return;
		}		
		page += 1;
		console.log(page);		
		
		
		$.ajax( 
				{
					url : "/VIG/search/json/getSearchResultList",
					method : "POST",
					dataType : "Json",					
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data :  JSON.stringify({baseImageID : imageId , currentPage : page}),
					success : function(JSONData , status) {
						
						//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
						if (JSONData.list.length < 10){
							isPageEnd = true;
						}				
	 						$.each(JSONData.list, function(index, item) {	
									
									getImagelistFromAjax(item); 									
													
							});		
 						
					}
			});
		
	}	

	
	
	$(function(){			
			// 최초 진입시 첫번째 페이지 로딩
			getImageItemList();
				
   			
			$(window).scroll(function() {
   			    if ($(window).scrollTop() == $(document).height() - $(window).height()) {     			     
   			    	getImageItemList();   			    	
   			    }
   			});	    			
			
	});	
	
	</script>
		

    
</head>
<body>

	<div class="container-lg-fluid">		
	
		<div class="row justify-content-center">
		
			<img class="col-lg-10" alt="" src="/VIG/images/uploadFiles/${baseImage.imageFile}" style="max-width: 960px;">		
		
		</div>
		<hr/>
		
		<div class="row justify-content-center">
			<h4 style="font-weight: bold;">유사한 이미지 더보기</h4>
		</div>
		
		
		<!--  이미지가 출력되는 부분  -->
		<div class="row justify-content-center" style = "margin: 5px;">		
			<c:forEach var="image" items="${list}">
				<div class = "view overlay">
					<div class = "img_image">
					<img src="/VIG/images/uploadFiles/${image.imageFile}"  class="img-fluid rounded-sm" style="width: auto; height: 300px;">
						<div class="mask flex-center waves-effect waves-light rgba-black-strong">
							<p class="white-text">
							<a href="/VIG/search/getSearchImages?imageId=${image.imageId}"/>
							유사 이미지 보기
							</p>
						</div>							
					</div>
				</div>		
			</c:forEach>		
		</div>	
	</div>

</body>
</html>