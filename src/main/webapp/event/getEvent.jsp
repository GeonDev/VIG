<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>VIG</title>

	
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

	
<style>
	body {
	
	margin-top: 70px;
	
	}
	
	#outline {
	
		width: 1300px;
		margin: 0 auto;
	
	}
	
	#main { 
		
		width: 960px;
		margin: 0 auto;
		align: center;
		
	}
	
	#inline {
		
		width: 1150px;
		margin: 0 auto;
	
	}
	
	#evimg {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	}
	
	.btn {
		font-size: 13px; 
		padding: 10px 10px;
		
	
	}


</style>


<script type="text/javascript">

$(function(){
	
	$("#delete").on("click", function(){
		
		self.location="/VIG/event/deleteEvent?eventId=${event.eventId}";
		
	});
	
	$("#update").on("click", function(){
		
		self.location="/VIG/event/updateEvent?eventId=${event.eventId}";
		
	});
	
	$(".fa-bars").on("click", function(){
		
		self.location="/VIG/event/getEventList";
		
	});
	
	
})


</script>


</head>
<body>

	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />
	
	<div id="outline">
	<br>
	<br>
	<dl class="row">
	<dt class="col-sm-10"> <h1> 이벤트 상세보기 </h1> </dt>
	<dt class="col-sm-2"> 
	<c:if test="${user.role=='admin'}">
		<input type="button" class="btn btn-dark" value="수정" id="update"> 
		<input type="button" class="btn btn-outline-danger waves-effect" value="삭제" id="delete"> 
	</c:if>
	<i style="font-size:25px; align: right" class="fas fa-bars"></i>
	</dt>
	
	</dl>
	<hr/>
	
	<div id="main">
	
	<br/>
	<br/>
	
	
	
	<h2>  ${event.eventTitle}</h2>
	<br>
	<!-- Medium input -->
	<h5> ${event.eventSub}</h5>
	

	<!--  이벤트 본문 -->
	<hr/>
		<img id="evimg" src="/VIG/images/others/${event.eventImage}" style="width:960px" class="img-rounded"/>
	<hr/>
	<br/>
	

		
			<!-- 이벤트 정보 -->
			<dl class="row">
				  <dt class="col-sm-2">태그</dt>
				  <dd class="col-sm-10">${event.eventTags }</dd>
			 </dl>
			 <dl class="row">
				  <dt class="col-sm-2">기간</dt>
				  <dd class="col-sm-10">${event.eventStart}&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;${event.eventEnd }</dd>
			 </dl>


	<br/>
	
	</div>
	<div id="inline">
			<hr/>
			<br/>
			<div style="align:center;">
			<h3 align="center"> 참가 작품 모아보기 </h3>
			<br>
			<br>
			</div>
			<c:if test="${empty feedList }">
			<div align="center">
			아직 등록된 피드가 없습니다.
			</div>
			</c:if>
			<c:if test="${!empty feedList }">
			<c:forEach var="feeds" items="${feedList}">
				
			
			</c:forEach>
			</c:if>
			
	
	</div>
	</div>

</body>
</html>