<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>VIG</title>

		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
		<!-- Google Fonts -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
		<!-- Bootstrap core CSS -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
		<!-- Material Design Bootstrap -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
		
		<style type="text/css">
		
		 #header1 {
            text-align: center;
            width: 960px;
            height: 150px;
            background-color:;
            padding:;
        }
		
		 #header2 {
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
	

	
	
	
		<div class="container-fluid">
		  <div class="row">
		    <div id="wrap">
		    	<div id="header1">
		            <jsp:include page="/main/toolbar.jsp" />
		        </div>
		    	<div id="header2">
		            <jsp:include page="/searchPage/searchBar.jsp" />
		        </div>
		        <div id="main">
		            <jsp:include page="/main/main.jsp" />
		        </div>
			  </div>
			</div>
		</div>

</body>
</html>