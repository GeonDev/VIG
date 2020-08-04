<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>VIG</title>

<!-- SocketJS CDN -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>


<script type="text/javascript">

	var chackUserLogin = '${sessionScope.user}';

	
	function setLikeAlarm(data) {
		var data = (item).split(',');    
	    
		var addAlarms = 
	    	"<li style='margin-left: 5px;'>"
	   	 	+ "<a class='nav-link' href='/VIG/feed/getFeed?feedId='"+ data[0]+ ">"
	   	 		+"<h6><img src='/VIG/images/uploadFiles/" + data[1]+ "' class='rounded-circle' style='width: 30px;'>"
	   	 			+"<strong>" + data[2]+ "</strong>님이 좋아요를 누르셨습니다."
	    			+"<img src='/VIG/images/uploadFiles/" + data[3] + "' style='width: 30px;'>"
				+"</h6>" 
			 +"</a>"
	        +"</li>";  			    
	    
	    
	    $("#addAlarm").append(addAlarms);
	}
	
	
	function setCommentAlarm(data) {
		var data = (item).split(',');
		
	    var addAlarms = 
	    	"<li style='margin-left: 5px;'>"
	   	 	+ "<a class='nav-link' href='/VIG/feed/getFeed?feedId='"+ data[0]+ ">"
	   	 		+"<h6><img src='/VIG/images/uploadFiles/" + data[1]+ "' class='rounded-circle' style='width: 30px;'>"
	   	 			+"<strong>" + data[2]+ "</strong>님이 댓글을 남겼습니다."
	    			+"<img  src='/VIG/images/uploadFiles/" + data[3] + "' style='width: 30px;'>"
				+"</h6>" 
			 +"</a>"
	        +"</li>";  			    
	    
	    
	    $("#addAlarm").append(addAlarms);
	}
	
	
	//최초 알람 세팅용 - 읽지 않은 알람을 불러온다.
	function getAlarmList() {		
		
		$.ajax( 
				{
					url : "/VIG/alarm/json/getAlarmList",
					method : "POST",
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
								
								var data = (item).split(',');
								
								if(data[4] == 0){
							    	setLikeAlarm(data);
							    }else if(data[4] == 1){
							    	setCommentAlarm(data);
							    }
									
							});	
							
						}
						
						

 						
 							
					}
			});		
	}
	
	
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
			});	
			
			if(chackUserLogin !=null){
				//웹 소켓을 생성한다.
				var sock;
				sock = new SockJS("<c:url value="/echo"/>");
				
				//자바스크립트 안에 function을 집어넣을 수 있음.
				//데이터가 나한테 전달되었을때 자동으로 실행되는 function
				sock.onmessage=onMessage;
				
				//데이터를 끊고싶을때 실행하는 메소드
				sock.onclose = onClose;				
			}

				
				//알람 받을 유저의 유저코드, 피드ID(없으면 ''), 알람타입(0= 좋아요, 댓글, 팔로우) 
				function sendMessage(userCode, feedID, alarmType){         	
					sock.send(userCode+","+ feedID+","+ alarmType);
				}
				
				
				//evt 파라미터는 웹 소켓을 보내준 데이터다.(자동으로 들어옴)
				function onMessage(evt){
					
					//디폴트가 있는지 확인하고 삭제한다.
					if ($('#defaultAlarm').length) {						
						$("#defaultAlarm").remove();
					}
					
				    var data = (evt.data).split(',');				    
				    
				    if(data[4] == 0){
				    	setLikeAlarm(data);
				    }else if(data[4] == 1){
				    	setCommentAlarm(data);
				    }
				    
	
				    //sock.close();
				}
	
				function onClose(evt){
				    $("#data").append("연결 끊김");
				}
			
			
	</script>	
	
	<style>
	
	#logoTop{
	 width: 90px;
	 height: 40px;
	}
	#login_btn , #logout_btn{
	color: white;
	}
	
	.fas_ntn{
	color: #ffb74d;
	}
	p{
	color: black;
	}
	#logout_btn{
	margin-left:50px;
	}
	#logout_btn{
	margin:0;
	}
	span{
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
			  <a href="/VIG/main/VIG"><img src='/VIG/images/others/VIG_logo.png' id="logoTop" alt="VIG" ></a>
			      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="toolbar_logo"
				    aria-controls="toolbar_logo" aria-expanded="false" aria-label="Toggle navigation">
				    <span class="navbar-toggler-icon"></span>
				  </button>
				   <div class="collapse navbar-collapse" id="toolbar_logo">
   					 <ul class="navbar-nav ml-auto">
				 </ul>		
<!-- 검색 버튼-->    	      
	        <a class="nav-link waves-effect waves-light"  href="/VIG/search/getSearchList">
	          <i class="fas fa-search fas_ntn" ></i>
	        </a>	   
<!-- 알람버튼 -->
                  <li class="dropdown ">                 
                     <i class="fas fa-bell fas_ntn dropdown-toggle"  data-toggle="dropdown" aria-expanded="false" style="margin-right: 15px;"></i>                    
                     
                     <ul id="addAlarm" class="dropdown-menu dropdown-menu-right" style="width: 350px;">                                   
         				<li id="defaultAlarm" style="margin-left: 5px;">
         					<h6>새로운 소식이 없습니다.</h6>
         				</li>
                     </ul>
                 </li>
		
	              
<!-- 채팅버튼 -->      
	        <a class="nav-link waves-effect waves-light" id=" chat_btn" href="#">
	          <i class="fas fa-comments fas_ntn" ></i></a>
   	
<!-- //비로그인 상태 -->
<!-- 로그인 클릭시 모달 -->
			<c:if test="${empty sessionScope.user }"> 
			  <a class="nav-link" data-remote="/VIG/user/loginView.jsp"
				data-toggle="modal" data-target="#theModal" ><span>Log in</span></a>
			</c:if> 
	
<!-- //로그인 후 드롭다운 -->
		<!-- 유저 로그인시 -->
			<c:if test="${ sessionScope.user.role == 'user' || sessionScope.user.role == 'business'}"> 
				<li class="dropdown">
		             <a href="#" class="dropdown-toggle" id="login_dropdown" data-toggle="dropdown"
						 role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user"></i>
						   <span class="caret"></span>
					</a>
		         <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="login_dropdown">		         	
					<h4 class="dropdown-header" style="text-align:left;  font-weight: bold; font-size: large; padding-left: 0px; margin-left: 5px; ">
						<img src="/VIG/images/uploadFiles/${user.profileImg}" class="rounded-circle" style="width: 50px;">
						${user.userName}
					</h4>
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/myFeed/myFeed.jsp" >My Feed</a>
						    <a class="dropdown-item" href="#">Upload</a>
						  <div class="dropdown-divider"></div>
						      <a class="dropdown-item" >Log Out</a>
						 </div>
		      		 </c:if>
		   <!-- 관리자 로그인시 -->
		       <c:if test="${ sessionScope.user.role == 'admin'}"> 
				<li class="dropdown">
		             <a href="#" class="dropdown-toggle" id="login_dropdown" data-toggle="dropdown"
						 role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user"></i>
						   <span class="caret"></span>
						</a>
		         <div class="dropdown-menu dropdown-menu-right dropdown-default" aria-labelledby="login_dropdown">
					<h6 class="dropdown-header">${user.userCode }</h6>
						 <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/VIG/myFeed/myFeed.jsp">관리자페이지</a>	
						    <div class="dropdown-divider"></div>
						      <a class="dropdown-item"  id="logout_btn" ><p>Log Out</p></a>					   
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