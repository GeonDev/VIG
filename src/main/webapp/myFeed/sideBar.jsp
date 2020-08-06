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
	#sideBar { padding: 0; margin:0;}
	</style>
	
</head>
<body>

<!-- 상단 툴바 자리 -->
      <div class="container-fluid">  
      	<div class="row_toolbar_top_">
 	
      </div>
		</div>
		
<!-- 사이드바  시작-->    
 <div class="row" id="sideBar">

		<img class="card-img-top" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg" alt="profile_img">
 			<div class="card-body">
 					<h4 class="user_name" align="center"> ${user.userName} </h4>
 					<hr>
 					<p class="user_bio" align="center"> ${user.selfIntroduce} </p>
 					<br><br/>
 					
 <!-- 소셜 링크 아이콘/추후 수정  -->				
		<c:if test="${sessionScope.user.role=='user' || sessionScope.user.role=='business'}">
 			<div class="row" id="sns_nav">
 				<i class="fab fa-facebook-f fa-lg blue-text ml-3 mr-3 fa-1x"></i>
 				<i class="fab fa-twitter fa-lg blue-text ml-3 mr-3  fa-1x"></i>
 				<i class="fab fa-instagram fa-lg blue-text ml-3 mr-3 fa-1x"></i>
 			</div>
 			<br/>
 				<p class="sign_date" align="center"> Member Since :: ${user.regDate}</p>
 		</c:if>		
 			<hr/><br/>

 <!-- 메뉴 네비게이션 -->                                													 <!-- 코드 정리하기 -->
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
 			<a type="button" class="btn btn-block" href="#">통 계</a>
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
 			<a type="button" class="btn btn-block" href="/VIG/payment/getAllPaymentList.jsp">결제 조회</a>
 				<br/>
 		</c:if>	
	</div>
	</div>


</body>
</html>