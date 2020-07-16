<%@ page contentType="text/html; charset=UTF-8" %>

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
		
		<link href="/css/left.css" rel="stylesheet" type="text/css">
	
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
	/*
		//==> jQuery 적용 추가된 부분
		 $(function() {
			 
			//==> login Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$( "td[width='115']:contains('login')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td[width='115']:contains('login')" ).html() );
				$(window.parent.frames["rightFrame"].document.location).attr("href","/user/login");
			});
			
			
			//==> logout Event 연결처리부분
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$( "td[width='56']:contains('logout')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td[width='56']:contains('logout')" ).html() );
				$(window.parent.document.location).attr("href","/user/logout");
			}); 
			
			
		 	 $( ".navbar-brand:contains('VIG')" ).on("click" , function() {
		 		 self.location = "/main/main.jsp"
		 	 });
		});	
		*/
		
	</script>		
	
</head>
		 
<body>

<!-- JQuery -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	

<!--Navbar -->	
		<div class="container-lg">
			<nav class="mb-1 navbar fixed-top navbar-expand-lg navbar-dark secondary-color lighten-1">
<!-- 로고 -->		
			  <a class="navbar-brand" href="/main/main.jsp">VIG</a>
			  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-333"
			    aria-controls="navbarSupportedContent-333" aria-expanded="false" aria-label="Toggle navigation">
			    <span class="navbar-toggler-icon"></span>
			  </button>
			  <div class="collapse navbar-collapse" id="navbarSupportedContent-333">
			    <ul class="navbar-nav ml-auto nav-flex-icons"></ul>
			   </div>
<!-- 검색 버튼-->    
	      <li class="nav-item">
	        <a class="nav-link waves-effect waves-light" href="/searchPage/sMain.jsp">
	          <i class="fas fa-search"></i>
	        </a>
	      </li>
<!-- 알람버튼 -->     
	      <li class="nav-item dropdown">
	        <a class="nav-link waves-effect waves-light" id="dropdownMenu3" data-toggle="dropdown"
	 		   aria-haspopup="true" aria-expanded="false">
	          <i class="fas fa-bell"></i>
	        </a>
	        <div class="dropdown-menu" aria-labelledby="dropdownMenu3">
			    	<h6 class="dropdown-header">like</h6>
			    <div class="dropdown-divider"></div>
				   	 <a class="dropdown-item" href="#">--</a>
				   	 <a class="dropdown-item" href="#">--</a>
			    <div class="dropdown-divider"></div>
			   		 <a class="dropdown-item" href="#">--</a>
		  </div>
	     </li>
<!-- 채팅버튼 -->      
	        <li class="nav-item">
	        <a class="nav-link waves-effect waves-light" href="#">
	          <i class="fas fa-comments"></i></a>
	      </li>
<!-- 로그인 버튼 -->    
			<li class="nav-item">
	         <a class="nav-link waves-effect waves-light" href="addUser.jsp" >
	          <i class="fas fa-user"></i>
	        </a>
	       </li>
	      </nav>
	     </div>
	        
	        


			 <!-- 
	       <li class="nav-item dropdown" >
	        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
          aria-haspopup="true" aria-expanded="false">
	        <i class="fas fa-user"></i>
	        </a>
	        <div class="dropdown-menu dropdown-default" aria-labelledby="navbarDropdownMenuLink-333">
	  
	      <c:if test="${ empty user }"></c:if>   
		               <a class="dropdown-item" href="/user/loginView.jsp" target="rightFrame">login</a>
		   <c:if test="${ ! empty user }"></c:if>
		 			  <a class="dropdown-item" href="/logout.do" target="rightFrame">logout</a>   
	       </div>
	
	      </li>
	    </ul>
	  </div>
	</nav>
	<!--/.Navbar -->
	<br/>	
</body>
</html>