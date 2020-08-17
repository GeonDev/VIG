<%@page import="com.VIG.mvc.service.domain.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		

	
	function addFollower(follower) {
		var link = "/VIG/follow/json/addFollow?userCode=${user.userCode}&followerCode="+follower;	
		sendMessage(follower,'','2');	
		var id = "#follow_"+follower;
		
		//$(id).css('display','none');
		
		$.ajax(				
				{ url: link,
					method : "GET",	
					dataType: "json",
					headers : {						
						"Accept" : "applicion/json",
						"Content-Type" : "application/json"
					},					
			
				});
		
		
	}
	
	
	function deleteFollower(following) {
		var link = "/VIG/follow/json/deleteFollow?userCode=${user.userCode}&followerCode="+ following;
		var id = "#follow_"+following;
		
		$(id).css('display','none');
		
		$.ajax(				
				{ url: link,
					method : "GET",	
					dataType: "json",
					headers : {						
						"Accept" : "applicion/json",
						"Content-Type" : "application/json"
					},					
			
				});
	}

	

	</script>
	
	<style>
	
	body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
	h1 { margin-left: 100px;}
	
	.col-md-12{ margin-bottom: 50px;}
	.img_feed {	width: 388px; height: 291px; overflow:hidden;}	
	.view {	 margin: 5px 10px;}	
	.txt_line { width:380px;  padding:0 5px; overflow:hidden; text-overflow:ellipsis;  white-space:nowrap; }	
	.row.justify-content-center { margin: 50px 0px 10px 0px;}
	
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	
	/* 버튼 CSS */
		.box_body_m {box-sizing: border-box; font-family: "Futura PT", "Futura", sans-serif; -webkit-font-smoothing: antialiased;}
		.wrap_m {text-align: center;}
		#btn_ch_m { padding: 12px 50px;text-decoration: none;font-size: 12px; ;margin: 3px 20px; display:flex; float:left;}
		.btn:hover, .btn:link:hover, .btn:visited:hover {box-shadow: 0 4em 0 0 #2c3e50 inset, 0em 0em 0 0 #bbb;-webkit-transform: translate(0.3em, 0.2em);transform: translate(0.3em, 0.2em); color: #fff;}
		.btn3, .btn3:link, .btn3:visited {color: #333;font-size: .8em;text-transform: uppercase;min-width: 100px;position: relative;
		  	margin: 0 auto;border: 2px solid transparent;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:after, .btn3:before, .btn3:link:after, .btn3:link:before, .btn3:visited:after, .btn3:visited:before { content: "";position: absolute;letter-spacing: .1em;left: -1em;top: -2px; height: 3em; width: 0;
			border: 1px solid #ff9100;-webkit-transition: inherit;transition: inherit;}
		.btn3:after, .btn3:link:after, .btn3:visited:after {left: auto;right: -1em;}
		.btn3:hover, .btn3:link:hover, .btn3:visited:hover {border-color: #ff9100;-webkit-transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:hover:after, .btn3:hover:before, .btn3:link:hover:after, .btn3:link:hover:before, .btn3:visited:hover:after, .btn3:visited:hover:before {
		  right: -2px;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:hover:before, .btn3:link:hover:before, .btn3:visited:hover:before {left: -2px;right: auto;}
		@-webkit-keyframes gelatine {
		  from,to {-webkit-transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);}
		  from,to {-webkit-transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);}}
		@keyframes gelatine {from,to {-webkit-transform: scale(1, 1); transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1); transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);t}
			/* 버튼 CSS */
	
	
	</style>

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
					<h1>
						<strong>${writer.userName}</strong> 님의 ${type} 리스트
					</h1>	
					<hr/>
					
			<!-- 본문 -->
		 		<div class="row justify-content-center">
					 <div class="box_body_m">
						 <div class="wrap_m">
						 	<a id="btn_ch_m" class="btn3" href="/VIG/myfeed/getFollowerList?userCode=${writer.userCode}" >팔로워</a>
						 	
							<a id="btn_ch_m" class="btn3" href="/VIG/myfeed/getFollowingList?userCode=${writer.userCode}" >팔로잉</a>
							
							<a id="btn_ch_m" class="btn3" href="/VIG/chat/getChat">채 팅</a>
						</div>	 			
					</div>   		
			    					    	
			    </div>			    		
			    	<br/>	
			
				<div id="showFollowlist" class="row justify-content-center" style="margin: 50px 30px 10px 30px;"></div>
			    	
			    	<c:forEach var="follow" items="${follow}">
			    	
			    	<c:if test="${type == '팔로워'}">
			    		<div id="follow_${follow.tagetUser.userCode}">			    		
					    	<div class="row">		
					    		<div class="col-md-2 ">
						    		<a  href="/VIG/myfeed/getMyFeedList?userCode=${follow.tagetUser.userCode}">
						    			<img src="/VIG/images/uploadFiles/${follow.tagetUser.profileImg}" class="rounded-circle"  style="max-height: 120px; margin-left: 20px;">				    		
						    		</a>		    		
					    		</div>
					    
					    		<div class="col-md-8" style="margin-top: 20px;">
					    			<h2><strong>${follow.tagetUser.userName}</strong></h2>
					    			<h4>${follow.tagetUser.selfIntroduce}</h4>				    		
					    		</div>
					    		
					    		<div class="col-md-2">				    			
					    				<c:if test="${user.userCode == follow.isF4F}">
					    					<button type="button" id="follow" class="btn btn-default btn-rounded" style="margin-top: 20px;" onclick="deleteFollower('${follow.tagetUser.userCode}')" >
					    					<strong style="color: white;">UnFollow</strong>					    					
					    					</button>
					    				</c:if>
					    				
					    				<c:if test="${user.userCode != follow.isF4F}">
						    				<button type="button" id="follow" class="btn btn-outline-default btn-rounded" style="margin-top: 20px;" onclick="addFollower('${follow.tagetUser.userCode}')">
						    				Follow		
						    				</button>
					    				</c:if>							    		
					    		</div>
						  </div>  
						  <hr/>		
					  </div>
			    	</c:if>
			    	
			    	<c:if test="${type == '팔로잉'}">		
			    		<div id="follow_${follow.followUser.userCode}">			    		
					    	<div class="row">		
					    		<div class="col-md-2 ">
						    		<a  href="/VIG/myfeed/getMyFeedList?userCode=${follow.followUser.userCode}">
						    			<img src="/VIG/images/uploadFiles/${follow.followUser.profileImg}" class="rounded-circle"  style="max-height: 120px; margin-left: 20px;">				    		
						    		</a>		    		
					    		</div>
					    
					    		<div class="col-md-8" style="margin-top: 20px;">
					    			<h2><strong>${follow.followUser.userName}</strong></h2>
					    			<h4>${follow.followUser.selfIntroduce}</h4>				    		
					    		</div>
					    		
					    		<!-- 팔로잉 유저는 한번더 터치하면 바로 삭제 -->
					    		<div class="col-md-2">  				    				
			    					<button type="button" id="follow" class="btn btn-default btn-rounded" style="margin-top: 20px;" onclick="deleteFollower('${follow.followUser.userCode}')" >
			    					<strong style="color: white;">UnFollow</strong>					    					
			    					</button>							    									    		
					    		</div>
						  </div>  
						  <hr/>		
					  </div>    	
			    	</c:if>  		
			    		
			    					    		
			    	</c:forEach>	
			    	
			    	<c:if test="${empty follow}">
			    		<br/>
			    		<h2 style="text-align: center;">${type} 유저가 없습니다. </h2>			    	
			    	</c:if>
			    		    				    
			    				    
			    				    
				</div>					
			</div>
		</div>
	

</body>
</html>
