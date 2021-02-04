
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
	#pImg { display:block; margin-left:auto; margin-right:auto; width: auto; height: 150px; max-width: 150px; border-radius:50%; padding:0;}
	#sns_nav { display:flex; margin-left:auto; margin-right:auto; flex-direction: row; justify-content: center;}
	#sideBar { padding: auto; margin:auto; display: block;}

	.dropdown-menu.sideBar.show { position: absolute; transform: translate3d(14px, 675px, 0px); top: 0px; left: 0; will-change: transform; width: 91%;}
			
			
	.btn.btn-block {
    margin: .375rem;
    color: slategrey;
    text-transform: capitalize;
    word-wrap: break-word;
    white-space: inherit;
    cursor: pointer;
    border: 0;
    border-radius: .125rem;
   
    padding: .84rem 2.14rem;
	}
	.btn {
    margin: .375rem;
    color: black;
    text-transform: uppercase;
    word-wrap: break-word;
    white-space: normal;
    cursor: pointer;
    border: 0;
    border-radius: .125rem;
  
    padding: .84rem 2.14rem;
    font-size: .81rem;
	}
	.btn:hover, .btn:link:hover, .btn:visited:hover {
    box-shadow: 0 4em 0 0 #2c3e50 inset, 0em 0em 0 0 #bbb;
    color: #fafafa;
    background-color:#1C2331;
	}		
	</style>
	
</head>
<body>


    <div class="container-fluid">  
      	
<!-- 사이드바  시작-->    
		<div class="row" id="sideBar">
		
			<!-- 다른 유저의 마이 피드 방문시 해당 유저의 정보만 노출 -->
				<c:choose>
				<c:when test="${user.userCode != writer.userCode}">		
					<img class="card-img-top" src="res/images/uploadFiles/${writer.profileImg}" id="pImg" alt="profile_img">
			 			<div class="card-body">
			 					<h3 class="user_name" align="center"><strong>${writer.userName} </strong> </h3>			
			 					<p class="user_bio" align="center" > ${writer.selfIntroduce} </p>		 					
			 					<p class="sign_date" align="center"> Member Since :: ${writer.regDate}</p>			 					
			 			</div>	
			 			<br/>		
			 		</c:when>
			
					<c:when test="${user.userCode == writer.userCode}">			
						<img class="card-img-top" src="res/images/uploadFiles/${user.profileImg}" id="pImg" alt="profile_img"/>
				 			<div class="card-body">
				 					<h3 class="user_name" align="center" style="font-weight: bold;"> ${user.userName} </h3>				 					
				 					<p class="user_bio" align="center"> ${user.selfIntroduce} </p>
				 					<br>
				 					<c:if test="${sessionScope.user.role!='admin'}">
				 				<p class="sign_date" align="center" style="margin-bottom:30px;"> Member Since :: ${user.regDate}</p>	
				 				<br/>
				 				</c:if>
				 			</div>
				 		<br/>		
 				
					 <div class="box_body">
						 <c:if test="${sessionScope.user.role!='admin'}">
							<div class="wrap">
			 					<a id="btn_ch" class="btn btn-block" href="/vig/myfeed/getMyFeedList?userCode=${user.userCode}">
			 						마이피드 목록</a>
			 					<br/>
			 					<a id="btn_ch" class="btn btn-block" href="/vig/history/getMyHistoryList?userCode=${user.userCode}">
			 						내 활동 보기</a>
			 					 <br/>
			 					 <a id="btn_ch" class="btn btn-block" href="/vig/user/updateUser?userCode=${user.userCode}">
			 						내 정보 수정</a>
			 					 <br/>	
			 				 </div>
			 			 </c:if>
				 	</div>				
 					
 					
 					
			 		<c:if test="${sessionScope.user.role=='business'}">
			 			<a id="btn_ch" class="btn btn-block" href="/vig/chart/getChart">통 계</a>
			 				<br/>	
				 	</c:if>							
				 	
 					
 				<c:if test="${sessionScope.user.role!='admin'}">
 					<button class="btn btn-block dropdown-toggle" id="toggleID" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">결 제</button>
				</c:if>
				
				<div class="dropdown-menu sideBar">
				
				<c:if test="${sessionScope.user.role=='user'}">
				 <a class="dropdown-item" id="toggleID" href="/vig/payment/getPaymentList" style="text-align: center;">내 결제 목록</a>
				  </c:if>
				  
				  <c:if test="${sessionScope.user.role=='business'}">
				  <a class="dropdown-item" id="toggleID" href="/vig/payment/getPaymentList" style="text-align: center;">내 결제 목록</a>
				  <div class="dropdown-divider"></div>
				  <a class="dropdown-item" id="toggleID" href="/vig/withdraw/getDonationList" style="text-align: center;">후원 받은 목록</a>
				   <div class="dropdown-divider"></div>
				  <a class="dropdown-item" id="toggleID" href="/vig/withdraw/getWithdrawList" style="text-align: center;">내 출금 목록</a>
				  </c:if>
				  
				</div>
 					
		 			<br/>
		 			
		 			</c:when>
		 			
		 			</c:choose>
		 			
		 		</div>
		 	</div>
 				
 		
			 		
			<!-- 관리자 로그인시 --> 		
			 		<c:if test="${sessionScope.user.role=='admin'}">
			 			<a type="button" class="btn btn-block" href="/vig/user/getUserList">회원 목록</a>
			 				<br/>
			 			<a type="button" class="btn btn-block"href="/vig/report/getReportList">신고 조회</a>
			 				<br/>
			 			<a type="button" class="btn btn-block" href="/vig/payment/getAllPaymentList">결제 조회</a>
			 				<br/>
			 			<a type="button" class="btn btn-block" href="/vig/withdraw/getWithdrawList">출금 조회</a>
			 				<br/>	
			 		</c:if>	
			
	
			 		
			 	
			 		
	

</body>
</html>