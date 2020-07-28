<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.VIG.mvc.service.domain.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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
	

   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
<script type="text/javascript">
		
		//최초 페이지는 0으로 설정
		var page = 0; 	
		
		//페이지의 끝인지 체크
		var isPageEnd = false;
		
		//페이지 로드가 완료 되었는지 체크(ajax 중복 호출 방지용)
		var isLoadPage = false;	
		
		
		function getfeedlistFromAjax(item){
			var thumbnail = '';								
			
			$.each(item.images, function(index, item){
				if(item.isThumbnail == 1){
					thumbnail = item.imageFile
				}									
			});										
			
			var displayValue =
				"<div class = 'view overlay'>"
					+"<div class = 'img_feed'>"
					+ "<a href='/VIG/feed/getFeed?feedId="+ item.feedId +"' class='text-light'>"
						+ "<img src='/VIG/images/uploadFiles/" + thumbnail + "' alt='thumbnail' class='img-fluid rounded-sm' style='width: 400px; height: 300px;'>"
						+ "<div class='mask waves-effect waves-light rgba-black-strong'>"
							+ "<h5 style='font-weight: bold;'>&ensp;"+ item.feedTitle +"</h5>"					
						+ "</div>"
					+ "</a>"
					+"</div>"
				+"</div>";
										
				$(".row:last").append(displayValue);		
		}
		
		function getFeedItemList(categoryName) {
			
			if(isPageEnd == true || isLoadPage == true){
				//페이지의 끝, 또는 페이지 로드중 이라면 실행안함
				return;
			}		
			isLoadPage = true;
			page += 1;
			console.log(page);		
			
			
			$.ajax( 
					{
						url : "/VIG/search/json/getSearchCategoryResult",
						method : "POST",
						dataType : "Json",					
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data :  JSON.stringify({category : categoryName, currentPage : page}),
						success : function(JSONData , status) {
							
							//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
							if (JSONData.list.length < 10){
								isPageEnd = true;
							}
	 							 				
		 	 				$.each(JSONData.list, function(index, item) { 														
		 						getfeedlistFromAjax(item);	 												
		 					});	 							
	 						
	 						
	 						//로드가 완료되면 로딩이 되었다고 체크
	 						isLoadPage = false;						
						}
				});	
		}	
		
	
		
		$(function(){			
			// 최초 진입시 첫번째 페이지 로딩
			getFeedItemList('일러스트레이션');
		});
		
	</script>
		
	<style type="text/css">	
	


		
	body {
    padding-top : 50px;
    } 
    
    .img_feed {	  
	max-width: 400px;
	max-height: 300px;	
	}
	
	.img_categories {	  
	max-width: 160px;
	max-height: 90px;	
	}
	    
   	.eBanner{
	width: auto; height: auto;
    max-width: 100%;
    max-height: 300px;
    }
       
     .txt_line {
	 width:380px; 
	 padding:0 5px; 
	 overflow:hidden; 
	 text-overflow:ellipsis; 
	 white-space:nowrap; 
	 }
	 
	.view {	  
	margin: 5px 10px;
	}
    
   	</style>
    
</head>
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="toolbar.jsp" />
	
	
	<div class="container-fluid">
     
		<div id="categories" class="row justify-content-center" style="margin-left: 10px; margin-right: 10px;">
			<div class="col-md-11">
				
					
				
					<c:forEach var="category" items="${categoryList}">
				    	
				    </c:forEach>
	
			</div>
			<div class="col-md-1">
					<div class="dropdown">
				  <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuMenu" data-toggle="dropdown"
				    aria-haspopup="true" aria-expanded="false" style="padding-left: 15px; padding-right: 15px;">
				   <i class="fas fa-align-justify"></i>
				  </button>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuMenu">
				    
				    <c:forEach var="category" items="${categoryList}">
				    	<button class="dropdown-item" type="button">${category.categoryName}</button>
				    </c:forEach>
			
				  </div>
				</div>
			</div>
		
		
		</div>	

        <div id="banner" class="row"></div>
  
        <div id="main" class="row justify-content-center" style="margin-left: 10px; margin-right: 10px;"></div>


	</div>
	
	





</body>
</html>