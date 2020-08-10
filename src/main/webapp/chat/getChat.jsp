<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<script src="http://127.0.0.1:3000/socket.io/socket.io.js"></script>
	
	<style type="text/css">
	 body {
	 	
	 	margin-top: 60px;
	 
	 }
	 .user_list {
	 	
	 	margin-top: 30px;
	 	border-right: 1px solid #B7B6B4;
	 	min-height: 500px;
	 	overflow: auto; 
	 	
	 
	 }
	 .profileImage{
	 
	 width: 30px;
	 border-radius: 15px;
	 margin-right: 10px;
	 
	 }
	 .chat-body {
	  
	  height: 400px;
	  width: 100%;
	  overflow: auto; 
	  margin-bottom: 10px;

	  
	 
	 }

	 .selectChat {
	 
	 margin: 3px auto;
	 
	 }
	 
	 .chatUser{
	 
	 margin: 20px auto;
	 padding: 6px auto;

	 
	 }
	 
	 div .media-body {
	  
	  
	  padding: 5px auto;
	  border-radius: 8px auto;

	 
	 }
	 
	 span.msg-body {
		 width: 150px;
		 font-size: 10px;
		 
	 }
	 .innermedia {
	 

	 
	 
	 }
	 #chatPlace{
	 
	 
	 border-radius: 3px 3px 3px 3px;
	 margin: 5px auto;
	 margin-bottom:
	 padding-top: 8px;
	 padding-left: 8px;
	 padding-right: 12px;
	 
	 }
	 
	
	
	</style>
	
	<script type="text/javascript">
	
	var username = '${user.userCode}';
	
	if(username==null|| username==''){
		alert("로그인 해주세요");
		self.location="/VIG/main/VIG";
	}
	
	var socket;
	
	$(function(){	
		
		
		
				//첫 로딩시에는 chat영역 안보임
				$("#chatPlace").attr("style", "visibility:hidden");
				
				socket = io.connect('http://127.0.0.1:3000');
				
				var selectUser = $("input[name='selectUser']").val();
				var roomId;
				var data;
				var diplayValue;
				var user;
				

				
				//socket으로 서버에 username = socketId로 전달할 수 있도록 함
				socket.emit('setSocketId', username);

				
				socket.on('connect', function(username){
	
					$('input[name=username]').val(username);
	
				});
				
				
				//보낸 메세지 받기
				socket.on('send message', function(data){
					
					data = JSON.parse(data);
					 if(data.sender == username){
							
							displayValue ="<div class='media' style='align: right ;text-align:right'>"+
							"<div class='media-body'><div class='innermedia'>" + data.contents + "<br><span class='msg-body'>("+data.createdAt+")</span></div></div></div>";
							
							console.log(displayValue);
							
								
								
							} else {
								
							displayValue ="<div class='media' style='align: left ;text-align:left; padding-right: 8px'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data.sender + "</span></div><div class='innermedia'><div class='media-body'>" + data.contents + "<br><span class='msg-body'>("+data.createdAt+")</span></div></div></div>";
								
							console.log(displayValue);
							
							}
					 $('.chat-body').append(displayValue);
					 
				});

				
				//page로딩시 ajax로 userlist를 가져온다.
				$.ajax({
					
					url: 'http://127.0.0.1:3000/chat/getChatList/'+username,
					method: 'get',
					dataType: 'json',
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success: function(JSONData, status) {
						
						var data = JSON.stringify(JSONData);
						data = JSON.parse(data);
						console.log("JsonData"+data);
						console.log("json크기"+data.length);
						for(var i = 0; i < data.length; i++){
							var userCode = data[i].userCodes[1];
							console.log(userCode);
							console.log(username);
							console.log(roomId);
							if(i==0){
								$('input[name="roomId"]').val(roomId);
							}
							if(username != userCode){
								
							user = '<div class="chatUser" id=\"'+userCode+'\"onClick="getChat(\''+data[i]._id+','+userCode+'\')">'+
											"<img class='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
											"<p style='display: inline-block; margin: 3px auto; font-weight: bold'>"+userCode+"</p></div>"
							} else if(username == userCode) {
								
								userCode = data[i].userCodes[0];
								user = '<div class="chatUser" id=\"'+userCode+'\" onClick="getChat(\''+data[i]._id+','+userCode+'\')">'+
								"<img class='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
								"<p style='display: inline-block; margin: 3px auto;'>"+userCode+"</p></div>"
								
							}
							$(".user_list").append(user);
						}
							
						
					}
					});
				

					
				
				//유저 선택하고, 메세지 보내기를 누르면  roomCreate
				$("#sendMessages").on("click", function(){
					
					selectUser = $("#userselect").val();
					socket.emit('createChat', username, selectUser);
					socket.on('add user', function(results){
						
						console.log(results);
						results = JSON.stringify(results);
						results = JSON.parse(results);
						$("input[name='roomId']").val(results._id);
						
						user = '<div class="selectChat" style="vertical-align: middle">'+
						"<img class='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
						"<p id='selectChat' style='display: inline-block; margin: 3px auto;'>"+selectUser+"</p></div>"
						
						
						var chatUser = '<div class="chatUser" onClick="getChat(\''+results._id+','+selectUser+'\')">'+
						"<img class='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
						"<p style='display: inline-block; margin: 3px auto; font-weight: bold'>"+selectUser+"</p></div>"
						
						data = results._id+","+selectUser;
						
						$("#selectUser").append(user);
						$(".user_list").append(chatUser);
						getChat(data);
						
					});
					
					
				});
				
				$("#deleteChat").on("click", function(){
					
					var result = confirm("그동안의 메세지가 모두 지워집니다. 삭제하시겠습니까?");
					
					if(result){
					
					roomId = $("input[name='roomId']").val();
					
					socket.emit('deleteChat', roomId);
					$("#selectUser div").remove();
					console.log("!!!!!!!!!!!!!!"+selectUser);
					$(".chat-body div").remove();
					$("#"+selectUser).remove();
					
					}
					
				});
				
				
				
				//메세지 보내기
				$('#submit_btn').on("click",function(e){
					
				
					roomId = $('input[name="roomId"]').val();
					var message = $('#message_input').val();
					console.log(message);
					var attached = $('#attached_input').val();
					selectUser = $("input[name='selectUser']").val();
					console.log("메세지를 보낼 유저"+selectUser);
					if(message != ''){
						socket.emit('send message', message, selectUser);
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
						chatScrollfix();
					}
					return false;
					
				});
				


				
			});
	
	
	function chatScrollfix(){
		
		//scroll가장 하단으로 자동 고정
		$(".chat-body").scrollTop($(".chat-body").height()+500); 
		
		
	}
	
	function getChat(data){
		
		//chat부분 초기화
		$("#selectUser div").remove();
		$(".chat-body div").remove();
		//function으로 넘어오는 값 parsing
		var list = data.split(",");
		console.log("!!!"+list);
		username = $("input[name='userCode']").val();
		$('input[name="selectUser"]').val(list[1]);
		$("input[name='roomId'").val(list[0]);
		console.log($('input[name="selectUser"]').val());
		
		var select = $("#selectChat").text();
		//선택한 유저가 이미 선택되었는지 확인,
		
	
		$.ajax({
			url: 'http://127.0.01:3000/chat/getChat/'+list[0],
			method: 'get',
			dataType: 'json',
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success: function(JSONData, status) {
				
				data = JSON.stringify(JSONData);
				data = JSON.parse(data);
				
				console.log(data);
				var inputSelect = document.getElementsByName("selectUser");
				var user = '<div class="selectChat" style="vertical-align: middle">'+
				"<img class='profileImage' src='/VIG/images/uploadFiles/${user.profileImg }'>"+
				"<p id='selectChat' style='display: inline-block; margin: 3px auto; font-weight: bold;'>"+list[1]+"</p></div>"
				
				 for(var i = 0; i<data.length; i++){
					 
					 
					 if(data[i].sender == username){
							
							displayValue ="<div class='media' style='align: right; text-align:right; padding-right: 8px'>"+
							"<div class='media-body' style='align: right'><div class='innermedia'>" + data[i].contents + "<br><span class='msg-body'>("+data[i].createdAt+")</span></div></div></div>";
							
							console.log(displayValue);
							$('.chat-body').append(displayValue);
								
								
							} else {
								
							displayValue ="<div class='media' style='align: left; text-align:left'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data[i].sender + "</span></div><div class='innermedia'><div class='media-body' style='align: left'>" + data[i].contents + "<br><span class='msg-body'>("+data[i].createdAt+")</span></div></div></div>";
								
								$('.chat-body').append(displayValue);
								
							}

					
					
					
				}
				$("#chatPlace").attr("style", "visibility:visible");
				chatScrollfix();
				$("#selectUser").append(user);
				//$("#selectUser").append(user);
				//$("input[name='selectUser']").val(list[1]);
				
				
		//	}
			
			
			}
		});
		
		
		
	};
	
	
	
	</script>
	
	
</head>
<body>
	
	
	<!-- 툴바 include -->
	<jsp:include page="../main/toolbar.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-8">
				<h1 style="text-align:left">Message</h1>
			</div>
			<div class="col-4"  >
				<div style="text-align: right; vertical-align:text-bottom;" >
					<input type="text" id="userselect">
					<button class=" -roundedbtn btn-floating btn-indigo btn-sm" id="sendMessages"><i class="fas fa-envelope"></i></button>
				</div>
			</div>
		
		</div>
	<hr>
		<div class="row">
			<div class="col-3">
			
				<div class="user_list">

				</div>
			
			</div>
			<div class="col-9" >
				<div id="chatPlace">
					<div class="row">
					
						<div class="col-8">
							<div id="selectUser" >	</div>
						</div>
						<div class="col-4" style="text-align:right">
							<i class="fas fa-trash-alt" style="text-align:right; font-size: 20px" id="deleteChat"></i>
						</div>
					
					</div>
					<hr>
				<div  class="chat-body" style="  padding: 20px auto;">
			
				
				</div>

			
				<hr>
				<form id="chat_form" method="post" enctype="multipart/form-data">
						
					<input type="hidden" name="roomId">
					<input type="hidden" name="selectUser">
					<input type="hidden" name="userCode" value="${user.userCode }">
					<div class="md-form input-group mb-3" style="margin: 3px auto">
						<input style="width:600px; vertical-align: middle;background-color: white;" type="text" id="message_input" class="form-control" placeholder="메세지를 입력해주세요"
						placeholder="Recipient's username" aria-label="Recipient's username"
	  						aria-describedby="submit_btn">
	  					<div class="input-group-append">
							<button style="display: inline-block;" type="button" id="submit_btn" class="btn btn-md btn-secondary m-0 px-3">전송</button>
						</div>
					</div>
						
					
				</form>
		
				</div>
			</div>
		</div>
	</div>
	





</body>
</html>