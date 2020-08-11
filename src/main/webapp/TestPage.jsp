
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
	.dropdown-menu.sideBar.show { position: absolute; transform: translate3d(14px, 675px, 0px); top: 0px; left: 0; will-change: transform; width: 91%;}
	#btn_ch {margin: auto; margin: 10px 0px;}
		
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
			 					<p class="sign_date" align="center"> Member Since :: ${writer.regDate}</p>
			 			</div>	
			 			<br/>		
			 		</c:when>
	 	
					<c:when test="${user.userCode ==user.userCode}">					
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
 				
					
						<div class="wrap">
		 					<a id="btn_ch default" class="btn btn-block" href="/VIG/myfeed/getMyFeedList?userCode=${user.userCode}" style="width: 222%; margin: 10px 0px;">
		 						마이피드 목록</a>
		 					<br/>
		 					<a id="btn_ch default" class="btn btn-block" href="/VIG/history/getMyHistoryList?userCode=${user.userCode}" style="width: 222%; margin: 10px 0px;">
		 						내 활동 보기</a>
		 					 <br/>
		 					 <a id="btn_ch default" class="btn btn-block" href="/VIG/user/updateUser?userCode=${user.userCode}" style="width: 222%; margin: 10px 0px;">
		 						내 정보 수정</a>
		 					 <br/>	
		 					 </div>
				 				
 					
				
			 		<c:if test="${sessionScope.user.role=='business'}">
			 			<a id="btn_ch" class="btn btn-block" href="/VIG/chart/getChart">통 계</a>
			 				<br/>	
				 	</c:if>							
				 	
 					
 			<button class="btn btn-block dropdown-toggle" id="btn_ch" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">결 제</button>
				
				<div class="dropdown-menu sideBar">
				
				<c:if test="${sessionScope.user.role=='user'}">
				 <a class="dropdown-item sideBar" id="btn_ch" href="/VIG/payment/getPaymentList" style="text-align: center;">내 결제 목록</a>
				  </c:if>
				  
				  <c:if test="${sessionScope.user.role=='business'}">
				  <a class="dropdown-item sideBar" id="btn_ch"  href="/VIG/payment/getPaymentList" style="text-align: center;">내 결제 목록</a>
				  <div class="dropdown-divider"></div>
				  <a class="dropdown-item sideBar" id="btn_ch" href="/VIG/withdraw/getDonationList" style="text-align: center;">후원 받은 목록</a>
				  </c:if>
				  
				</div>					
		 			<br/>		 			
		 			</c:when>		 			
		 			</c:choose>	
		 	</div>
		 		
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
	
			 		
			 	
			 		
	

</body>
</html>