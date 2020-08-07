
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">


</script>

	
	<style type="text/css">
	
	.row_toolbar_top_ { padding: 70px;}
	#pImg { display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; max-width: 150px; max-height: 150px; border-radius:50%; padding:0;}
	#sns_nav { display:flex; margin-left:auto; margin-right:auto; flex-direction: row; justify-content: center;}
	#sideBar { padding: auto; margin:auto; display: block;}

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
			 					<h4 class="user_name" align="center"> ${writer.userName} </h4>
			 					<hr>
			 					<p class="user_bio" align="center"> ${writer.selfIntroduce} </p>
			 					<br><br/>
			 				<p class="sign_date" align="center"> Member Since :: ${user.regDate}</p>
			 			</div>	
			 			<hr/><br/>		
			 		</c:when>
			 	</c:choose>
		 			

			<!-- 마이페이지 접속시 메뉴   //// 아니 조건문 어떻게 줘?ㅠ.ㅠ-->    
			 	<c:choose>
					<c:when test="${user.userCode == writer.userCode}">
					
						<img class="card-img-top" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg" alt="profile_img">
				 			<div class="card-body">
				 					<h4 class="user_name" align="center"> ${user.userName} </h4>
				 					<hr>
				 					<p class="user_bio" align="center"> ${user.selfIntroduce} </p>
				 					<br><br/>
				 				<p class="sign_date" align="center"> Member Since :: ${user.regDate}</p>	
				 			</div>
				 			<hr/><br/>			
				 	
						
						<c:choose>
					<c:when test="${sessionScope.user.role=='user' || sessionScope.user.role=='business'}">
			 			
			 			<a type="button" class="btn btn-block" href="/VIG/myFeed/getMyFeedList.jsp">마이피드 목록</a>
			 				<br/>
			 				
			 			<a type="button" class="btn btn-block" href="/VIG/history/getMyHistoryList"> 내 활동 보기</a>
			 				<br/>
			 				
			 			<a type="button" class="btn btn-block" href="/VIG/user/updateUser">내 정보 수정</a>
			 				<br/>
			 				
			 			<a type="button" class="btn btn-block" href="#">결 제</a>
			 				<br/>	
			 					
			 			<a type="button" class="btn btn-block" href="/VIG/payment/getPaymentList"> 내 결제 목록</a>
			 				<br/>				
			 <!-- 비지니스 유저만 통계-->
			 		<c:if test="${sessionScope.user.role=='business'}">
			 			<a type="button" class="btn btn-block" href="/VIG/chart/getChart">통 계</a>
			 				<br/>	
				 		</c:if>							
				 		</c:when>
				 		</c:choose>
				 		
			<!-- 관리자 로그인시 --> 		
			 		<c:if test="${sessionScope.user.role=='admin'}">
			 			<a type="button" class="btn btn-block" href="/VIG/user/getUserList">회원 목록</a>
			 				<br/>
			 			<a type="button" class="btn btn-block"href="/VIG/report/getReportlist.jsp">신고 조회</a>
			 				<br/>
			 			<a type="button" class="btn btn-block" href="/VIG/payment/getAllPaymentList">결제 조회</a>
			 				<br/>
			 		</c:if>		
			 		</c:when>
			 		</c:choose>
			 		
			</div>
		</div>	
	</div>

</body>
</html>