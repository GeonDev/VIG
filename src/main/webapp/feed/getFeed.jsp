<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>getFeed</title>

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
	
	body {
	
	}
	
	#outline {
	
		width: 1300px;
		margin: 0 auto;
	
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
	
	#profile {
		width: 55px;
		height: 55px;
	
	}

</style>


<script type="text/javascript">

$(function(){
	

	
	
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

	<div id="main">
	
	<br/>
	<br/>
	
	
	
	<h2> <strong> ${feed.feedTitle} </strong></h2>
	<br>
	<!-- Medium input -->
	<h5> ${feed.feedExplanation}</h5>
	

	
	<hr/>
	<c:forEach var="images" items="${feed.images}">
		<c:set var="i" value="0"/>
		<c:set var="i" value="${i+1 }"/>
		<c:if test="${images.isThumbnail == '0'}">
			<div id="image">
			<img src="../images/uploadFiles/${images.imageFile}" class="rounded" style="width:960px" />
			</div>
		</c:if>
	</c:forEach>
	<hr/>
	
	<br/>

		<div class="container">
			<div class="row">
			<div class="col">
			<div>
			<img src="https://mdbootstrap.com/img/Photos/Avatars/img%20(27).jpg" id="profile" class="rounded-circle">
			 </div>
			 <div><p>${feed.writer.userName}</p></div>
			</div>
			</div> 

			<div class="col">
			
			</div>
			<div class="col">
			
			</div>
			
			<div class="d-flex flex-row bd-highlight mb-6">
			  <div class="p-2 bd-highlight">Flex item 1</div>
			  <div class="p-2 bd-highlight">Flex item 2</div>
			  <div class="p-2 bd-highlight">Flex item 3</div>
			</div>
			 </div>

	<br/>
	<hr/>
	<br/>
	
	
	
	</div>
	
	</div>

</body>
</html>