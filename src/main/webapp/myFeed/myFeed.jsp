<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

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
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script>

//===iframe 각 메뉴 페이지로 navigation
	function nav_myFeedList(url) {
	$('#my_frame').attr('src', url);	
	}	
	function nav_history(url) {
		$('#my_frame').attr('src', url);
	}
	//====나중에 연결(결제 페이지+통계페이지)
	//function nav_payment(url) {
	//	$('#my_frame').attr('src', url);
	//}
//	function nav_chart(url) {
//		$('#my_frame').attr('src', url);
//	}
	function nav_PaymentList(url) {
		$('#my_frame').attr('src', url);
	}
	///////////////////
	function nav_getUserList(url) {
		$('#my_frame').attr('src', url);
	}
	function nav_getReportlist(url) {
		$('#my_frame').attr('src', url);
	}
	function nav_getAllPaymentList(url) {
		$('#my_frame').attr('src', url);
	}
	
		
//===페이지 로드시 바로 보여줄 화면
	$(function(){
		$(document).ready(function() { 		
			if(${sessionScope.user.role =='admin'}){
				iframe.location.href="/VIG/user/getUserList.jsp";
			}else{
				iframe.location.href="/VIG/myFeed/myFeedList.jsp";
			}
		});
	});
//==========
	
	
	</script>
	
<!-- style part======================== -->	
	<style>
	
		.col-md-10{
			border:0;
		}
		.col-md-2{
			padding:100px 0 0 20px; background-color; height: 100%; border-right: 2px solid;
		}
		.card-img-top{
			padding:0;
		}
		#pImg{
			display:block; margin-left:auto; margin-right:auto; width: auto; height: auto; 
			max-width: 150px; max-height: 150px; border-radius:50%;
		    }
		#my_frame{
			 padding:50px;
		}
		.btn.btn-block{
		   padding: 10px 0px; margin-left:auto; margin-right:auto; width: 200px;
		}
		#sns_nav{
		   display:flex; margin-left:auto; margin-right:auto;
		   flex-direction: row; justify-content: center;
		}
		.fab{	    
		    flex-direction: row; justify-content: center;		
		}		
		
		/* 버튼 CSS */
		.box_body {

  box-sizing: border-box;
  font-family: "Futura PT", "Futura", sans-serif;
  -webkit-font-smoothing: antialiased;
}

/* Buttons at the center */
.wrap {
  position: absolute;
  top: 50%;
  left: 50%;
  margin-top: -259px;
  margin-left: -89px;
  text-align: center;
}

/* General styling for the links */
#btn_ch {
  padding: 15px 50px;
  text-decoration: none;
  font-size: 18px;
  display: block;
  margin: 20px 20px;
}


.btn:hover, .btn:link:hover, .btn:visited:hover {
  box-shadow: 0 4em 0 0 #2c3e50 inset, 0em 0em 0 0 #bbb;
  -webkit-transform: translate(0.3em, 0.2em);
          transform: translate(0.3em, 0.2em);
  color: #fff;
}


.btn3, .btn3:link, .btn3:visited {
  color: #333;
  font-size: .8em;
  text-transform: uppercase;
  min-width: 100px;
  max-width: 60%;
  position: relative;
  margin: 0 auto;
  border: 2px solid transparent;
  -webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);
  transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);
}
.btn3:after, .btn3:before, .btn3:link:after, .btn3:link:before, .btn3:visited:after, .btn3:visited:before {
  content: "";
  position: absolute;
  letter-spacing: .1em;
  left: -1em;
  top: -2px;
  height: 3em;
  width: 0;
  border: 1px solid #c75842;
  -webkit-transition: inherit;
  transition: inherit;
}
.btn3:after, .btn3:link:after, .btn3:visited:after {
  left: auto;
  right: -1em;
}
.btn3:hover, .btn3:link:hover, .btn3:visited:hover {
  border-color: #c75842;
  -webkit-transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);
  transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);
}
.btn3:hover:after, .btn3:hover:before, .btn3:link:hover:after, .btn3:link:hover:before, .btn3:visited:hover:after, .btn3:visited:hover:before {
  right: -2px;
  -webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);
  transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);
}
.btn3:hover:before, .btn3:link:hover:before, .btn3:visited:hover:before {
  left: -2px;
  right: auto;
}

@-webkit-keyframes gelatine {
  from,to {
    -webkit-transform: scale(1, 1);
  }
  25% {
    -webkit-transform: scale(0.9, 1.1);
  }
  50% {
    -webkit-transform: scale(1.1, 0.9);
  }
  75% {
    -webkit-transform: scale(0.95, 1.05);
  }
  from,to {
    -webkit-transform: scale(1, 1);
  }
  25% {
    -webkit-transform: scale(0.9, 1.1);
  }
  50% {
    -webkit-transform: scale(1.1, 0.9);
  }
  75% {
    -webkit-transform: scale(0.95, 1.05);
  }
}
@keyframes gelatine {
  from,to {
    -webkit-transform: scale(1, 1);
    transform: scale(1, 1);
  }
  25% {
    -webkit-transform: scale(0.9, 1.1);
    transform: scale(0.9, 1.1);
  }
  50% {
    -webkit-transform: scale(1.1, 0.9);
    transform: scale(1.1, 0.9);
  }
  75% {
    -webkit-transform: scale(0.95, 1.05);
    t}
	/* 버튼 CSS */
	
		
	</style>
</head>

<body>
<!-- 상단 툴바 ================================================= -->
			<div class="row">
			<jsp:include page="/main/toolbar.jsp"></jsp:include>
			</div>
		
<!-- 왼쪽 사이드 메뉴 시작 ========================================= -->	
 	<!-- 프로필 이미지 -->						
 		<div class="row">
 			<div class="col-md-2 "> 							
 				<img class="card-img-top" src="/VIG/images/uploadFiles/profile_img.jpg" id="pImg" alt="profile_img">
 	<!-- 프로필 내용 -->
 				<div class="card-body">
 				${sessionScope.user.role}
 					<h4 class="user_name" align="center"> ${user.userName} </h4>
 					<hr>
 					<p class="user_bio" align="center"> ${user.selfIntroduce} </p>
 					<br><br/>
 			<!-- 소셜 아이콘 이미지 변경하기 -->
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
 				</div>
 	<!-- 메뉴 네비게이션 -->
 			<c:choose>
			<c:when test="${sessionScope.user.role=='user' || sessionScope.user.role=='business'}">
 					<div class="box_body">
		<div class="wrap">
 					<a id="btn_ch" class="btn3" onclick='nav_myFeedList("/VIG/myFeed/myFeedList.jsp")'>
 						마이피드 목록</a>
 					<br/>
 					<a id="btn_ch" class="btn3" onclick='nav_history("/VIG/history/getMyHistoryList")'>
 						내 활동 보기</a>
 					 <br/>
 					 <a id="btn_ch" class="btn3" onclick='nav_history("/VIG/user/updateUser.jsp")'>
 						내 정보 수정</a>
 					 <br/>
 					<a id="btn_ch" class="btn3" onclick='nav_payment("")'>
 						결 제</a>
 					<br/>
 			
 					<a id="btn_ch" class="btn3" onclick='nav_PaymentList("/VIG/payment/getPaymentList")'>
 						내 결제 목록</a>
 					<br/>
 					</div>
 					</div>
 		<!-- 비지니스 유저만 통계-->
 				<c:if test="${sessionScope.user.role=='business'}">
 					<button type="button" class="btn btn-block" onclick='nav_chart("/VIG/chart/chart.jsp")'>
 						<a href="#">통 계</a></button>
 					<br/>	
 				</c:if>	
 										
 				</c:when>
 				<c:when test="${sessionScope.user.role=='admin'}">
 				<button type="button" class="btn btn-block" onclick='nav_getUserList("/VIG/user/getUserList.jsp")'>
 						회원 목록</button>
 					<br/>
 			<button type="button" class="btn btn-block" onclick='nav_getReportlist("/VIG/report/getReportlist.jsp")'>
 						신고 조회</button>
 					<br/>
 			<button type="button" class="btn btn-block" onclick='nav_getAllPaymentList("/VIG/payment/getAllPaymentList.jsp")'>
 						결제 조회</button>
 					<br/>
 				</c:when>	
 				</c:choose>
				</div>
		<!-- 왼쪽 네비 페이지 불러올 iframe-->
					<iframe id='my_frame' target="iframe" name="iframe" class="col-md-10 " border="0" ></iframe>
						
				</div>
								
 		</body>
 	</html>
 					
 			