
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.VIG.mvc.service.domain.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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

				
	<script type="text/javascript">

	function funcGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("action", "getUserList");
		$("form").submit();
	}
	
	

	
	$(function() {
		$(  "td:nth-child(5) > i" ).on("click" , function() {
				var userCode = $(this).next().val();
			
				$.ajax( 
						{
							url : "json/getUser/"+userCode ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								var displayValue = "<h6 id='info'>"
															+"유저코드 : "+JSONData.userCode+"<br/>"
															+"유저네임 : "+JSONData.userName+"<br/>"
															+"성별 : "+JSONData.sex+"<br/>"
															+"생년월일 : "+JSONData.birth+"<br/>"
															+"이메일 : "+JSONData.email+"<br/>"
															+"ROLE   : "+ JSONData.role+"<br/>"
															+"</h6>";
								$("h6").remove();
								$( "#"+userCode+"" ).append(displayValue);
							}
						});
				$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
				$("h7").css("color" , "red");
				
				$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
					});			
				});	
	
	
	</script>
	<style>
	  body { font-family: "Nanum Gothic", sans-serif;}
        #myFeedMain { padding: 70px;}
       .col-md-12_top {	width: 100%; height: 100%; position: relative; margin:50px; }	 
    </style>
</head>

<body>

 <!-- 상단 툴바 자리 --> 					
      <div class="container-fluid">  
      	 <div class="row">
      		<div class="col-md-12">
      			<jsp:include page="/main/toolbar.jsp" />
     		</div>
		</div>
		
		<div class="col-md-12">
			<div class="row">
	<!-- 사이드바 자리 -->		
			<div class="col-md-2">		
		    <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
		    </div>  
		    
		    
	<!--  본문 자리 -->	      	    
		    <div class="col-md-10" id="myFeedMain">
		   <div class="col-md-12_top">
				<h2>회원목록조회</h2>				
			<hr/>		
	   
<form > 
	
	
	

	    <div class="row justify-content-end">							
					<div class="input-group md-form form-sm form-1 pl-0 col-3">
					  <div class="input-group-prepend">
					    <span class="input-group-text cyan lighten-2" id="basic-text1"><i id="searchIcon" class="fas fa-search text-white" aria-hidden="true"></i></span>
					  </div>
					  <input id="inputKeyword" class="form-control my-0 py-1" type="text" name="keyword" value="${search.keyword}" placeholder="유저코드 입력" aria-label="Search">
					</div>					
				</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		<div class="row">	
     
      <!--  table Start /////////////////////////////////////-->
    
      <table class="table table-hover table-striped" >

        <thead class="grey lighten-2">
          <tr>
            <th scope="col">No</th>
            <th scope="col" >유저코드</th>
            <th scope="col">유저네임</th>
            <th scope="col">role</th>
            <th scope="col">간략정보</th>
          </tr>
        </thead> 
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="user" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td scope="col">${ i }</td>
			  <td scope="col" title="Click : 회원정보 확인">${user.userCode}</td>
			  <td scope="col">${user.userName}</td>
			   <td scope="col">${user.role}</td>
			  <td scope="col">
			  	<i class="fas fa-check"></i>
			  	<input type="hidden" value="${user.userCode}">
			  	<span id="${user.userCode}" > </span>
			  </td>
			  	
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value=""/>	
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	</form>
 	<div class="row justify-content-md-center">
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>
				
			</div>
			</div>
		</div>
	</div>
	</div>
	
			
			
			
</body>
</html>
