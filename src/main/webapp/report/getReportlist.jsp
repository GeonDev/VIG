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
	 	body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
		h1 { margin-left: 100px;}
		/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	 
	 
        #myFeedMain { padding: 70px;}
        .col-md-12_top {	width: 100%; height: 100%; position: relative; margin:50px; }	
    </style>
    
	<script type="text/javascript">
	function funcGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("action", "./getReportList");
		$("form").submit();
	}
	
	
	$(function(){
		
		$("td:nth-child(7)").on("click",function(){					
			var url = "./getReportListFromUser?userCode=";
			url = url.concat($(this).children('span').text()); 		
			self.location.href = url;			
		});
		
		$("#searchIcon").on("click", function() {			
			funcGetList(1);
		});
		
        $("#inputKeyword").keydown(function(key) {
            if (key.keyCode == 13) {
            	funcGetList(1);
            }
        });
	
	});
	
	
</script>
</head>

<body>

<!-- 툴바 -->
		      <div class="container-fluid">  
		      	 <div class="row">
		      		<div class="col-md-12">
		      			<jsp:include page="/main/toolbar.jsp"></jsp:include>
		     		</div>
				</div>
		
		
			<!-- 사이드바  -->		
				<div class="col-md-2 sideBarPlace">		
				 <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
				 </div>
  			<!-- 타이틀 -->
			    <div class="col-md-10" id="mainMyFeedPage" >	
				<h1>신고목록조회</h1>				
			<hr/>		
		
			<form method="post" >
				<div class="row justify-content-end" style="margin: 45px 10px 27px 10px;">							
					<div class="input-group md-form form-sm form-1 pl-0 col-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text " id="basic-text1"><i id="searchIcon" class="fas fa-search text-white" aria-hidden="true"></i></span>
					  </div>
					  <input id="inputKeyword" class="form-control my-0 py-1" type="text" name="keyword" value="${search.keyword}" placeholder="유저코드 입력" aria-label="Search">
					</div>					
				</div>
			
				<div class="row" style="flex-wrap: wrap;margin-right: 40px;margin-left: 50px;">	
				
					<table class="table table-hover table-striped" >
						<thead class="grey lighten-2">
				          <tr>
				          	<th align="left">no</th>				          					            
				            <th align="left">유저 코드</th>				           
				            <th align="left">최근신고횟수</th>
				            <th align="left">누적신고횟수</th>
				            <th align="left">유저상태</th>
				            <th align="left">처리 일시</th>
				            <th align="left">상세 보기</th>
				          </tr>
				        </thead>				
							<tbody>
						
								<c:set var="i" value="0" />
									<c:forEach var="report" items="${list}">
										<c:set var="i" value="${ i+1 }" />
					
										<tr>
											<td align="left" >${i}</td>
											<td align="left" >${(report.violator).userCode}</td>											
											<td align="left">${report.currentCount}</td>
											<td align="left">${report.totalCount}</td>												
											<td align="left">									
											 	<c:choose>								
												<c:when test="${(report.violator).state == '0'}">		
													정상
												</c:when>
												<c:when test="${(report.violator).state == '1'}">
													3일 접속제한
												</c:when>
												<c:when test="${(report.violator).state == '2'}">
													7일 접속제한 
												</c:when>
												<c:when test="${(report.violator).state == '3'}">
													영구 정지
												</c:when>								
												</c:choose>													
											</td>
											<td align="left">${(report.violator).banDate}</td>									
											<td align="left">									
												<i class="fas fa-check"></i>
												<span style="display:none" >${(report.violator).userCode} </span>									
											</td>											
										</tr>
										
									</c:forEach>	        
				        	</tbody>				
						</table>
						
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value=""/>	
				</div>
			</form>
			
				
			<div class="row justify-content-md-center">
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>			
			</div>
		</div>	
	
</body>
</html>