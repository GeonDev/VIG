<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>


	<script type="text/javascript">
	
//===로그인
	$(function(){
		$("#login_btn").on("click",function(){
			$(self.location).attr("href","../user/login");
		});
//===로그아웃	
	$( "#logout_btn" ).on("click" , function() {
				//Debug..
				alert(  $( "logout" ).html() );
				$(self.location).attr("href","../user/logout");
			}); 
//==로고 클릭시 메인 페이지로
	$(".navbar-brand:contains('VIG')").on("click",function(){
		self.location="../main/main.jsp";
		});
	});
	</script>	
	<style>
	</style>	
	
</head>		 
<body>
	

<!--Navbar start-->	
			<nav class="mb-1 navbar fixed-top navbar-expand-xl navbar-dark indigo lighten-1 py-3" id="toolbar">			
<!-- 로고 -->		
			  <a class="navbar-brand"  >VIG</a>		  
			      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-4"
				    aria-controls="navbarSupportedContent-4" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				   <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
   					 <ul class="navbar-nav ml-auto">
				 </ul>		
<!-- 검색 버튼-->    	      
	        <a class="nav-link waves-effect waves-light" id="search_btn" href="#">
	          <i class="fas fa-search"></i>
	        </a>	   
<!-- 알람버튼 -->     
	        <a class="nav-link waves-effect waves-light" id="alarm_btn" href="#">
	          <i class="fas fa-bell"></i>
	        </a>        
<!-- 채팅버튼 -->      
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="#">
	          <i class="fas fa-comments"></i></a>
<!-- 로그인 버튼 -->   			
			 <c:if test="${ empty user }"> <span id="login_btn">login/sign up</span></c:if> 
			 <c:if test="${ !empty user }"> <span id="logout_btn">logout</span></c:if>
	     	</div>
	      </nav>
		<br/>
		
</body>
</html>