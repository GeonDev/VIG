<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>

		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
				
	<!-- JQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	<script type="text/javascript">
	
//===로그인
	$(function(){
		$(".login_btn").on("click",function(){
			self.location="../user/loginView.jsp";
		});
//===로그아웃	
	$( ".logout_btn" ).on("click" , function() {
				//Debug..
				alert(  $( "logout" ).html() );
				$(self.location).attr("href","../user/logout");
			}); 
//==로고 클릭시 메인 페이지로
	$(".navbar-brand:contains('VIG')").on("click",function(){
		self.location="../main/main.jsp";
		});
		
		
		$(".modal-content").load("/loginModal");
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
				  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-333"
				    aria-controls="navbarSupportedContent-333" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				  <div class="collapse navbar-collapse" id="navbarSupportedContent-333">
				    <ul class="navbar-nav ml-auto nav-flex-icons"></ul>
				  </div>
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
			 <c:if test="${ empty user }"> <span class="login_btn">in</span></c:if> 
			 <c:if test="${ ! empty user }"><span class="logout_btn">out</span></c:if>
	     	
	     	<!-- 모달띄우는 버튼 -->
	     	<a id="login" data-toggle="modal" data-target="#modal" role="button" data-remote="/user/loginView.jsp"> 
	     	<span class="login_btn">modal!!</span></a>
	     	
	     	<!-- 모달 불러오려는 화면 -->
	     	<div id="modal" class="modal fade" tabindex="-1" role="dialog">
	     		<div class="modal-dialog">
	     			<div class="modal-content">
	     			</div>
	     		</div>
	     	</div>
	     	
	     	
	      </nav>
		<br/>
		
</body>
</html>