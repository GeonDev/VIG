
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
	
	$(function(){
		$("#inputKeyword").keydown(function(key) {
            if (key.keyCode == 13) {
            	funcGetList(1);
            }
		});
	});

	
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
	  body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
		h1 { margin-left: 100px;}
		/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	 
	 
        #myFeedMain { padding: 70px;}
       .col-md-12_top {	width: 100%; height: 100%; position: relative; margin:50px; }	 
    </style>
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
			    				
					<h1>회원목록조회</h1>				
					<hr/>		
	   

		<form method="post" >			
		    <div class="row justify-content-end" style="margin: 45px 10px 27px 10px;">							
						
						<div class="input-group md-form form-sm form-1 pl-0 col-3">
						  <div class="input-group-prepend">
						   <span class="input-group-text " id="basic-text1"><i class="fas fa-search" class="fas fa-search text-white" aria-hidden="true"></i></span>
						  <select class="form-control" name="searchCondition" style="width:80px">
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
							<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
						</select>
						  <input id="inputKeyword" class="form-control form-control-sm ml-3 w-75" type="text" name="keyword" value="${search.keyword}" placeholder="Search" aria-label="Search">
						  </div>				
					</div>
					</div>
			<!-- table 위쪽 검색 Start /////////////////////////////////////-->
			
			<div class="row" style="flex-wrap: wrap;margin-right: 40px;margin-left: 50px;">
	     
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
	
	
			<input type="hidden" id="currentPage" name="currentPage" value=""/>	
	 	</div>
 	</form>
 	
 	
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	<div class="row justify-content-md-center" >
				<jsp:include page="../common/pageNavigator.jsp"/>
			</div>
				
			</div>
	
	</div>
	
			
			
			
</body>
</html>
