<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>

<!-- SocketJS CDN -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<!-- favicon 영역 이후 툴바 적용 -->
<link rel="shortcut icon" type="image/png" href="http://127.0.0.1:8080/VIG/images/others/favicon-16x16.png">


<script type="text/javascript">

	//유저가 로그인했는지 체크를 위한 변수
	var chackUserLogin = '${sessionScope.user}';

	// 소켓을 담기위한 변수
	var sock;
	
	
	function setLikeAlarm(item) {
		var data = (item).split(',');    
	    
		var addAlarms = 
			"<li id='alarm_" + data[6] + "' class='alarms'>"
			+ "<a href='/VIG/myfeed/getMyFeedList?userCode="+ data[5]+ "' style='padding:0px;'>"
	   	 		+"<img src='/VIG/images/uploadFiles/" + data[1]+ "' class='rounded-circle' style='width: 45px; float:left; '>"
	   	 	+"</a>"
	   	 	+ "<a  href='/VIG/feed/getFeed?feedId="+ data[0]+ "' style='padding:0px;'>"
	   	 		+"<h6  style='width: 270px; margin-right:5px; margin-left:10px; margin-top: 7px; float:left;'>"
	   	 			+"<strong>" + data[2]+ "</strong>님이 좋아요를 누르셨습니다."	    			
				+"</h6>"
				+"<img src='/VIG/images/uploadFiles/" + data[3] + "' style='width: 50px; '>"
			 +"</a>"		
	        +"</li><hr/>";  
	    
	    $("#addAlarm").prepend(addAlarms);
	}
	
	
	function setCommentAlarm(item) {
		var data = (item).split(',');
		
		var addAlarms = 
	    	"<li id='alarm_" + data[6] + "' class='alarms'>"
	    	+ "<a href='/VIG/myfeed/getMyFeedList?userCode="+ data[5]+ "' style='padding:0px;'>"
	   	 		+"<img src='/VIG/images/uploadFiles/" + data[1]+ "' class='rounded-circle' style='width: 45px; float:left;'>"
	   	 	+"</a>"
	   	 	+ "<a class='nav-link' href='/VIG/feed/getFeed?feedId="+ data[0]+ "'>"
	   	 		+"<h6  style='width: 270px; margin-right:5px; margin-left:5px; float:left;'>"
	   	 			+"<strong>" + data[2]+ "</strong>님이 댓글을 남겼습니다."	    			
				+"</h6>"
				+"<img src='/VIG/images/uploadFiles/" + data[3] + "' style='width: 45px;'>"
			 +"</a>"		
	        +"</li>"
	        +"<div class='dropdown-divider'></div>";   			    
	    
	    
	    $("#addAlarm").prepend(addAlarms);
	}
	
	function setFollowAlarm(item) {
		var data = (item).split(',');
		
		var addAlarms = 
	    	"<li id='alarm_" + data[6] + "' class='alarms'>"
	    	+ "<a href='/VIG/myfeed/getMyFeedList?userCode="+ data[5]+ "' style='padding:0px;'>"
	   	 		+"<img src='/VIG/images/uploadFiles/" + data[1]+ "' class='rounded-circle' style='width: 45px; float:left;'>"
	   	 	+"</a>"	 
		   	 	+"<div style='height: 45px; margin-top:10px;'>"
		   	 		+"<h6 style='width: 320px; padding-left:55px; padding-top:10px;'>"
		   	 			+"<strong>" + data[2]+ "</strong>님이 당신을 팔로우합니다."	
		   	 		+"</h6>"
		   	 	+"</div>"
	        +"</li>"
	        +"<div class='dropdown-divider'></div>";   			    
	    
	    
	    $("#addAlarm").prepend(addAlarms);
	}
	
	
	//최초 알람 세팅용 - 읽지 않은 알람을 불러온다.
	function getAlarmList() {		
		
		$.ajax( 
				{
					url : "/VIG/alarm/json/getAlarmList",
					method : "GET",
					dataType : "Json",					
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},					
					success : function(JSONData , status) {
						
						if(JSONData !=null){
							
							//디폴트를 삭제한다.
							$("#defaultAlarm").remove();
							
							$.each(JSONData, function(index, item) { 
								
								console.log(item);
								
								var data = (item).split(',');
								
								if(data[4] == '0'){
							    	setLikeAlarm(item);
							    }else if(data[4] == '1'){
							    	setCommentAlarm(item);
							    }else{
							    	setFollowAlarm(item);
							    }
									
							});	
							
						}					
 							
					}
			});		
	}
	
	
	//읽은 알람 확인 용 함수
	function getCheckAlarms(id) {		
		$.ajax( 
				{
					url : "/VIG/alarm/json/getCheckAlarms/"+id,
					method : "GET",
					dataType : "Json",					
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},					
					success : function(JSONData , status) {							
 							
					}
			});		
	}
	
	
	
	
	
	//알람 받을 유저의 유저코드, 피드ID(없으면 ''), 알람타입(0= 좋아요, 댓글, 팔로우) 
	function sendMessage(userCode, feedID, alarmType){         	
		sock.send(userCode+","+ feedID+","+ alarmType);
	}
	
	
	//evt 파라미터는 웹 소켓을 보내준 데이터다.(자동으로 들어옴)
	function onMessage(evt){					

		//노티 표시
		$("#AlarmNoti").css('display','inline');
		
		//디폴트가 있는지 확인하고 삭제한다.
		if ($('#defaultAlarm').length) {						
			$("#defaultAlarm").remove();
		}
		
	    var data = (evt.data).split(',');				    
	    console.log((evt.data));
	    
	    //좋아요를 눌렀을 경우
	    if(data[4] == '0'){
	    	setLikeAlarm((evt.data));
	    	
	    //댓글을 남겼을 경우	
	    }else if(data[4] == '1'){
	    	setCommentAlarm((evt.data));
	    	
	    //팔로우를 했을 경우	
	    }else{
	    	setFollowAlarm((evt.data));
	    	
	    }
	    //sock.close();
	}

	function onClose(evt){
	    $("#data").append("연결 끊김");
	}
	
	
	
	
	
	//제이쿼리 실행 부분
	$(function() {
		
			//읽지 않은 알람을 세팅한다.
			getAlarmList();
			
			//===로그인
			//$( "#login_btn:contains('Log in')" ).on("click" , function() {
			//	$(self.location).attr("href","/VIG/user/login");
			//}); 
			
			//loginView.jsp를 가지고 와서 모달로 띄움
			$('#theModal').on('show.bs.modal', function(e) {		
					var button = $(e.relatedTarget);
					var modal = $(this);
					
					modal.find('.modal-body').load(button.data("remote"));
				
			});
			
			//===로그아웃	
			$(".dropdown-item:contains('Log Out')" ).on("click" , function() {			
					$(self.location).attr("href","/VIG/user/logout");
			}); 
			
			
			if(chackUserLogin !=null){
				//웹 소켓을 생성한다.
				
				sock = new SockJS("<c:url value="/echo"/>");
				
				//자바스크립트 안에 function을 집어넣을 수 있음.
				//데이터가 나한테 전달되었을때 자동으로 실행되는 function
				sock.onmessage=onMessage;
				
				//데이터를 끊고싶을때 실행하는 메소드
				sock.onclose = onClose;				
			}
			
			
			//알람 버튼을 클릭하면 레드닷 숨김
			$("#Alarmbell").on("click", function(){									
				$("#AlarmNoti").css('display','none');
			});
			
			
			$(document).on('click','li.alarms',function(){			
				
				var id = ($(this).attr('id')).split('_'); 				 				 
				getCheckAlarms(id[1]);
			})
			
			
	
		});				
			
			
	</script>	
	
	<style>
	
	#logoTop{
	 width: auto;
	 height: 38px;
	}
	#login_btn , #logout_btn{
	color: white;
	}
	
	.fas_ntn{
	color: #ffb74d;
	}
	
	.alarms{
		margin-left: 10px;
	}	
	
	#black_wr{
	color: black;
	}
	
	#logout_btn{
	margin-left:50px;
	}
	
	#logout_btn{
	margin:0;
	}
	
	#white_wr{
	color: white;
	}
	
	.dropdown-toggle::after {
    display:none;
	}
	
	</style>	
	
</head>		 
<body>
	

<!--Navbar start-->	
			<nav class="mb-1 navbar fixed-top navbar-expand-xl navbar-dark bg-dark py-2" id="toolbar">			
<!-- 로고 -->		
			  <a href="/VIG/main/VIG"><img src='/VIG/images/others/viglogo.png' id="logoTop" alt="VIG" style="margin-left: 30px;" ></a>
			      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="toolbar_logo"
				    aria-controls="toolbar_logo" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				   <div class="collapse navbar-collapse" id="toolbar_logo" >
   					 <ul class="navbar-nav ml-auto">
				 </ul>		
<!-- 검색 버튼-->    	      
	        <a class="nav-link waves-effect waves-light"  href="/VIG/search/getSearchList">
	          <i class="fas fa-search fas_ntn" ></i>
	        </a>	   
<!-- 알람버튼 -->
				<c:if test="${!empty sessionScope.user }"> 
                  <li class="dropdown ">                 
                     <i id="Alarmbell" class="fas fa-bell fas_ntn dropdown-toggle"  data-toggle="dropdown" aria-expanded="false" style="margin-right: 15px;">
                     	<i id="AlarmNoti" class="fas fa-circle" style="color: red; font-size: xx-small; float: right; display: none;"></i>
                     </i>                    
                     
                     <ul class="dropdown-menu dropdown-menu-right" style="width: 400px; margin-top: 20px;">  
                     	<h5 style="font-weight: bold; font-weight: bold;justify-content: center; display: flex; height: 35px; padding-top:10px; color:#6c757d;">&ensp;내 활동</h5>
                     	<div class="dropdown-divider"></div>                          
         				<li id="defaultAlarm" style="margin-left: 5px;">
         					<h6>새로운 소식이 없습니다.</h6>
         				</li>
         				<div id="addAlarm"></div>
                     </ul>    
                 </li>
				</c:if>
	              
<!-- 채팅버튼 -->    
			<c:if test="${!empty sessionScope.user }">   
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="/VIG/chat/getChat">
	          <i class="fas fa-comments fas_ntn" ></i></a>
   			</c:if>
   			
<!-- //비로그인 상태 -->
<!-- 로그인 클릭시 모달 -->
			<c:if test="${empty sessionScope.user }"> 
			  <a class="nav-link" data-remote="/VIG/user/loginView.jsp"
				data-toggle="modal" data-target="#theModal" ><span id="white_wr" style="margin-right: 30px;">Log in</span></a>
			</c:if> 
	
<!-- //로그인 후 드롭다운 -->
		<!-- 유저 로그인시 -->
			<c:if test="${ sessionScope.user.role == 'user' || sessionScope.user.role == 'business'}"> 
				<li class="dropdown">
		             <a href="#" class="dropdown-toggle" id="login_dropdown" data-toggle="dropdown"
						 role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user" style="margin-right:30px; color: #fb3;"></i>
						   <span class="caret"></span>
					</a>
		         <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="login_dropdown" style="margin-top: 20px;">		         	
					<h4 class="dropdown-header" style="text-align:left;  font-weight: bold; font-size: large; ">
						<img src="/VIG/images/uploadFiles/${user.profileImg}" class="rounded-circle" style="width: 50px;">
						${user.userName}
					</h4>
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/myfeed/getMyFeedList?userCode=${user.userCode}" style="display: flex;justify-content: center;" >My Feed</a>
						    <a class="dropdown-item" href="/VIG/feed/addFeed.jsp" style="display: flex;justify-content: center;">Upload</a>
						  <div class="dropdown-divider"></div>
						      <a class="dropdown-item" style="display: flex;justify-content: center;">Log Out</a>
						 </div>
		      		 </c:if>
		   <!-- 관리자 로그인시 -->
		       <c:if test="${ sessionScope.user.role == 'admin'}"> 
				<li class="dropdown">
		             <a href="#" class="dropdown-toggle" id="login_dropdown" data-toggle="dropdown"
						 role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user" style="margin-right:30px; color: #fb3;"></i>
						   <span class="caret"></span>
						</a>
		         <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="login_dropdown">
					<h6 class="dropdown-header" style="text-align:left;  font-weight: bold; font-size: large; ">${user.userCode }</h6>
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/user/getUserList" style="display: flex;justify-content: center;">관리자페이지</a>	
						    <div class="dropdown-divider"></div>
						      <a class="dropdown-item"  id="logout_btn" ><p id="black_wr" style="display: flex;justify-content: center;">Log Out</p></a>					   
							 </div>
					       </c:if>		
				     	</div>
				      </nav>
					<br/>	
			</body>

<!-- 모달 메인 :툴바 고정해놓으면 바디태그안에서 모달 작동x -->
		
			<div class="modal fade" id="theModal" role="dialog" >
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header"></div>
							<form action="/VIG/user/login" method="POST">
							<div class="modal-body"></div>
								</form>
							<div class="modal-footer">
							</div>
						</div>
					</div>
				</div>
			
</html>