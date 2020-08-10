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
		
		//선택된 카테고리를 세팅		
		var selectCategory ='RECOMMEND';			
		
		//전달받은 피드 리스트를 화면에 그린다.
		function getfeedlistFromAjax(item, user){
			var thumbnail = '';								
			
			$.each(item.images, function(index, item){
				if(item.isThumbnail == 1){
					thumbnail = item.imageFile
				}									
			});
			
			//변수  초기화
			var displayValue ='';
			
			displayValue = 
				"<div class = 'view overlay' >"
					+"<div class = 'img_feed'>"
					+ "<a href='/VIG/feed/getFeed?feedId="+ item.feedId +"' class='text-light'>"
						+ "<img src='/VIG/images/uploadFiles/" + thumbnail + "' alt='thumbnail' class='img-fluid rounded-sm img_feed'>"
						+ "<div class='mask waves-effect waves-light rgba-black-strong' style='text-align: right;'>";					
							if(user != ''){
								displayValue +="<button type='button' onclick='addhideFeed("+ item.feedId +")' class='btn btn-link' style='width: 50px; height:50px; padding-left: 0px; padding-right: 0px;'>"											
									+ "<h4><i class='far fa-times-circle' style='color: white; text-align: center;'></i></h4>"
								+"</button>"
								+"<p class='txt_line' style='margin: 55% 10px; font-weight: bold; text-align: left; color : white; font-size : large; vertical-align: bottom'>";					
							}else{
								displayValue += "<p class='txt_line' style='margin: 65% 10px; font-weight: bold; text-align: left; color : white; font-size : large; vertical-align: bottom'>";								
							}					
						
							
							if(item.feedIsPrime == 1){
								displayValue += "<span class='badge badge-primary'>Prime</span>&nbsp;";
							}						
							
							displayValue += item.feedTitle + "</p>"					
						+ "</div>"
					+ "</a>"
					+"</div>"
				+"</div>";
										
				$(".row:last").append(displayValue);		
		}
		
		//피드를 그려주는 부분 (Ajax) 호출
		function getFeedItemList(categoryName) {				
			
			if(isPageEnd == true || isLoadPage == true){
				//페이지의 끝, 또는 페이지 로드중 이라면 실행안함
				return;
			}		
			isLoadPage = true;
			page += 1;
			//console.log(page);		
			
			
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
							
							if(JSONData.list.length > 0){
							
							//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
							if (JSONData.list.length < 10){
								isPageEnd = true;
							}
	 							 				
		 	 				$.each(JSONData.list, function(index, item) { 														
		 						getfeedlistFromAjax(item,'${user}');	 												
		 					});	 							
	 						
	 						
	 						//로드가 완료되면 로딩이 되었다고 체크
	 						isLoadPage = false;						
							}else{
								isPageEnd = true;
							}
						}
				});	
		}
		
		
		
		//카테고리를 변경했을때 처리
		function setCategories(categoryName) {
			$( 'div' ).remove( '.overlay' );
	    	page = 0;
	    	isPageEnd = false;
	    	isLoadPage = false;	   
			selectCategory = categoryName;	
			
			getFeedItemList(categoryName);				
		}		
		
		/*
		//카테고리 +버튼을 누름
		function CategoriesPlue() {			 
			$('#categoryList').scrollLeft($('#categoryList').scrollLeft() + 200);

		}
		
		//카테고리 -버튼을 누름
		function CategoriesMinus() {			
			$('#categoryList').scrollLeft($('#categoryList').scrollLeft() - 200);
		}
		*/
		
		
		//카테고리 +버튼을 누름
		function CategoriesPlue() {			 
			$('#categoryList').animate( { scrollLeft: '+200'});
		}
		//카테고리 -버튼을 누름
		function CategoriesMinus() {			
			$('#categoryList').animate( { scrollLeft: '-200'});
		}
		
		//피드를 숨길지 물어본다.
		function addhideFeed(feedId){	   	
			event.preventDefault();
			console.log(feedId);
			var result = confirm("해당 피드를 숨기시겠습니까?");
			if(result){
				var link ='/VIG/history/addHideFeed?Id=';
				link =  link.concat(feedId);
				$(location).attr("href", link); 
			}      	    			
		}			
		
		$(function(){			
			// 최초 진입시 첫번째 페이지 로딩
			getFeedItemList(selectCategory);
			
			
			$(window).scroll(function() {
   			    if ($(window).scrollTop() == $(document).height() - $(window).height()) {     			     
   			    	getFeedItemList(selectCategory);   			    	
   			    }
   			});	
			
		
			
			//F1 버튼을 누르면 키워드 추출 설정 
	         $(document).keydown(function(key) {
	            if (key.keyCode == 113) {
	        		var result = confirm("비밀번호 해쉬 및 이미지 정보를 추출 하시겠습니까?");
	        		if(result){
	        			var link ='/VIG/main/setImage';		        		
	        			$(location).attr("href", link); 
	        		}
	            	
	            }
	        });	
			
					
			
			$(document).on("click",".img_categories",function(){
				
				$('div.mask').attr('class',"mask flex-center rgba-black-strong rounded-sm");
				$(this).find('div.mask').attr('class',"mask flex-center rgba-indigo-strong rounded-sm");
					
				setCategories($(this).find('p').text());
				
			});	
			
			
		});
		
	</script>
		
	<style type="text/css">	
	
	h5{
	display:table-cell;
	}

		
	body {
    padding-top : 50px;
    } 
    
    .img_feed {	
    width: auto; height: auto;  
	max-width: 500px;
	max-height: 375px;
	overflow:hidden;
	
	border-radius: 10px;
	}
	
	.img_categories {	
	max-height: 80px;
	padding-left: 0px;
	padding-right: 0px;
	margin-left: 0px;
	margin-right: 0px;
	text-align: center; 
	}
	    
   	.eBanner{
	width: auto; height: auto;
    max-height: 180px;
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
	.view.overlay{border-radius: 10px;}
	
	
	<!-- 스크롤 제거 부분 -->
	#categoryList {
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
    
	}
	#categoryList::-webkit-scrollbar {
	    display: none; /* Chrome, Safari, Opera*/
	}

    
   	</style>
    
</head>
<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="toolbar.jsp" />
	
	
	<div class="container-lg-fluid">
     
		<div id="categories" class="row" >
										
				<div class="row" style="margin: 10px -15px 30px 20px;">
				
					<div class="col-md-1" style="margin-top: 20px; text-align: center;">
						<button class="btn btn-link" onclick="CategoriesMinus()" type="button" > <i class="fas fa-angle-left"></i></button>	        					      				
					</div>				
				
					<div class="col-md-10" >
						<div id="categoryList" class="row" style="max-height:100px; flex-wrap: nowrap; overflow: auto;">
						<c:set var="i" value="0" />						
						<c:forEach var="category" items="${categoryList}">				
							<div class="col-md-2" id="category_${i}" style="padding-left: 0px; padding-right: 0px">
								<div class="view img_categories ">			    			
					    			<img src="/VIG/images/others/${category.categoryImg}" alt="thumbnail" class="img-fluid overflow-hidden rounded-sm" >
					    			
					    			<c:if test="${category.categoryName == 'RECOMMEND'}">
					    				<div class="mask flex-center rgba-indigo-strong rounded-sm">	
					    			</c:if>
					    			<c:if test="${category.categoryName != 'RECOMMEND'}">
					    				<div class="mask flex-center rgba-black-strong rounded-sm">	
					    			</c:if>		    			
					    		  	
					    		   		<p class="white-text" style="font-weight:bold ; font-size: large; padding: 0px;">${category.categoryName}</p>					    		    				    		         					      						
			   						</div>    						
					    		</div>	
							</div>	
							<c:set var="i" value="${i+1}" />											  
					    </c:forEach>
						</div>	
					</div>
					
					<div class="col-md-1" style="margin-top: 20px; text-align: center;">
						<button class="btn btn-link" type="button" onclick="CategoriesPlue()" > <i class="fas fa-angle-right"></i></button>		  					      				
					</div>				
				</div>		
		
		</div>	

        <div id="banner" class="row" style="margin-left: 10px; margin-right: 10px; margin-bottom: 100px; margin-top: 20px;">
	  		<div id="carousel-eBanner" class="carousel slide carousel-fade col-md-12" data-ride="carousel">
			  <!--Indicators-->
			  <ol class="carousel-indicators">
			    <li data-target="#carousel-eBanner" data-slide-to="0" class="active"></li>
			    <li data-target="#carousel-eBanner" data-slide-to="1"></li>
			    <li data-target="#carousel-eBanner" data-slide-to="2"></li>
			  </ol>
		
			  <div class="carousel-inner" role="listbox">
			  
			  	<c:set var="i" value="1" />
			  	
			  	<c:forEach var="event" items="${eventList}">			  		
			  	
			  		<c:if test="${i == 1}">
			  		 <div class="carousel-item active" style="text-align: center;">			  		
			  		</c:if>			  		
			  		<c:if test="${i != 1}">
			  		 <div class="carousel-item " style="text-align: center;">			  		
			  		</c:if>
			  					  		
				  		<a href="/VIG/event/getEvent?eventId=${event.eventId}">
					      <img class="eBanner rounded mb-0" src="/VIG/images/others/${event.banner}" >
					    </a>			  	
			  		
			  		</div>
			  		
			  		
			  		<c:set var="i" value="${i+1}" />
			  	</c:forEach>			
			  
			  </div>
	
	
			  <a class="carousel-control-prev" href="#carousel-eBanner" role="button" data-slide="prev" >
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="carousel-control-next" href="#carousel-eBanner" role="button" data-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			
			</div>
		</div>		
		
        <div id="main" class="row justify-content-center" style="margin-left: 10px; margin-right: 10px;"></div>

	</div>
	
	





</body>
</html>