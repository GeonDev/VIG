<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>


<script type="text/javascript">

		
//===로그인
	
//===로그아웃	
	$( "#logout_btn:contains('Log Out')" ).on("click" , function() {
			$(location).attr("href","../user/logout");
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
	</style>	
	
</head>		 
<body>
	

<!--Navbar start-->	
			<nav class="mb-1 navbar fixed-top navbar-expand-xl navbar-dark bg-dark py-2" id="toolbar">			
<!-- 로고 -->		
			  <a href="/VIG/main/main.jsp"><img src='/VIG/images/others/VIG_logo.png' id="logoTop" alt="VIG" ></a>
			      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-4"
				    aria-controls="navbarSupportedContent-4" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				   <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
   					 <ul class="navbar-nav ml-auto">
				 </ul>		
<!-- 검색 버튼-->    	      
	        <a class="nav-link waves-effect waves-light" id="" href="/VIG/search/getSearchList">
	          <i class="fas fa-search" id="fas_ntn"></i>
	        </a>	   
<!-- 알람버튼 -->     
	        <a class="nav-link waves-effect waves-light" id="alarm_btn" href="#">
	          <i class="fas fa-bell" id="fas_ntn"></i>
	        </a>        
<!-- 채팅버튼 -->      
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="#">
	          <i class="fas fa-comments" id="fas_ntn"></i></a>
<!-- 로그인 버튼 -->   
				
			 <c:if test="${empty user}"> 
			  <a href="../user/login" id="login_btn" >Log in</a>
			</c:if> 
			
			 <c:if test="${!empty user}"> 
		       <div id="logout_btn" >Log Out</div>
			</c:if>	  

	     	</div>
	      </nav>
		<br/>
		
		
</body>
</html>