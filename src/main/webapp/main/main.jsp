<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
		<style type="text/css">
		
		 #category {
            text-align: center;
            width: 960px;
            height: 150px;
            background-color:;
            padding:;
        }
		
		 #banner {
            text-align: ;
            width: 960px;
            height: 500px;
            background-color:;
            padding:;
        }

		
   		 </style>
    
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
	
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	
	
<div class="container-lg">
  <div class="row">
    <div id="wrap">
    	<div id="category">
            <jsp:include page="/main/category.jsp" />
        </div>
        <div id="banner">
            <jsp:include page="/main/banner.jsp" />
        </div>
        <div id="main">
            <jsp:include page="/main/thumbnail.jsp" />
        </div>
	  </div>
	</div>
</div>
	
	





</body>
</html>