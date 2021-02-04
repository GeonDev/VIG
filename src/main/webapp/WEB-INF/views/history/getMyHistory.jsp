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
	
	body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}
    h1 { margin-left: 100px;}  	       
    
    .col-md-12{ margin-bottom: 50px;}
    .txt_lineSize { width:280px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }	           		
	.img_feed { max-width: 300px; max-height: 225px;}				
	.view {	 margin: 5px 10px;}	
	.nav.nav-pills.mb-3 { margin: 55px 0px 10px 0px;}
	.nav-item { margin: 0px 30px;}
	.row.justify-content-start { padding-left:10%}
	.tab-pane.fade { margin : 20px;}
	
	#pills-tabContent { margin-top: 50px; }
	#pills-show { margin-top: 20px;}
	.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
    color: #fafafa;
    background-color: #263238;
    }
    .nav-link{ color:#263238;}
	
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	
    </style>
    
	<script type="text/javascript">
	function funcGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("action", "./getReportList");
		$("form").submit();
	}	
	
	
	
	function deleteHistory(historyId){
		event.preventDefault();
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


<!-- 툴바 -->
		      <div class="container-fluid">  
		      	 <div class="row">
		      		<div class="col-md-12">
		      			<jsp:include page="/main/toolbar.jsp"></jsp:include>
		     		</div>
				</div>
		
		
			<!-- 사이드바  -->		
				<div class="col-md-2 sideBarPlace">		
				 <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
		    	</div>
		    
			<!-- 타이틀 -->
			    <div class="col-md-10" id="mainMyFeedPage" >					
					<h1>내 활동정보 보기</h1>			
				<hr/>		
					
			<!-- 본문 -->
			<div class="row justify-content-center">
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
			</div>
			
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
										<div class="mask waves-effect waves-light rgba-black-strong" style="text-align: right;">	
											<button type="button" onclick="deleteHistory(${history.historyId})" class="btn btn-link" style="padding-left: 15px; padding-right: 15px;">
												<i class="far fa-trash-alt" style="color: white; padding: 0px;"></i>
											</button>										
										</div>																			
									</div>
								<h5 class="txt_lineSize" style="font-weight: bold; margin: 5px 10px;">													
									${history.showFeed.feedTitle}
								</h5>	
							</div>
						</c:forEach>			  
				  </div>			  
			  
			  </div>
			  <div class="tab-pane fade" id="pills-comment" role="tabpanel" aria-labelledby="pills-comment-tab">
			  	
				<c:forEach var="comments" items="${commentlist}">
					<div class="row" style="margin: auto;">						
						<div class="col-md-1">
							<img src="/VIG/images/uploadFiles/${comments.user.profileImg}" class="rounded-circle" style="width: 50px;">
						</div>
						<div class="col-md-10 ">
							<p style="font-size: 25px; font-weight: bold; margin-top: 7px;"> ${comments.commentText}</p>
						</div>
						<div class="col-md-1">
							<button id= "deleteCom" class="btn btn-link" onclick="removeComment('${comments.commentId}')">
								<i class="fas fa-trash"></i>
							</button>						
						</div>
											
					</div>		
			 			<hr/>
				</c:forEach>
			  		
			  </div>
			  <div class="tab-pane fade" id="pills-like" role="tabpanel" aria-labelledby="pills-like-tab">
			  		<div class="row justify-content-start" style="margin-left: 10px; margin-right: 10px;">
					  <c:forEach var="feed" items="${likeFeedlist}">				
							<div class = "view overlay">
									<div class = "img_feed">								
										<c:forEach var="thumbnail" items="${feed.images}">
											<c:if test="${thumbnail.isThumbnail == 1}">	
											 	<a href="/VIG/feed/getFeed?feedId=${feed.feedId}">							
													<img src="/VIG/images/uploadFiles/${thumbnail.imageFile}" alt="thumbnail" class="img-fluid rounded-sm" style="width: 300px; height: 225px;">																						
												</a>	
											</c:if>
										</c:forEach>																			
									</div>
								<h5 class="txt_lineSize" style="font-weight: bold; margin: 5px 10px;">													
									${feed.feedTitle}
								</h5>	
							</div>
						</c:forEach>
			  		</div>
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
								<h5 class="txt_lineSize" style="font-weight: bold; margin: 5px 10px;">													
									${history.showFeed.feedTitle}
								</h5>	
							</div>
						</c:forEach>			  
				  </div>	
			  </div>
			</div>	
		</div>
		</div>
			
			
		</div>
		
	
</body>
</html>