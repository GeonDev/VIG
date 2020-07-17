<%@page import="com.VIG.mvc.service.domain.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>

	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
	<script type="text/javascript">


	function funcGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("action", "/purchase/listPurchase");
		$("form").submit();
	}
	
	
	$(function(){

		
		$("td:nth-child(2)").on("click",function(){					
			var url = "/product/getProduct?prodNo=";
			url = url.concat($(this).children('span').text(),"&menu=search"); 		
			self.location.href = url;
			
		});

	
	});
	
	
</script>
</head>

<body>
	<div class="col-md-8">	
	
		<div class="container">
			<div class="page-header text-info">
				<h3>신고목록조회</h3>
			</div>			
			

		
			<form method="post">			
				 
			
				<table class="table table-hover table-striped" >
					<thead>
			          <tr>
			            <th align="center">No</th>
			            <th align="left" >유저 이름</th>
			            <th align="left">최근신고횟수</th>
			            <th align="left">누적신고횟수</th>
			            <th align="left">상태</th>
			            <th align="left">처리 일시</th>
			            <th align="left">상세 보기</th>
			          </tr>
			        </thead>
				
					<tbody>
				
						<c:set var="i" value="0" />
							<c:forEach var="purchase" items="${list}">
								<c:set var="i" value="${ i+1 }" />
			
								<tr>
									<td align="center">${i}	</td>
									<td align="left" >${(purchase.purchaseProd).prodName}
										<span style="display:none" >${(purchase.purchaseProd).prodNo} </span>
									</td>
									<td align="left">${purchase.receiverName}</td>
									<td align="left">${purchase.receiverPhone}</td>												
									<td align="left">
									현재
									 	<c:choose>
								
										<c:when test="${purchase.tranCode == '1'}">		
											구매완료(배송 준비)
											</c:when>
										<c:when test="${purchase.tranCode == '2'}">
											배송중
										</c:when>
										<c:when test="${purchase.tranCode == '3'}">
											배송완료 
										</c:when>
								
										</c:choose>
									상태 입니다.					
									</td>
									<td align="left">
										<c:choose>			
											<c:when test="${purchase.tranCode =='2'}">				
												<i class="glyphicon glyphicon-ok" ></i>
												<span style="display:none" >${purchase.tranNo} </span>
											</c:when>					
										</c:choose>									
									</td>
									
									<td align="left">
									<c:if test="${purchase.tranCode == '1'}">
										<i class="glyphicon glyphicon-ok" ></i>
										<span style="display:none" >${purchase.tranNo} </span>
									</c:if>	
									</td>											
								</tr>
								
							</c:forEach>	        
		        	</tbody>
				
					</table>
					
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>	
			</form>	
		</div>	
		
		<jsp:include page="../common/pageNavigator.jsp"/>
	</div>
	
</body>
</html>