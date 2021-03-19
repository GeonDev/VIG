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
	<!--  sweet Alert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!--  socket.io -->
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
		 font-size: 100%;
		 
	 }
	 .innermedia {
	 

	 
	 
	 }
	 #chatPlace{
	 
	 
	 border-radius: 3px 3px 3px 3px;
	 margin: 5px auto;
	 padding-top: 8px;
	 padding-left: 8px;
	 padding-right: 12px;
	 
	 }
	 
	
	
	</style>
	
	<script type="text/javascript">
	
	var username = '${user.userCode}';
	
	if(username==null|| username==''){
		alert("로그인 해주세요");
		self.location="/";
	}
	
	var socket;
	var selectUser = $("input[name='selectUser']").val();
	var roomId;
	var data;
	var diplayValue;
	var user;
	var dbuser; //db에서 가져온 유저
	var url = "http://127.0.0.1:3000/";
	
	var socketUser = new Object(); //socket으로 주고 받을 유저 생성
	var otherUser = new Object();
	
	
	function chatScrollfix(){
		
		//scroll가장 하단으로 자동 고정
		$(".chat-body").scrollTop($(".chat-body").height()+500); 
		
		
	}
	
	function removeChat(){
		
		$(".chat-body div").remove();
		
		
	}
	
	function showChat(){
		
		$("#selectUser").show();
		$(".chat-body").show();
		
		
	}
	
	
	function getChat(userinfo){
		//roomId, userCode, userName, profileImg 가 순서대로 온다.
		
		//chat부분 초기화
		removeChat();
		//function으로 넘어오는 값 parsing

		var list = userinfo.split(",");

		$('input[name="roomId"]').val("");
		selectUser = list[1];
		$('input[name="selectUser"]').val(selectUser);
		$('input[name="roomId"]').val(list[0]);

	
		//채팅쪽 다시 보여주기
		$('h3').hide();
		showChat();
		
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
				"<img class='profileImage' src='/images/uploadFiles/"+list[3]+"\'>"+
				"<p id='selectChat' style='display: inline-block; margin: 3px auto; font-weight: bold;'>"+list[2]+"</p>("+list[1]+")</div>";
				
				 for(var i = 0; i<data.length; i++){
					
					 if(data[i].sender.userCode != selectUser){
						 
							displayValue ="<div class='media' style='align: right; text-align:right; padding-right: 8px'>"+
							"<div class='media-body' style='align: right'><div class='innermedia'>" + data[i].contents + "<br><span class='msg-body'>("+data[i].createdAt+")</span></div></div></div>";
							
							$('.chat-body').append(displayValue);
								
								
							} else {
								console.log(i);
							displayValue ="<div class='media' style='align: left; text-align:left'><div class='media-left'><span class='author' style='font-weight: bold; color: black; text-align:right;'>"
								+ data[i].sender.userName + "</span></div><div class='innermedia'><div class='media-body' style='align: left'>" + data[i].contents + "<br><span class='msg-body'>("+data[i].createdAt+")</span></div></div></div>";
								
							$('.chat-body').append(displayValue);
								
							}
				}
				$("#chatPlace").attr("style", "visibility:visible");
				chatScrollfix();
				$("#selectUser").html(user);
				
			
			}
		});
		
		
		
	};
	
	
	function getChatList(socketUser) {
		
		$(".user_list div").remove();
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
				for(var i = 0; i < data.length; i++){
						for(var j=0; j< data[i].userCodes.length; j++) {
							if(username != data[i].userCodes[j].userCode){ 
								
								var userinfo="";
								userinfo += data[i]._id+",";
								userinfo += data[i].userCodes[j].userCode+",";
								userinfo += data[i].userCodes[j].userName+",";
								userinfo += data[i].userCodes[j].profileImg;
								userinfo.replace('undefined', "");
					
							user = '<div class="chatUser" id=\"'+data[i].userCodes[j].userCode+'\"onClick="getChat(\''+userinfo+'\')">'+
											"<img class='profileImage' src='/images/uploadFiles/"+data[i].userCodes[j].profileImg+"\'>"+
											"<p style='display: inline-block; margin: 3px auto; font-weight: bold'>"+data[i].userCodes[j].userName+"</p>("+data[i].userCodes[j].userCode+")</div>"
							
							
							$(".user_list").append(user);
							} 						
						}					
					}			
				}
			});
		
		
	}
	
	
	
	function getChatUser(userCode){
		
		console.log("getChatUser"+userCode);
		dbuser;
		
		$.ajax({
			
			url: "/user/json/getUser/"+userCode,
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
			}
		});
		
		
		return dbuser;
		
	};
	
	
	//채팅 삭제
	function deleteChat(){
			
			
		    roomId = $("input[name='roomId']").val();
			
		    console.log("delete"+roomId);
		    
			socket.emit('deleteChat', roomId);
			$("#"+selectUser).remove();
			$("#chatPlace").hide();
			$("h3").show();
		
	};
	
	$(function(){	
		
				
					//첫 로딩시에는 chat영역 안보임
					$("#chatPlace").hide();
					
					socket = io.connect(url);
				
					
					//socket으로 서버에 username = socketId로 전달할 수 있도록 함
					socketUser.userCode = username; //userCode 심어줌
					socketUser.profileImg ='${user.profileImg}';
					socketUser.userName = '${user.userName}';
					socket.emit('setSocketId', socketUser);
	
					
					socket.on('connect', function(){
		
						$('input[name=username]').val(username);
		
					});
					
					//최초로딩시 받기
					getChatList(socketUser);
				
				
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
									+ data.sender.userName + "</span></div><div class='innermedia'><div class='media-body'>" + data.contents + "<br><span class='msg-body'>("+data.createdAt+")</span></div></div></div>";
									
								console.log(displayValue);
								
								}
						 $('.chat-body').append(displayValue);
						 
					});

					socket.on('add user', function(results){
						
						getChatList(socketUser);
						
					});
					
					socket.on('err messege', function(){
						
						swal("이미 존재하지 않는 채팅방입니다.");
						$("#chatPlace").hide();
						getChatList(socketUser);
						
					});
				
					
				
					//유저 선택하고, 메세지 보내기를 누르면  roomCreate
					$("#sendMessages").on("click", function(){
						
						
						selectUser = $("#userselect").val();
						otherUser.userCode = selectUser; //userCode 심어줌
						dbuser = getChatUser(selectUser);
						
						if(dbuser == null || dbuser == ''){
							
							swal("존재하지 않는 유저입니다.");
							$("#userselect").val("");
							return false;
							
						}
						otherUser.profileImg =dbuser.profileImg;
						otherUser.userName = dbuser.userName;
						socket.emit('createChat', socketUser, otherUser);
						socket.on('add user', function(results){
	
							results = JSON.stringify(results);
							results = JSON.parse(results);
							console.log("resultId!!!"+results._id);
							$("input[name='roomId']").val(results._id);
							
							var userinfo="";
							userinfo += results._id+",";
							userinfo += dbuser.userCode+",";
							userinfo += dbuser.userName+",";
							userinfo += dbuser.profileImg;
							userinfo.replace('undefined', "");
							
							var chatUser = '<div class="chatUser" id=\"'+dbuser.userCode+'\"onClick="getChat(\''+userinfo+'\')">'+
							"<img class='profileImage' src='/images/uploadFiles/"+dbuser.profileImg+"\'>"+
							"<p style='display: inline-block; margin: 3px auto; font-weight: bold'>"+dbuser.userName+"</p>("+dbuser.userCode+")</div>"
							
							$("#userselect").val("");
							//$(".user_list").append(chatUser);
							getChatList(socketUser);
							getChat(userinfo);
							
						});
						
						
					});
				
					$("#deleteChat").on("click", function(){
						
						swal({
							  title: "Are you sure?",
							  text: "채팅방이 사라집니다. 삭제하시겠습니까?",
							  icon: "warning",
							  buttons: true,
							  dangerMode: true,
							})
							.then((willDelete) => {
						  if (willDelete) {
								 
								  deleteChat();
								  
							    swal("Your Chatting has been deleted!", {
							      icon: "success",
							    });
							  } else {
							    swal("취소되었습니다.");
							  }
							});
						
						
						socketUser.userCode = username; //userCode 심어줌
						socketUser.profileImg ='${user.profileImg}';
						socketUser.userName = '${user.userName}';
						getChatList(socketUser);
						
					});
				
				
				
				
				//메세지 보내기
					$('#submit_btn').on("click keypress",function(e){
						
						
						socketUser.userName = '${user.userName}';
						roomId = $('input[name="roomId"]').val();
						var message = $('#message_input').val();
						var attached = $('#attached_input').val();
						selectUser = $("input[name='selectUser']").val();
						otherUser.userCode = selectUser;
						dbuser = getChatUser(selectUser);
						otherUser.userName = dbuser.userName;
						otherUser.profileImg = dbuser.profileImg;
						
						if(message != ''){
							socket.emit('send message', message, socketUser, otherUser);
							$('#message_input').val('');
						}
						$('#attached_input').val('');
						chatScrollfix();
					
						
					});
				
					$("#message_input").on("keydown", function(e){
						
						if(e.keyCode == 13 ){
							socketUser.userName = '${user.userName}';
							roomId = $('input[name="roomId"]').val();
							var message = $('#message_input').val();
							var attached = $('#attached_input').val();
							selectUser = $("input[name='selectUser']").val();
							otherUser.userCode = selectUser;
							dbuser = getChatUser(selectUser);
							otherUser.userName = dbuser.userName;
							otherUser.profileImg = dbuser.profileImg;
							
							if(message != ''){
								socket.emit('send message', message, socketUser, otherUser);
								$('#message_input').val('');
							}
							$('#attached_input').val('');
							chatScrollfix();
							
							
						}
						
					});
				
				
			});
	
	

	
	

	
	
	
	</script>
	
	
</head>
<body>
	
	
	<!-- 툴바 include -->
	<jsp:include page="../mainView/toolbar.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-8">
				<h1 style="text-align:left; font-weight: bold">VIG CHAT</h1>
			</div>
			<div class="col-4"  >
				<div style="text-align: right; vertical-align:text-bottom;" >
						<div class="input-group">
						  <input type="text" class="form-control" placeholder="Insert UserCode" id="userselect" aria-label="Recipient's username with two button addons"
						    aria-describedby="button-addon4" value="${receiver}">
						  <div class="input-group-append" id="button-addon4">
						    <button class="btn btn-md btn-outline-info m-0 px-3 py-2 z-depth-0 waves-effect" id="sendMessages" type="button">send</button>
						  </div>
						</div>
				</div>
			</div>
		
		</div>
	<hr>
		<div class="row">
			<div class="col-3">
				<h4 Style="margin-top: 10px; "> 참여중인 채팅 </h4>
				<div class="user_list">

				</div>
			
			</div>
			<div class="col-9 chatpart" >
			
				<h3 style="text-align:center; margin-top: 60px; color: gray;"> 선택된 채팅방이 없습니다.</h3>
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

						
					<input type="hidden" name="roomId">
					<input type="hidden" name="selectUser">
					<input type="hidden" name="userCode" value="${user.userCode}">
					<div class="md-form input-group mb-3" style="margin: 3px auto">
						<input style="width:600px; vertical-align: middle;background-color: white;" type="text" id="message_input" class="form-control" placeholder="메세지를 입력해주세요"
	  						aria-describedby="submit_btn">
	  					<div class="input-group-append">
							<button style="display: inline-block;" type="button" id="submit_btn" class="btn btn-md btn-secondary m-0 px-3">전송</button>
						</div>
					</div>
						
					

		
				</div>
			</div>
		</div>
	</div>
	





</body>
</html>