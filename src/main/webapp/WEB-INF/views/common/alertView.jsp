<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<!DOCTYPE html>
<html>
<head>
 <script src="https://code.jquery.com/jquery-latest.js"></script> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


	<!-- Font Awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<!-- Bootstrap core CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
				
<!-- JQuery -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</head>


 <style>
        
        /* 모달 바탕 */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; /
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4);
        }
    
        
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; 
            padding: 50px;
            border: 1px solid #888;
            width: 30%;                       
        }
 
</style>




<body>


    <div id="myModal" class="modal">
      <div class="modal-content">
   
      	<p style="text-align: center;">${message}</p>    	
     	 
     	 <button  class="btn btn-block my-4" id="login" style="background-color: #212121; color: white;" 
     	 onClick="close_pop();">close</button>   
            </div>
		</div>
		

	<script>	
	
	jQuery(document).ready(function() {
        $('#myModal').show();
    });
	
    //팝업 Close 기능
    function close_pop(flag) {
         $('#myModal').hide();
         if(document.referrer){
     		self.location = document.referrer;
     	}else{
     		//페이지 정보가 없으면 메인으로 이동
     		location.href = '/VIG/main/VIG';
     	}	
    };
	
	
	/*
	var message ="<c:out value="${message}"/>"; 			
	
	
	alert(message);					

	//이전페이지 정보가 있는지 체크
	if(document.referrer){
		self.location = document.referrer;
	}else{
		//페이지 정보가 없으면 메인으로 이동
		location.href = '/VIG/main/VIG';
	}		
	*/
		
	
	 </script>

</body>
</html>