<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

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
		
	<script src="res/javascript/jQuery.tagify.min.js"></script>
 	<link rel="stylesheet" href="res/css/tagify.css">
 	<!--  drag and drop -->
 	<script src="res/javascript/dropify.js"></script>
 	<link rel="stylesheet" href="res/css/dropify.min.css">
		<script type="text/javascript">
					
		
		//뒤로가기 방지
		 window.history.forward();
		 function noBack(){window.history.forward();}
		
		//탈퇴 모달 창에서 탈퇴 재확인
		$(function() {
		$("#deleteCheck_btn").on("click", function(){	
			
			var check = $("input[name='check']:checked").val();			 				
			var password = $("input[name=password]").val();
			var password2 = $("input[name=password2]").val();	
				
				
				if(password == null || password.length <1){
					alert("패스워드는  반드시 입력하셔야 합니다.");
					return;
				}
			
				if( password != password2){		
					alert("비밀번호를 확인해주세요.");
					return;
				}
				
				if (check != 'true') {
					alert("약관에 동의해주세요.");
					return;
				}
				
				if(password==password2){
					if (check == 'true'){
						$("form").attr("method","POST").attr("action","deleteUser").submit();	
						alert("이용해 주셔서 감사합니다.")
				}
				if (check != 'true') {
					alert("약관에 동의해주세요.");
		    		return;
				}
				}
			});	
		});
		
	
		</script>
	
<style type="text/css">
		
		body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
		h1 { margin-left: 100px;}
		.col-md-12{ margin-bottom: 50px;}
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}	
		
		#warning{ color: red;}
</style>		
	
</head>
<body>
	<!-- 뒤로가기방지 -->
	<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	
	<c:set var="test1" value="tt" scope="request" />


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
			<h1>계정 탈퇴</h1><hr/>
			

		<form>
		<div class="container-fluid" style="width:50%; float:center; margin: auto; margin-top:100px">
		
		 탈퇴 후 회원정보가 모두 삭제됩니다.<p>
		 아이디,닉네임,이메일 등 회원정보가 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br>
		 삭제된 아이디로 재 가입이 불가능합니다.
		<br/>
		<br/>
		 탈퇴 후에도 작성된 게시글은 그대로 남아 있습니다.<br>
		 각 게시판에 등록한 게시물 및 댓글은 탈퇴 후에도 남아있습니다.<br>
		 삭제를 원하시는 게시물은 탈퇴 전 반드시 삭제하시기 바랍니다.<p>
		  (탈퇴 후에는 게시글 임의 삭제 요청을 받지 않습니다.)
		  <hr/>
		 <div id="warning"> *탈퇴 후에는 게시판의 게시글은 삭제할 수 없으며, 위의 안내 내용에 동의합니다. </div>
		  <hr/>
		  <input type="checkbox" name="check" value="true"> 안내사항을 모두 동의하며, 이의제기를 하지않습니다. (필수)
		
		<input type="hidden" name="userCode" value="${user.userCode}">
		
		<!-- 비밀번호 -->
		<div class="form-group" style="height:70px; margin:0; ">
		    <input type="password" id="password" name="password" class="form-control" placeholder="password" maxlength="8" required>
		</div>
		
		<!-- 비밀번호2 -->   
		<div class="form-group" style="height: 70px;">  
			 <input type="password" id="password2" name="password2" class="form-control " placeholder="Password2" " required>
		     <label data-error="wrong" data-success="right" for="password2"></label>
			 <span id="helpBlock" class="help-block" >
				<span class="check" style="margin-bottom:0px;"></span>
			</span>
		</div>
	
			<div class="modal-footer justify-content-center" style="border:0;">
	        	<a type="button" class="btn btn waves-effect" id="deleteCheck_btn" style="color: slategrey;">탈퇴 <i class="fas fa-paper-plane-o ml-1"></i></a>
	        	<a type="button" class="btn btn waves-effect" id="cancelDeleteUser" onClick="history.go(-1);" style="color: slategrey;">
	        	취소 <i class="fas fa-paper-plane-o ml-1"></i></a>
	     	</div>
	     	</div>

	     	</form>		 	
			
</body>
</html>