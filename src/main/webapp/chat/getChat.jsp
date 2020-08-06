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
	
	<style type="text/css">
	 body {
	 
	 	margin-top: 70px;
	 
	 }
	 .user_list {
	 
	 	border-right: 1px solid black;
	 	min-height: 500px;
	 	
	 
	 }
	 #profileImage{
	 
	 width: 30px;
	 border-radius: 15px;
	 margin-left: 8px;
	 
	 }
	 .chat-body {
	 
	  min-width: 500px;
	  min-height: 450px;
	  border: 1px solid gray;
	  overflow: auto;
	  margin-bottom: 10px;
	 
	 }
	
	
	
	</style>
	
	<script type="text/javascript">
	$(function(){	
				var username = '${user.userCode}';
				var socket = io.connect('http://192.168.0.13:3000');
				socket.on('connect', function(){
					
					while(username == ''){
						username = alert("로그인 해주세요");
						hitory.go(-1);
						return false;
					}
					$('input[name=username]').val(username);
					socket.emit('list', username);
	
				});
				socket.on('send message', function(message){
					$('.chat-body').append(message);
				});

				socket.on('remove user', function(username){
					$('#user_list p#'+username).remove();
				});
				
				socket.on('list', function(result){
					alert(result);
					for(var i = 0; i < result.length; i++){
					console.log("123123");
					
					var userCodes = JSON.stringify(result[i].userCodes);
					userCodes = JSON.parse(userCodes);
					console.log(userCodes[1]);
					
					
					
					var data = "<div class='chatUser'>"+
									"<img id='profileImage' src=''/VIG/images/uploadFiles/${user.profileImg }'>"+
									"<p style='display: inline-block; margin: 3px auto;'>"+userCodes[1]+"</p></div>"
					console.log(data);
					$(".user_list").append(data);
					
					
					}
					
				});
					
				
				//메세지 보내기를 누르면  join
				$("#sendMessages").on("click", function(e){

					var selectUser = 'user07';
					var roomId = '${user.userCode}'+Date.now();
					socket.emit('createChat', username, roomId, selectUser);
					
					
				});
				

				$('#submit_btn').on("click",function(e){
					console.log($('#message_input').val());
					var message = $('#message_input').val();
					var attached = $('#attached_input').val();
					
					if(message != ''){
						socket.emit('send message', message, roomId);
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

	<div class="container">
	<h1 style="text-align:left">Message</h1>
	<hr><br>
		<div class="row">
			<div class="col-3">
				<div class="user_list">
					<div class="chatUser">
						<img id="profileImage" src="/VIG/images/uploadFiles/${user.profileImg }">
						<p style="display: inline-block; margin: 3px auto;">UserCode</p>
						
					</div>
					
				</div>
			
			</div>
			<div class="col-9">
				
				
				
				<div  class="chat-body">
				
				<hr>
				
				</div>
				
				<form id="chat_form" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-9">
							<input type="hidden" name="roomId">
							<input style="width:600px; vertical-align: middle" type="text" id="message_input" class="form-control" placeholder="Example input">
						</div>
						<div class="col-3">
							<button style="display: inline-block;" type="button" id="submit_btn" class="btn btn-outline-default waves-effect">Default</button>
						</div>
						<button style="display: inline-block;" type="button" id="sendMessages" class="btn btn-outline-default waves-effect">Default</button>
					</div>
				</form>
					
					${user.userCode }
		
			</div>
		</div>
	</div>






</body>
</html>