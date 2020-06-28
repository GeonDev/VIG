<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  

<!DOCTYPE html>
<html>
<head>

	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	
	<!-- SocketJS CDN -->
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
	
	<script type="text/javascript">
    
    $(document).ready(function(){
        $("#sendBtn").click(function(){
            sendMessage();
        });
    });
    
    //웹 소켓을 생성한다.
    var sock;
    sock = new SockJS("<c:url value="/echo"/>");
    
    //자바스크립트 안에 function을 집어넣을 수 있음.
    //데이터가 나한테 전달되었을때 자동으로 실행되는 function
    sock.onmessage=onMessage;
    
    //데이터를 끊고싶을때 실행하는 메소드
    sock.onclose = onClose;
    

    function sendMessage(){         	
    	sock.send($("#userId").val() +"," +$("#message").val()  );
    }
    
    //evt 파라미터는 웹 소켓을 보내준 데이터다.(자동으로 들어옴)
    function onMessage(evt){
        var data = evt.data;
        $("#data").append(data+"<br/>");
        //sock.close();
    }
    
    function onClose(evt){
        $("#data").append("연결 끊김");
    }
    
</script>
</head>

<body>
	<h1>Chatting Tester</h1>
	<hr/>
	<input type="text" id="userId" placeholder="보낼 유저명"/>
	<input type="text" id="message" placeholder="내용"/>
	<input type="button" id="sendBtn" value="전송"/>
	<div id="data"></div>
</body>
</html>


