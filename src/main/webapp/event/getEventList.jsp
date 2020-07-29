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
	  border: 1px solid rgb(0, 0, 0);
	}


</style>


<script type="text/javascript">


</script>


</head>
<body>

	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />
	
	
	<div class="row">
	
	
	<div id="main" class="container-fluid">


	
	
	<c:forEach var="event" items="${list}">
	
		<c:set var="i" value="0"/>
		<c:set var="i" value="${i+1 }"/>
		<div class="col-12">
		 <div class="media position-relative">
		  <img id="thumb" class="d-flex mr-3" style="height: 150px; width: 200px" src="/images/uploadFiles/${event.eventThumb }"
		    alt="image">
		
		  <div class="media-body">
		  	<br>
		    <h5 class="mt-0">${event.eventTitle }</h5>
		    <p> ${event.eventSub }</p>
		    	<p><strong>기 간</strong>       ${event.eventStart}    ~    ${event.eventEnd}</p>
		    <a href="./getEvent?eventId=${event.eventId}" class="stretched-link"></a>
		  </div>
		</div>
		<hr>
		<br/>
    </div>
  	</c:forEach>
	</div>
		
		
	
	
	
	</div>
	

</body>
</html>