<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- Font Awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<!-- Bootstrap core CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
				
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<script type="text/javascript">
$(function() {
//===모달창 띄우기
	//$( "#login_btn:contains('Log in')" ).on("click" , function() {
	//	$(self.location).attr("href","/VIG/user/login");
	//	}); 
	$( "#login_btn:contains('Log in')" ).click( function() {
		$('div.modal').modal({
		});
	});

	
//===로그아웃	
	$( "#logout_btn:contains('Log Out')" ).on("click" , function() {
			$(self.location).attr("href","/VIG/user/logout");
			}); 
		});	
		
		//로그인
		$(".btn.btn-info").on("click",function(){
			$("#userCode").focus();	
			$("#login").on("click" , function() {
				
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userCode").focus();
					return;
				}
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				$.ajax({
					url:"json/login",
					method:"POST",
					data:({userCode : id, password : pw}),
					success:function(){
						
					}
				})
				
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
	        </a>        
<!-- 채팅버튼 -->      
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="#">
	          <i class="fas fa-comments" id="fas_ntn"></i></a>
   	
<!-- //비로그인 상태 -->
			<c:if test="${empty sessionScope.user }"> 
			  <a id="login_btn" data-toggle="modal" data-target="#testModal" data-id="1"><span>Log in</span></a>
			  
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
	
	<form name="modalLogin" method ="POST" action="login" >
<div class="modal fade" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
	<div class="container">
		<div class="text-center border border-light p-5">
  			<div class="row">
    <p class="h4 mb-6">Login</p>
			
			
    <!-- id -->
	    <input type="text" id="userCode" name="userCode" class="form-control mb-5" placeholder="id" required>
	    <span class="glyphicon glyphicon-ok form-control-feedback"></span>

    <!-- Password -->
   		<input type="password" id="password" name="password" class="form-control mb-2" placeholder="Password" required>
		<c:if test="${msg == 'fail' }">
    		<div class="fail_text" style="color:red">
    		아이디 또는 비밀번호를 확인해주세요.
    		</div>
    		</c:if>


    <!-- Sign in button -->
    	<button  class="btn btn-info btn-block my-4" id="login" >Sign in</button>
    
    <!-- Register -->
  
	    <p>Not a member?
	        <!-- <a href="../user/addUser">Register</a> -->
	        <span id="ty" class="blue-text ml-1"  >Register</span>
	    </p>
	    
	</div>
	</div>
	</div>

      </div>
    </div>
  </div>
</div>
</form>
	
</body>


</html>