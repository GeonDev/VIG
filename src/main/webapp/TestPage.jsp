<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.VIG.mvc.service.domain.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>
			
	<script type="text/javascript">
/*
	$(function(){
		$( ".test" ).on("click" , function() {	
			location.href="/user/listUser";
		});
	});
	*/
	 $( function() {
			$(".test").on("click" , function() {
				location.href="getUserList";
			});
		});		
	</script>
</head>
<body>
???<input type="button" class="test" value="test" >
<form role="form" method="post" action="getUserList">
<div id="root">
<c:forEach items="${List}" var = "list">
							<tr>
								<td><c:out value="${list.userCode}" /></td>
								<td><c:out value="${list.userName}" /></td>
								<td><c:out value="${list.email}" /></td>
								<td><c:out value="${list.role}" /></td>
								 <td align="left">${list.userCode}</td>
								 <td align="left">${list.userName}</td>
</tr>
</c:forEach>
</div>
???
 ${list.userCode}
						${list.userName}
</form>
			
</body>
</html>