<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

		$(document).ready(function () {
		    if ($("div.floating").length > 0) {
		    var obj = $("div.floating").offset().top;
		    var subConH = $(".sub_contents").height();
		
		    function sclTop() {
		        var sclTop = $(this).scrollTop();
		        var sclThis = $("div.floating");
		
		        if (sclTop > obj)
		        {
		            sclThis.addClass('on');
		
		        }
		        else
		        {
		            sclThis.removeClass('on');
		        }
		    }
		    $(window).scroll(function () {
		        sclTop();
		    });
		}
		});

</script>

<style>
.container{height:2500px;}
		.floating { width:400px; position:absolute; top:0px;-webkit-transition: 0.5s ease; transition: 0.5s ease; border:1px solid red; }
		.floating.on {position:fixed; top:20px; z-index: 999}
</style>

</head>
<body>

<div class="container">
	<div class="floating">
	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
		tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
		quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
		consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
		cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
		proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
		tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
		quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
		consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
		cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
		proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
		Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
		tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
		quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
		consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
		cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
		proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
	</div>
</div>


</body>
</html>