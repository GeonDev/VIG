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
	<script src="http://192.168.0.13:3000/socket.io/socket.io.js"></script>
	<!-- favicon 영역 이후 툴바 적용 -->
	<link rel="icon" type="image/png" sizes="16x16" href="/VIG/images/others/favicon-16x16.png">
	
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
	var selectUser = $("input[name='selectUser']").val();
	var roomId;
	var data;
	var diplayValue;
	var user;
	var dbuser; //db에서 가져온 유저
	var url = "http://192.168.0.13:3000/";
	
	var socketUser = new Object(); //socket으로 주고 받을 유저 생성
	var otherUser = new Object();
	
	
	function chatScrollfix(){
		
		//scroll가장 하단으로 자동 고정
		$(".chat-body").scrollTop($(".chat-body").height()+500); 
		
		
	}
	
	function removeChat(){
		
		
		$("#selectUser div").remove();
		$(".chat-body div").remove();
		
		
	}
	
	function getChat(userinfo){
		//roomId, userCode, userName, profileImg 가 순서대로 온다.
		
		//chat부분 초기화
		removeChat();
		//function으로 넘어오는 값 parsing
		console.log("!!!"+userinfo);
		var list = userinfo.split(",");
		console.log(list);
		
		selectUser = list[1];
		$('input[name="selectUser"]').val(selectUser);
		$('input[name="roomId"]').val(list[0]);
		console.log("roomId="+$('input[name="selectUser"]').val());
		
		var select = $("#selectChat").text();
		//선택한 유저가 이미 선택되었는지 확인,
		
	
		$.ajax({
			url: url+'chat/getChat/'+list[0],
			method: 'get',
			dataType: 'json',
			async: false,
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
				"<img class='profileImage' src='/VIG/images/uploadFiles/"+list[3]+"\'>"+
				"<p id='selectChat' style='display: inline-block; margin: 3px auto; font-weight: bold;'>"+list[2]+"</p></div>";
				
				 for(var i = 0; i<data.length; i++){
					 
					 if(data[i].sender.userCode != selectUser){
							
							displayValue ="<div class='media' style='align: right; text-align:right; padding-right: 8px'>"+
							"<div class='media-body' style='align: right'><div class='innermedia'>" + data[i].contents + "<br><span class='msg-body'>("+data[i].createdAt+")</span></div></div></div>";
							
							$('.chat-body').append(displayValue);
								
								
							} else {
								
							displayValue ="<div class='media' style='align: left; text-align:left'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data[i].receiver.userName + "</span></div><div class='innermedia'><div class='media-body' style='align: left'>" + data[i].contents + "<br><span class='msg-body'>("+data[i].createdAt+")</span></div></div></div>";
								
								$('.chat-body').append(displayValue);
								
							}

					
					
					
				}
				$("#chatPlace").attr("style", "visibility:visible");
				chatScrollfix();
				$("#selectUser").append(user);
				
				
				
		
			
			
			}
		});
		
		
		
	};
	
	
	
	function getChatUser(userCode){
		
		console.log("getChatUser"+userCode);
		dbuser;
		
		$.ajax({
			
			url: "/VIG/user/json/getUser/"+userCode,
			method: "get",
			dataType: "json",
			async: false,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success: function(JSONData, status) {
				
				dbuser = JSONData;
				dbuser = JSON.parse(JSON.stringify(dbuser, ["userCode","userName", "profileImg"]));
				console.log("로딩중"+dbuser);
			}
		});
		
		
		return dbuser;
		
	};
	
	$(function(){	
		
				
				//첫 로딩시에는 chat영역 안보임
				$("#chatPlace").attr("style", "visibility:hidden");
				
				socket = io.connect(url);
			
				
				//socket으로 서버에 username = socketId로 전달할 수 있도록 함
				socketUser.userCode = username; //userCode 심어줌
				socketUser.profileImg ='${user.profileImg}';
				socketUser.userName = '${user.userName}';
				socket.emit('setSocketId', socketUser);

				
				socket.on('connect', function(){
	
					$('input[name=username]').val(username);
	
				});
				
				
				//보낸 메세지 받기
				socket.on('send message', function(data){
					data = JSON.stringify(data);
					data = JSON.parse(data);
					console.log(data);
					 if(data.sender.userCode == username){
							
							displayValue ="<div class='media' style='align: right ;text-align:right'>"+
							"<div class='media-body'><div class='innermedia'>" + data.contents + "<br><span class='msg-body'>("+data.createdAt+")</span></div></div></div>";
							
							console.log(displayValue);
							
								
								
							} else {
								
							displayValue ="<div class='media' style='align: left ;text-align:left; padding-right: 8px'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data.receiver.userName + "</span></div><div class='innermedia'><div class='media-body'>" + data.contents + "<br><span class='msg-body'>("+data.createdAt+")</span></div></div></div>";
								
							console.log(displayValue);
							
							}
					 $('.chat-body').append(displayValue);
					 
				});

				
				//page로딩시 ajax로 userlist를 가져온다.
				$.ajax({
					
					url: url+'chat/getChatList/'+socketUser.userCode,
					method: 'get',
					dataType: 'json',
					async: false,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success: function(JSONData, status) {
						
						data = JSON.stringify(JSONData);
						console.log(data);
						data = JSON.parse(data);
						console.log("JsonData"+data);
						console.log("json크기"+data.length);
						console.log("username확인"+username);
						for(var i = 0; i < data.length; i++){
							
							
								
							
								for(var j=0; j< data[i].userCodes.length; j++) {
									
									
	
									if(i==0){
										$('input[name="roomId"]').val(data[i]._id);
									}
									
									if(username != data[i].userCodes[j].userCode){ 
										console.log(data[i].userCodes[j].userCode);
										console.log(data[i].userCodes[j].userName);
										
										var userinfo="";
										userinfo += data[i]._id+",";
										userinfo += data[i].userCodes[j].userCode+",";
										userinfo += data[i].userCodes[j].userName+",";
										userinfo += data[i].userCodes[j].profileImg;
										console.log(userinfo.replace('undefined', ""));
							
									user = '<div class="chatUser" id=\"'+data[i].userCodes.userCode+'\"onClick="getChat(\''+userinfo+'\')">'+
													"<img class='profileImage' src='/VIG/images/uploadFiles/"+data[i].userCodes[j].profileImg+"\'>"+
													"<p style='display: inline-block; margin: 3px auto; font-weight: bold'>"+data[i].userCodes[j].userName+"</p></div>"
									
									
									$(".user_list").append(user);
									} 
								
								
								}
							
						}
							
						
					}
					});
				

					
				
				//유저 선택하고, 메세지 보내기를 누르면  roomCreate
				$("#sendMessages").on("click", function(){
					
					
					selectUser = $("#userselect").val();
					otherUser.userCode = selectUser; //userCode 심어줌
					dbuser = getChatUser(selectUser);
					console.log(dbuser);
					otherUser.profileImg =dbuser.profileImg;
					otherUser.userName = dbuser.userName;
					socket.emit('createChat', socketUser, otherUser);
					socket.on('add user', function(results){
						
						console.log(results);
						results = JSON.stringify(results);
						results = JSON.parse(results);
						$("input[name='roomId']").val(results._id);
						
						var userinfo="";
						userinfo += results._id+",";
						userinfo += dbuser.userCode+",";
						userinfo += dbuser.userName+",";
						userinfo += dbuser.profileImg;
						console.log(userinfo.replace('undefined', ""));
						
						user = '<div class="selectChat" style="vertical-align: middle">'+
						"<img class='profileImage' src='/VIG/images/uploadFiles/"+dbuser.profileImg+"\'>"+
						"<p id='selectChat' style='display: inline-block; margin: 3px auto; font-weight: bold;'>"+dbuser.userName+"</p></div>";
						
						
						var chatUser = '<div class="chatUser" id=\"'+dbuser.userCode+'\"onClick="getChat(\''+userinfo+'\')">'+
						"<img class='profileImage' src='/VIG/images/uploadFiles/"+dbuser.profileImg+"\'>"+
						"<p style='display: inline-block; margin: 3px auto; font-weight: bold'>"+dbuser.userName+"</p></div>"
						
						
						$(".user_list").append(chatUser);
						getChat(userinfo);
						
					});
					
					
				});
				
				$("#deleteChat").on("click", function(){
					
					var result = confirm("그동안의 메세지가 모두 지워집니다. 삭제하시겠습니까?");
					
					if(result){
					
					roomId = $("input[name='roomId']").val();
					
					socket.emit('deleteChat', roomId);
					$("#chatPlace").remove();
					console.log("!!!!!!!!!!!!!!"+selectUser);
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
					otherUser.userCode = selectUser;
					dbuser = getChatUser(selectUser);
					otherUser.userName = dbuser.userName;
					otherUser.profileImg = dbuser.profileImg;
					console.log("메세지를 보낼 유저"+selectUser);
					if(message != ''){
						socket.emit('send message', message, otherUser);
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
					<input type="text" id="userselect" value="${receiver}">
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
					<input type="hidden" name="userCode" value="${user.userCode}">
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