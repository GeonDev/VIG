<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<title>VIG</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<script type="text/javascript">

	</script>	
	
	<style>
	
	@import url(https://fonts.googleapis.com/css?family=Lato:300,400,700);



.navbar {
	padding: 30px;
  background: -webkit-radial-gradient(bottom left, circle, #f4d894, #ff6666);
  background: radial-gradient(circle at bottom left, #f4d894, #ff6666);
  }
  body{
  background:gray;
  color: #fff;
  font-family: Lato, sans-serif;
  font-size: 24px;
  font-weight: 300;
  letter-spacing: 0.025em;
}

strong {
  font-weight: bold;
}

em {
  color: #959595;
  font-style: italic;
}

.tooltip-example {
  -webkit-transform: translateY(-50%);
  -moz-transform: translateY(-50%);
  -ms-transform: translateY(-50%);
  -o-transform: translateY(-50%);
  transform: translateY(-50%);
  position: absolute;
  text-align: center;
  top: 50%;
  width: 100%;
}

.tooltip {
  display: inline;
  -webkit-perspective: 500px;
  -moz-perspective: 500px;
  perspective: 500px;
}
.tooltip:hover {
  cursor: pointer;
}
.tooltip:hover .tooltip__content {
  -webkit-transform: translate3d(-50%, -10%, 0);
  -moz-transform: translate3d(-50%, -10%, 0);
  -ms-transform: translate3d(-50%, -10%, 0);
  -o-transform: translate3d(-50%, -10%, 0);
  transform: translate3d(-50%, -10%, 0);
  opacity: 1;
  pointer-events: auto;
}
.tooltip__content {
  -webkit-transition: all 200ms ease;
  -moz-transition: all 200ms ease;
  transition: all 200ms ease;
  -webkit-transform: translate3d(-50%, 0%, 0);
  -moz-transform: translate3d(-50%, 0%, 0);
  -ms-transform: translate3d(-50%, 0%, 0);
  -o-transform: translate3d(-50%, 0%, 0);
  transform: translate3d(-50%, 0%, 0);
  -webkit-transform-origin: 0 10px;
  -moz-transform-origin: 0 10px;
  -ms-transform-origin: 0 10px;
  -o-transform-origin: 0 10px;
  transform-origin: 0 10px;
  background-color: #fff;
  border-radius: 4px;
  color: #2f2f2f;
  display: block;
  font-size: 14px;
  font-weight: normal;
  left: 50%;
  opacity: 0;
  padding: 10px 20px;
  pointer-events: none;
  position: absolute;
  text-align: left;
  bottom: 100%;
}
.tooltip__content:before {
  border-color: transparent;
  border-top-color: #fff;
  border-style: solid;
  border-width: 10px;
  content: ' ';
  display: block;
  height: 0;
  left: 50%;
  margin-left: -10px;
  position: absolute;
  bottom: -20px;
  width: 0;
}
.tooltip__content:after {
  content: ' ';
  display: block;
  position: absolute;
  bottom: -20px;
  left: 0;
  width: 100%;
  height: 20px;
}
.tooltip__content:hover {
  -webkit-transform: rotateX(0deg) translate3d(-50%, -10%, 0);
  -moz-transform: rotateX(0deg) translate3d(-50%, -10%, 0);
  -ms-transform: rotateX(0deg) translate3d(-50%, -10%, 0);
  -o-transform: rotateX(0deg) translate3d(-50%, -10%, 0);
  transform: rotateX(0deg) translate3d(-50%, -10%, 0);
  opacity: 1;
  pointer-events: auto;
}



.fas.fa-user{ color:white;}
	
	</style>	
	
</head>		 
<body>
	
<!-- 
<div class="tooltip-example">
    I love a 
    <span class="tooltip">      
        <strong>sexy</strong>
        <span class="tooltip__content">
            <p>[sex·y] /'seksē/</p>
            <p><em>informal</em></p>
            <p>exciting; appealing. <a href="www.google.com" target="_blank">link</a></p>
        </span>
    </span>
    tooltip!
</div>
 -->



<nav class="navbar">
 
  
 
  
  
</nav>

<br>

		

 <div class="tooltip-example">
		           oooooooooooooo
						<span class="tooltip">     
						<strong><i class="fas fa-user" style="margin-right:30px; color: #black;"></i></strong>
					 <span class="tooltip__content">
					 <img src="/VIG/images/uploadFiles/${user.profileImg}" class="rounded-circle" style="width: 50px;">
						${user.userName}
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/myfeed/getMyFeedList?userCode=${user.userCode}" style="display: flex;justify-content: center;" >My Feed</a>
						    <a class="dropdown-item" href="/VIG/feed/addFeed.jsp" style="display: flex;justify-content: center;">Upload</a>
						  <div class="dropdown-divider"></div>
						      <a class="dropdown-item" style="display: flex;justify-content: center;">Log Out</a>
						 </span>
						 </span>
						 ooooooooo
						 </div>

</body>


</html>