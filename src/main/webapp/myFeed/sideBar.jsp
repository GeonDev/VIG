
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript">


</script>

	
	<style type="text/css">
	
	.row_toolbar_top_ { padding: 70px;}
	#pImg { display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; max-width: 150px; max-height: 150px; border-radius:50%; padding:0;}
	#sns_nav { display:flex; margin-left:auto; margin-right:auto; flex-direction: row; justify-content: center;}
	#sideBar { padding: auto; margin:auto; display: block;}

		
		/* 버튼 CSS */
		.box_body {box-sizing: border-box; font-family: "Futura PT", "Futura", sans-serif; -webkit-font-smoothing: antialiased;}
		.wrap {position: absolute;top: 150%;left: 50%;margin-top: -250px;margin-left: -110px;text-align: center;}
		#btn_ch { padding: 12px 50px;text-decoration: none;font-size: 12px; display: block;margin: 3px 20px;}
		.btn:hover, .btn:link:hover, .btn:visited:hover {box-shadow: 0 4em 0 0 #2c3e50 inset, 0em 0em 0 0 #bbb;-webkit-transform: translate(0.3em, 0.2em);transform: translate(0.3em, 0.2em); color: #fff;}
		.btn3, .btn3:link, .btn3:visited {color: #333;font-size: .8em;text-transform: uppercase;min-width: 100px;position: relative;
		  	margin: 0 auto;border: 2px solid transparent;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:after, .btn3:before, .btn3:link:after, .btn3:link:before, .btn3:visited:after, .btn3:visited:before { content: "";position: absolute;letter-spacing: .1em;left: -1em;top: -2px; height: 3em; width: 0;
			border: 1px solid #c75842;-webkit-transition: inherit;transition: inherit;}
		.btn3:after, .btn3:link:after, .btn3:visited:after {left: auto;right: -1em;}
		.btn3:hover, .btn3:link:hover, .btn3:visited:hover {border-color: #c75842;-webkit-transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
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



    <div class="container-fluid">  
      	
<!-- 사이드바  시작-->    
		<div class="row" id="sideBar">
		
		
			<!-- 다른 유저의 마이 피드 방문시 해당 유저의 정보만 노출 -->
				<c:choose>
					<c:when test="${user.userCode != writer.userCode}">		
					<img class="card-img-top" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg" alt="profile_img">
			 			<div class="card-body">
			 					<h3 class="user_name" align="center"><strong> ${writer.userName} </strong> </h3>			
			 					<p class="user_bio" align="center" > ${writer.selfIntroduce} </p>		 					
			 					<p class="sign_date" align="center"> Member Since :: ${user.regDate}</p>
			 			</div>	
			 			<br/>		
			 		</c:when>
			 	</c:choose>
		 			

			<!-- 마이페이지 접속시 메뉴   //// 아니 조건문 어떻게 줘?ㅠ.ㅠ-->    
			 	<c:choose>
					<c:when test="${user.userCode == writer.userCode}">
					
						<img class="card-img-top" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg" alt="profile_img">
				 			<div class="card-body">
				 					<h4 class="user_name" align="center"> ${user.userName} </h4>
				 					<br/>
				 					<p class="user_bio" align="center"> ${user.selfIntroduce} </p>
				 					<br><br/>
				 				<p class="sign_date" align="center" style="margin-bottom:30px;"> Member Since :: ${user.regDate}</p>	
				 				<br/>
				 			</div>
				 				<br/>		
				 	
						
						<c:choose>
					<c:when test="${sessionScope.user.role=='user' || sessionScope.user.role=='business'}">
			 			
			 <div class="box_body">
				<div class="wrap">
 					<a id="btn_ch" class="btn3" href="/VIG/myFeed/getMyFeedList.jsp">
 						마이피드 목록</a>
 					<br/>
 					<a id="btn_ch" class="btn3" href="/VIG/history/getMyHistoryList">
 						내 활동 보기</a>
 					 <br/>
 					 <a id="btn_ch" class="btn3" href="/VIG/user/updateUser">
 						내 정보 수정</a>
 					 <br/>

<<<<<<< HEAD
 <!-- 메뉴 네비게이션 -->                                													 <!-- 코드 정리하기 -->
 		<c:choose>
		<c:when test="${sessionScope.user.role=='user' || sessionScope.user.role=='business'}">
 			
 			<a type="button" class="btn btn-block" href="/VIG/myFeed/getMyFeedList.jsp">마이피드 목록</a>
 				<br/>
 				
 			<a type="button" class="btn btn-block" href="/VIG/history/getMyHistoryList"> 내 활동 보기</a>
 				<br/>
 				
 			<a type="button" class="btn btn-block" href="/VIG/user/updateUser">내 정보 수정</a>
 				<br/>
 				
 			<a type="button" class="btn btn-block" href="/VIG/withdraw/getDonationList">받은 후원 목록</a>
 				<br/>	
=======
>>>>>>> fatch
 					
 					 <!-- 비지니스 유저만 통계-->
			 		<c:if test="${sessionScope.user.role=='business'}">
			 			<a id="btn_ch" class="btn3" href="/VIG/chart/getChart">통 계</a>
			 				<br/>	
				 		</c:if>							
				 		</c:when>
				 		</c:choose>
 					
 					
 					
 					<a id="btn_ch" class="btn3" data-toggle="dropdown"aria-haspopup="true" aria-expanded="false">
 						결제 </a>
 						<div class="dropdown-menu" style="position: absolute;will-change: transform;top: 0px;left: 10px;transform: translate3d(20px, 347px, 0px);">
					  <a class="dropdown-item" href="/VIG/payment/getPaymentList">내 결제 목록</a>
					 <c:if test="${sessionScope.user.role=='user'}">
					  <a class="dropdown-item" href="#">후원 목록</a>
					  </c:if>
					 <c:if test="${sessionScope.user.role=='business'}">
					  <a class="dropdown-item" href="#">후원 받은 목록</a>
					  </c:if>
				    </div>
 					<br/>
 						
			
				 		
				 		
				 		
				 		
			<!-- 관리자 로그인시 --> 		
			 		<c:if test="${sessionScope.user.role=='admin'}">
			 			<a type="button" class="btn btn-block" href="/VIG/user/getUserList">회원 목록</a>
			 				<br/>
			 			<a type="button" class="btn btn-block"href="/VIG/report/getReportlist.jsp">신고 조회</a>
			 				<br/>
			 			<a type="button" class="btn btn-block" href="/VIG/payment/getAllPaymentList">결제 조회</a>
			 				<br/>
			 		</c:if>	
			 		
			 		</div>
 					</div>		
			 		</c:when>
			 		</c:choose>
			 		
			</div>
		</div>	
	</div>

</body>
</html>