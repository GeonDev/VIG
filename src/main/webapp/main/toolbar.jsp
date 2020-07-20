<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<title>VIG</title>

	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript">
		
	</script>	
	<style>
		#toolbar{
			margin:100;
		}
	</style>	
	
</head>		 
<body>
	

<!--Navbar start-->	
			<nav class="mb-1 navbar fixed-top navbar-expand-xl navbar-dark indigo lighten-1 py-3" id="toolbar">			
<!-- 로고 -->		
			  <a class="navbar-brand" href="main.jsp" >VIG</a>		  
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
			<a class="nav-link waves-effect waves-light" data-toggle="modal" data-target="#modalLoginForm"  href="#">
	          <i class="fas fa-user"></i>
	        </a>
	      </nav>
		<br/>
		
</body>
</html>