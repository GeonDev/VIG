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
	<script src="//192.168.0.13:3000/socket.io/socket.io.js"></script>
	
	<script type="text/javascript">
	$(function(){	
				var socket = io.connect('http://192.168.0.13:3000');
				socket.on('connect', function(){
					var username = '${user.userCode}';
					while(username == ''){
						username = alert("로그인 해주세요");
						hitory.go(-1);
						return false;
					}
					$('input[name=username]').val(username);
					socket.emit('join', username)
				});
				socket.on('send message', function(message){
					$('.chat-body').append(message);
				});

				socket.on('remove user', function(username){
					$('#user_list p#'+username).remove();
				});
				

				$('#submit_btn').on("click",function(e){
					console.log($('#message_input').val());
					var message = $('#message_input').val();
					var attached = $('#attached_input').val();
					if(message != ''){
						socket.emit('send message', message);
						$('#message_input').val('');
					} else if (attached != '') {
						$("#status").empty().text("File is uploading...");
					    $(this).ajaxSubmit({
					        error: function(xhr) {
							    status('Error: ' + xhr.status);
					        },
					        success: function(response) {
							    $("#status").empty().text(response);
					        }
					    });
						$('#attached_input').val('');
					}
					return false;
				});
				
			});
	
	</script>
	
	
</head>
<body>
	
	
	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	채팅
	<form id="chat_form" method="post" enctype="multipart/form-data">
	<input type="text" id="message_input">
	
	</form>
	<input type="submit" id="submit_btn">
	${user.userCode }
	
	
	<div  class="chat-body">
	채팅 내용
	
	
	</div>










</body>
</html>