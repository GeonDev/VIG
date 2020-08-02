<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>

<script type="text/javascript">
$(function() {
//===로그인
	$( "#login_btn:contains('Log in')" ).on("click" , function() {
		$(self.location).attr("href","/VIG/user/login");
		}); 
	
	
//===로그아웃	
	$( "#logout_btn:contains('Log Out')" ).on("click" , function() {
			$(self.location).attr("href","/VIG/user/logout");
			}); 
		});	
	</script>	
	
	<style>
	
	#logoTop{
	 width: 90px;
	 height: 40px;
	}
	#login_btn , #logout_btn{
	color: white;
	}
	#fas_ntn{
	color: #ffb74d;
	}
	p{
	color: black;
	}
	#logout_btn{
	margin-left:50px;
	}
	#logout_btn{
	margin:0;
	}
	</style>	
	
</head>		 
<body>
	

<!--Navbar start-->	
			<nav class="mb-1 navbar fixed-top navbar-expand-xl navbar-dark bg-dark py-2" id="toolbar">			
<!-- 로고 -->		
			  <a href="/VIG/main/VIG"><img src='/VIG/images/others/VIG_logo.png' id="logoTop" alt="VIG" ></a>
			      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="toolbar_logo"
				    aria-controls="toolbar_logo" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				   <div class="collapse navbar-collapse" id="toolbar_logo">
   					 <ul class="navbar-nav ml-auto">
				 </ul>		
<!-- 검색 버튼-->    	      
	        <a class="nav-link waves-effect waves-light" id="" href="/VIG/search/getSearchList">
	          <i class="fas fa-search" id="fas_ntn"></i>
	        </a>	   
<!-- 알람버튼 -->     
	        <a class="nav-link waves-effect waves-light" id="alarm_btn" href="#">
	          <i class="fas fa-bell" id="fas_ntn"></i>
	          <span class="badge badge-pill badge-danger">1</span>
	        </a>        
<!-- 채팅버튼 -->      
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="#">
	          <i class="fas fa-comments" id="fas_ntn"></i></a>
   	
<!-- //비로그인 상태 -->
			<c:if test="${empty sessionScope.user }"> 
			  <a href="#" id="login_btn" >Log in</a>
			</c:if> 
<!-- //로그인 후 드롭다운 -->
		<!-- 유저 로그인시 -->
			<c:if test="${ sessionScope.user.role == 'user' || sessionScope.user.role == 'business'}"> 
				<li class="dropdown">
		             <a href="#" class="dropdown-toggle" id="login_dropdown" data-toggle="dropdown"
						 role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user"></i>
						   <span class="caret"></span>
					</a>
		         <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="login_dropdown">
					<h6 class="dropdown-header">${user.userCode }</h6>
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/myFeed/myFeed.jsp" >My Feed</a>
						    <a class="dropdown-item" href="#">Upload</a>
						  <div class="dropdown-divider"></div>
						      <a class="dropdown-item" id="logout_btn" ><p>Log Out</p></a>
				 </div>
		       </c:if>
		   <!-- 관리자 로그인시 -->
		       <c:if test="${ sessionScope.user.role == 'admin'}"> 
				<li class="dropdown">
		             <a href="#" class="dropdown-toggle" id="login_dropdown" data-toggle="dropdown"
						 role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user"></i>
						   <span class="caret"></span>
					</a>
		         <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="login_dropdown">
					<h6 class="dropdown-header">${user.userCode }</h6>
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/myFeed/myFeed.jsp">관리자페이지</a>	
						    <div class="dropdown-divider"></div>
						      <a class="dropdown-item"  id="logout_btn" ><p>Log Out</p></a>					   
				 </div>
		       </c:if>
		    <!-- 로그아웃 버튼 -->          
				
			     
				
		
	     	</div>
	      </nav>
		<br/>
	
</body>
</html>