<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<!DOCTYPE html>
<html>
<head>


</head>
<body>
	<script>	
		var message ="<c:out value="${message}"/>"; 			
		alert(message);					
	
		//이전페이지 정보가 있는지 체크
		if(document.referrer){
			self.location = document.referrer;
		}else{
			//페이지 정보가 없으면 메인으로 이동
			location.href = '/VIG/main/VIG';
		}		
		
	 </script>

</body>
</html>