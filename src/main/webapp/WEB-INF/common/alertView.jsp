<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

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