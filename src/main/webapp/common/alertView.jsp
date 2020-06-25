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
	
		 //history.go(-1);
		
		self.location = document.referrer;
	 </script>

</body>
</html>