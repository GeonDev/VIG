<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>addEventView</title>

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
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Bootstrap tooltips -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

	
<style>
	
	#outline {
	
		width: 1300px;
		margin: 0 auto;s
	
	}
	
	#main { 
		
		width: 960px;
		margin: 0 auto;
		
	}
	
	img {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  border: 1px solid rgb(0, 0, 0);
	}


</style>


<script type="text/javascript">

$(function(){
	
	$("#delete").on("click", function(){
		
		self.location="/VIG/event/deleteEvent?eventId=${event.eventId}";
		
	});
	
	
})


</script>


</head>
<body>


<!--Navbar-->
<nav class="navbar navbar-light purple lighten-4 mb-4">

  <!-- Navbar brand -->
  <a class="navbar-brand" href="#">Navbar</a>

  <!-- Collapse button -->

</nav>
<!--/.Navbar-->

	
	<div id="outline">
	<br>
	<br>
	<dl class="row">
	<dt class="col-sm-10"> <h1> 이벤트 상세보기 </h1> </dt>
	<dt class="col-sm-2"> <input type="button" value="삭제" id="delete"> </dt>
	<hr>
	<br>
	<br>
	<div id="main">

	
	
	
	<h2>  ${event.eventTitle}</h2>
	<br>
	<!-- Medium input -->
	<h5> ${event.eventSub}</h5>
	

	
	<hr/>
		<img src="C:/uploadFiles/${event.eventImage}" style="width:960px" class="img-rounded"/>
	<hr/>
	<br/>
	

		
			
			<dl class="row">
			  <dt class="col-sm-2">태그</dt>
			  <dd class="col-sm-10">${event.eventTags }</dd>
			 </dl>
			 <dl class="row">
				  <dt class="col-sm-2">기간</dt>
				  <dd class="col-sm-10">${event.eventStart}&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;${event.eventEnd }</dd>
			 </dl>

	</div>
	<br>
	<hr>
	<br>
	
	
	</div>

</body>
</html>