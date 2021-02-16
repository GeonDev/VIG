<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>VIG</title>

<!-- JQuery -->
	
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
	<!-- Google Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	<!-- Bootstrap core CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
	<!-- Material Design Bootstrap -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
	
		<!-- JQuery -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	

	

	
<style>
	body {
	
	margin-top: 70px;
	
	
	}
	
	#main { 
		width: 720px;
		margin-top: 70px;
		margin: 0 auto;
	}
	
	#thumb {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  
	}
	.eventmenu {
	
		padding : 5px;
		font-weight: bold;
	
	}
	.eventmenu:hover{
	
		background-color: #D0F1F8;
	
	}
	.eventmenu:click{
	
		background-color: #D0F1F8;
	}
	
	.top {
	  position: fixed;
	  right: 10%;
	  bottom: 50px;
	  display: none;
	  font-size: 45px;
	 
	}
	.fa-arrow-alt-circle-up{
	  color: #FBA635;
	
	}



</style>


<script type="text/javascript">
$(function(){
//scrollTop 부드럽게 이동하는 부분
$( window ).scroll( function() {
	if ( $( this ).scrollTop() > 200 ) {
		$( '.top' ).fadeIn();
	} else {
		$( '.top' ).fadeOut();
	}
} );

//스크롤탑 애니메이션
$( '.top' ).click( function() {
	$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
	return false;
} );

//진행중인 이벤트
$('.ing').on("click", function(){
		
	self.location="/event/getEventList?keyword=0";

});

//당첨자 발표
$('.announce').on("click", function(){
	
	self.location="/event/getEventList?keyword=1";
	
});
//종료된 이벤트
$(".fin").on("click", function(){
	
	self.location="/event/getEventList?keyword=2";
	
});

//메뉴 클릭시 색상 유지
var eventmenu = ${search.keyword};

if(eventmenu == 0) {
	
	$(".ing").attr("style", "background-color: #D0F1F8");
	
} else if(eventmenu == 1){
	
	$(".announce").attr("style", "background-color: #D0F1F8");
	
} else if(eventmenu == 2) {
	
	$(".fin").attr("style", "background-color: #D0F1F8");
}

//이벤트 등록으로 ㄱㄱ

$("#addEvent").on("click", function(){
	
	self.location="/event/addEvent";
	
});


});



</script>


</head>
<body>

	<!-- 툴바 include -->
	<jsp:include page="../mainView/toolbar.jsp" />
	
	<div class="top">
	<i class="fas fa-arrow-alt-circle-up"></i>
	</div>
	
	<div class="container">
	<div class="row">
	
	<div class="md-5" style=" height: 500px; border-right: 1px solid #D3DEE1; padding: 10px">
	<div style="font-size: 30px; font-weight: bold"> EVENT </div>
	<hr>
	<div class="eventmenu ing"> 진행중인 이벤트 </div>
	<div class="eventmenu announce"> 당첨자 발표 </div>
	<div class="eventmenu fin"> 종료된 이벤트 </div>
	<c:if test="${user.role=='admin'}">
	<button class="btn btn-elegant btn-sm" id="addEvent" style="font-size: 12px">등록하기<i class="fas fa-plus pl-1"></i></button>
	</c:if>
	</div>
	
	
	<div id="main" class="container-fluid">
	
	
	
	
	<c:forEach var="event" items="${list}">
	
		<c:set var="i" value="0"/>
		<c:set var="i" value="${i+1 }"/>
		<div class="col-12">


				 <div class="media position-relative">
				  <img id="thumb" class="d-flex mr-3" style="height: 150px; width: 200px" src="/images/others/${event.eventThumb }"
				    alt="image">

		
				  <div class="media-body">
				  	<br>
				    <h5 class="mt-0" style="font-weight: bold;">${event.eventTitle }</h5>
				    <p> ${event.eventSub }</p>
				    	<p><strong>기 간</strong>       ${event.eventStart}    ~    ${event.eventEnd}</p>
				    <a href="./getEvent?eventId=${event.eventId}" class="stretched-link"></a>
				  </div>

		</div>
		
		<hr>
		<br/>
    </div>
  	</c:forEach>
		
		  	<c:if test="${empty list }">
		  		<div style="text-align: center; vertical-align: middle; margin-top: 120px"> 등록된 이벤트가 없습니다. </div>
		  	</c:if>
		
	</div>
		
		
	
	
	
	</div>
	</div>


</body>
</html>