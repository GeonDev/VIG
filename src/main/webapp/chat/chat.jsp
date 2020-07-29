<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>소켓 서버</title>
        <style>
			#chat_box {
			    width: 800px;
			    min-width: 800px;
			    height: 500px;
			    min-height: 500px;
			    border: 1px solid black;
			}
			#msg {
			    width: 700px;
			}
			#msg_process {
			    width: 90px;
			}
			</style>
    </head>
    <body>
    
    	<!-- 소켓을 연결함  툴바에 넣어줘야함-->
         <div id="chat_box"></div>
		    <input type="text" id="msg">
		    <button id="msg_process">전송</button>
		 
		    <script src="http://192.168.0.13:82/socket.io/socket.io.js"></script>
		    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		    <script>
		            $(document).ready(function(){
		                var socket = io("http://192.168.0.13:82");
		                
		                //msg에서 키를 누를떄
		                $("#msg").keydown(function(key){
		                    //해당하는 키가 엔터키(13) 일떄
		                    if(key.keyCode == 13){
		                        //msg_process를 클릭해준다.
		                        msg_process.click();
		                    }
		                });
		                
		                //msg_process를 클릭할 때
		                $("#msg_process").click(function(){
		                    //소켓에 send_msg라는 이벤트로 input에 #msg의 벨류를 담고 보내준다.
		                     socket.emit("send_msg", $("#msg").val());
		                    //#msg에 벨류값을 비워준다.
		                    $("#msg").val("");
		                });
		                
		                //소켓 서버로 부터 send_msg를 통해 이벤트를 받을 경우 
		                socket.on('send_msg', function(msg) {
		                    //div 태그를 만들어 텍스트를 msg로 지정을 한뒤 #chat_box에 추가를 시켜준다.
		                    $('<div></div>').text(msg).appendTo("#chat_box");
		                });

		            });
		        </script>

    </body>
</html>