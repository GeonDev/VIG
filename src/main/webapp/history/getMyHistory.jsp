<%@page import="com.VIG.mvc.service.domain.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>

	<meta charset="UTF-8">
	
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
	body {
    	padding-top : 50px;
        }           
		
	.img_feed {	  
	    max-width: 300px;
	    max-height: 225px;	
		}
				
	.view {	  
	margin: 5px 10px;
		}
		

    </style>
    
	<script type="text/javascript">
	function funcGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("action", "./getReportList");
		$("form").submit();
	}	
	
	
	
	function deleteHistory(historyId){
		console.log(historyId);
		var result = confirm("해당 기록을 지우시겠습니까?");
		if(result){
			var link ='/VIG/history/deleteHistory?Id=';
			link =  link.concat(historyId);
			$(location).attr("href", link); 
		}
	}
	
	
	$(function(){	
		

	
	});
	
	
</script>
</head>

<body>

	<div class="container-fluid">		
	
	
		<!--href와 ID를 연결해야 작동함  -->
	
		<div class="col-md-8">	
			<br/>
			
			<div class="page-header text-info">
				<h3>내 활동정보 보기</h3>
			</div>			
			<hr/>		
				
			
			<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			  <li class="nav-item">
			    <a class="nav-link active" id="pills-show-tab" data-toggle="pill" href="#pills-show" role="tab"
			      aria-controls="pills-home" aria-selected="true">최근열람피드</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" id="pills-comment-tab" data-toggle="pill" href="#pills-comment" role="tab"
			      aria-controls="pills-profile" aria-selected="false">댓글 보기</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" id="pills-like-tab" data-toggle="pill" href="#pills-like" role="tab"
			      aria-controls="pills-contact" aria-selected="false">좋아요 한 피드</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" id="pills-hide-tab" data-toggle="pill" href="#pills-hide" role="tab"
			      aria-controls="pills-contact" aria-selected="false">숨긴 피드</a>
			  </li>
			</ul>			
			
			
			<div class="tab-content pt-2 pl-1" id="pills-tabContent">
			  <div class="tab-pane fade show active" id="pills-show" role="tabpanel" aria-labelledby="pills-show-tab">
			  
				  <div class="row justify-content-start" style="margin-left: 10px; margin-right: 10px;">
					  <c:forEach var="history" items="${historylist}">				
							<div class = "view overlay">
									<div class = "img_feed">								
										<c:forEach var="thumbnail" items="${history.showFeed.images}">
											<c:if test="${thumbnail.isThumbnail == 1}">									
												<img src="/VIG/images/uploadFiles/${thumbnail.imageFile}" alt="thumbnail" class="img-fluid rounded-sm" style="width: 300px; height: 225px;">																						
											</c:if>
										</c:forEach>										
										<div class="mask waves-effect waves-light rgba-black-strong" style="text-align: right">	
											<button type="button" onclick="deleteHistory(${history.historyId})" class="btn btn-link" style="padding-left: 15px; padding-right: 15px;">
												<i class="far fa-trash-alt" style="color: white; padding: 0px;"></i>
											</button>										
										</div>																			
									</div>
								<h5 style="font-weight: bold; margin: 5px 10px;">													
									${history.showFeed.feedTitle}
								</h5>	
							</div>
						</c:forEach>			  
				  </div>			  
			  
			  </div>
			  <div class="tab-pane fade" id="pills-comment" role="tabpanel" aria-labelledby="pills-comment-tab">
				댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다.
				댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다.
				댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다. 댓글입니다.
			  </div>
			  <div class="tab-pane fade" id="pills-like" role="tabpanel" aria-labelledby="pills-like-tab">
		        좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다.
			    좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다.
			    좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다. 좋아요한 글입니다.
			  </div>
			  <div class="tab-pane fade" id="pills-hide" role="tabpanel" aria-labelledby="pills-hide-tab">
			  
				  <div class="row justify-content-start" style="margin-left: 10px; margin-right: 10px;">
					  <c:forEach var="history" items="${hidelist}">				
							<div class = "view overlay">
								<div class = "img_feed">							
									<c:forEach var="thumbnail" items="${history.showFeed.images}">
										<c:if test="${thumbnail.isThumbnail == 1}">									
											<img src="/VIG/images/uploadFiles/${thumbnail.imageFile}" alt="thumbnail" class="img-fluid rounded-sm" style="width: 300px; height: 225px;">																						
										</c:if>
									</c:forEach>
									<a href="/VIG/feed/getFeed?feedId=${history.showFeed.feedId}">
										<div class="mask waves-effect waves-light rgba-black-strong" style="text-align: right">	
											<button type="button" onclick="deleteHistory('${history.historyId}')" class="btn btn-link" style="padding-left: 15px; padding-right: 15px;">
												<i class="far fa-trash-alt" style="color: white; padding: 0px;"></i>
											</button>										
										</div>																		
									</a>
								</div>
								<h5 style="font-weight: bold; margin: 5px 10px;">													
									${history.showFeed.feedTitle}
								</h5>	
							</div>
						</c:forEach>			  
				  </div>	
	
			  </div>
			</div>
			
			
			
			
			<div class="row justify-content-md-center">
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>
			
		</div>		
	</div>
	
</body>
</html>