<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>VIG</title>

<!-- JQuery -->
	
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

	
<style>
	
	body {
	
	
		background-color: #F9F9F9;	
	
	}
	
	#outline {
	
		width: 1300px;
		margin: 70px auto;
		
	}
	
	#main { 
		
		width: 960px;
		margin: 0 auto;
		
	}
	
	#image {
	  margin: 7px auto;
	  display: block;
	  background: rgb(240, 240, 240);
	}
	
	
	#writerInfo {

    display: table-cell;
    vertical-align: middle;

	
	}
	#writerName {
	
	margin-top: 10px;
	font-size: 18px;
	color: #000000;
	font-style: bold;
		
	}
	
	#scrolltop {
	  position: fixed;
	  left: 85%;
	  bottom: 50px;
	}
	
	#profile {
	 display: inline-block;	
	 margin-top: 10px;
	}
	.fa-heart {
	
	color: red;
	
	}
	
	#modalbutton {
	
	color: red;
	
	}
	.feedbottom {
	
	border: 1px solid #DADADA;
	padding: 10px 5px 10px 8px;
	border-radius: 5px;
	background-color: white;
	
	}
	
	#comform {
	
		padding: 0px 0px 0px 13px;
	
	}
	#combutton {
	
	padding: 0px 0px;
	
	}
	#donation {
	
	display:inline-block;
	width: 35px;
	height: 35px;
	border-radius: 23px;
	background-color: #5CA45B;
	padding: 3px 3px 3px 9px;
	

	
	}
	#donation i {
	
	align: center;
	vertical-align: middle;
	color: White;
	font-size: 27px;
	
	}
	
	.color {
	
	display:inline-block;
	width: 35px;
	height: 35px;
	border-radius: 23px;
	background-color: #5CA45B;
	margin: 5px 10px 5px 10px;
	border: 1px solid white;
	
	}
	
	@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
	#tag {
	
	 font-family: 'Nanum Gothic';
	
	
	
	}
	
	#deleteCom{
		float:right;
		color:#2F4F4F;
	}
	
	#top {
	  position: fixed;
	  right: 10%;
	  bottom: 50px;
	  display: none;
	  font-size: 45px;
	 
	}
	.fa-arrow-alt-circle-up{
	  color: #FBA635;
	
	}

</style>


<script type="text/javascript">

$(function(){
	
	//태그가 없으면 태그 div를 숨긴다.
	var tag = $("#tag").length;
	if(tag !== 0){
		
		$("#tags").removeAttr('style');
		
		
	}
	
	//writer의 myFeed로 이동
	$("#writerInfo").on("click", function (){
		self.location="/VIG/myfeed/getMyFeed/${feed.writer.userCode}";
		
	});
	
	//scrollTop 부드럽게 이동하는 부분
	$( window ).scroll( function() {
		if ( $( this ).scrollTop() > 200 ) {
			$( '#top' ).fadeIn();
		} else {
			$( '#top' ).fadeOut();
		}
	} );
	
	//스크롤탑 애니메이션
	$( '#top' ).click( function() {
		$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
		return false;
	} );
	
	//follow 구현
	$("#follow").on("click", function(){
		var fm = $("#follow").text();
		
		if(fm == "Follow"){
				
		//실시간 알람을 보내는 부분
		sendMessage('${feed.writer.userCode}','${feed.feedId}','2');
		$.ajax(
			
				{ url: "/VIG/follow/json/addFollow?userCode=${user.userCode}&followerCode=${feed.writer.userCode}",
					method : "GET",	
					dataType: "json",
					headers : {
						
						"Accept" : "applicion/json",
						"Content-Type" : "application/json"
					},

					success : function(JSONData, status) {
						
					alert(status);	
					
					}
					
			
				});
		
			$("#follow").text("following").attr("class", "btn btn-default btn-rounded");	
			
			
		
		
		} else {
		
			//alert("Do you really want to unfollow?");
			$.ajax(
			
				{ url: "/VIG/follow/json/deleteFollow?userCode=${user.userCode}&followerCode=${feed.writer.userCode}",
					method : "GET",	
					dataType: "json",
					headers : {
						
						"Accept" : "applicion/json",
						"Content-Type" : "application/json"
					},

					success : function(JSONData, status) {
						
					alert(status);	
					
					}
					
				
				});
			
			$("#follow").text("Follow").attr("class", "btn btn-outline-default btn-rounded");
			
		}
	});
	
	var user = '${sessionScope.user}';
	if(user==null) {
		
		$("textarea").attr("readonly","readonly");
		
	}
	
	//댓글 구현
	$("button:contains('등록')").on("click", function(){
		
		user = '${sessionScope.user}';
		if(user==null||user=='') {
			return false;
		}
			
		
		var obj = new Object();			
		commentText=$('#textarea-char-counter').val();
		    
			obj.feedId='${feed.feedId}';
			obj.commentText =commentText;
		var jsonData = JSON.stringify(obj);
		
			
			
			$.ajax(
					
					{ url: "/VIG/comment/json/addComment",
						method : "POST",	
						dataType: "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : jsonData,
						   
						success : function(JSONData, status) {
							
							
						
							
					    var displayValue = 
						"<div id="+JSONData.commentId+"><img width='25px' style='margin-right:5px' src='/VIG/images/uploadFiles/"+JSONData.user.profileImg+"' class='rounded-circle'><a style='margin-right:9px' href='/VIG/myfeed/getMyFeedList?userCode='"
								+JSONData.user.userCode+">"+JSONData.user.userName+"</a>"+JSONData.commentText+"<button id= 'deleteCom' class='fas fa-trash' onclick="+"removeComment("+JSONData.commentId+")></button><hr></div>";
							
					    
					    $('#textarea-char-counter').val("");
					    $("#emptyCom").remove();
					    $('#commentbox').append(displayValue);
						}
						
					
					});
			
		
	});
	
	
	
	
	
	 
	
	
	//신고 모달창
	$("i:contains('신고')").on("hover", function(){
		
		$('[data-toggle="tooltip"]').tooltip();
		
	});
	

	
	//좋아요 연결
	$("#like").on("click", function(){

		user = '${sessionScope.user}';
		if(user==null||user=='') {
			alert("로그인이 필요합니다.");
			return false;
			
		}

		
		//실시간 알람을 보내는 부분
		sendMessage('${feed.writer.userCode}','${feed.feedId}','0');
		

		var likeClass = $("#like").attr("class");
		console.log(likeClass);
		if(likeClass =='far fa-heart'){
			
		$("#like").attr("class", "fas fa-heart");
		//deleteLike 추가
		$.ajax(
				
				{ url: "/VIG/like/json/addLike?feedId=${feed.feedId}",
					method : "GET",	
					dataType: "json",
					headers : {
						
						"Accept" : "applicion/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData, status) {
						
					alert(status);	
					
					}
					
				
				});
		
		}else{
			
		$("#like").attr("class", "far fa-heart");	
		//addLike 추가 
		$.ajax(
				
				{ url: "/VIG/like/json/addLike?feedId=${feed.feedId}",
					method : "GET",	
					dataType: "json",
					headers : {
						
						"Accept" : "applicion/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData, status) {
						
					alert(status);	
					
					}
					
				
				});
		}
		
	});
	
	//후원
	$("#donation").on("click", function(){
		
		var cf = confirm("후원을 진행 하시겠습니까?");
		
		if(cf==true){
			
		self.location="/VIG/payment/addPayment?productType=2&feedId=${feed.feedId}"; //세션에서 user코드를 가져온다.
		
		} else if (cf==false) {
			
			
			
		}
		
	});
	


	
	
});


//색상검색
function funcSearchColor(hexcode){
	var code = hexcode.substring(1,7);
	self.location="/VIG/search/getSearchList?Mode=Feed&keyword=%23"+code;
	
}

//댓글 삭제
function removeComment(commentId){
	
	

	var val = $("div[id='"+commentId+"']").remove();
	
	
	$.ajax(
			
			{ url: "/VIG/comment/json/deleteComment?userCode=${user.userCode}&feedId=${feed.feedId}&commentId="+commentId,
				method : "GET",	
				dataType: "json",
				headers : {
					
					"Accept" : "applicion/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {
				
				alert(status);	
				
				}
				
			
			});

}
//이미지 크게보기
function imageModal(imageId){
	

	$("#"+imageId).modal();
	
}


</script>


</head>
<body>



<jsp:include page="../main/toolbar.jsp" />
	
	<div id="outline">
	
	<div id="top">
	<i class="fas fa-arrow-alt-circle-up"></i>
	</div>
	
	<div id="main">
	
	<br/>
	<br/>
	
	<!-- 피드 제목, 설명  -->
	<div class="container">
	<div class="row">
	<div class="col-10">

	
	
	<!-- Medium input -->
	<h2> <strong> ${feed.feedTitle} </strong></h2>
	<br>
	<h5> ${feed.feedExplanation}</h5>

	</div>
	<div class="col-2">
	<br>
		<!-- 좋아요 & 조회수 -->
		<div align="right">
		<c:if test="${isLike == false }">
		
		<i id="like" class="fas fa-heart" style="font-size: 25px"> <fmt:formatNumber value="${fn:length(feed.likes)}" pattern="#,####"/></i>
		
		</c:if>
		<c:if test="${isLike == true }">
		<i id="like" class="far fa-heart" style="font-size: 25px"> <fmt:formatNumber value="${fn:length(feed.likes)}" pattern="#,####"/></i>
		</c:if>
		<c:if test="${empty isLike }">
		<i id="like" class="far fa-heart" style="font-size: 25px"> <fmt:formatNumber value="${fn:length(feed.likes)}" pattern="#,####"/></i>
		</c:if>
		
		</div>
		<br>
		<div align="right">
		<i class="far fa-eye" style="font-size: 22px">                         <fmt:formatNumber value="${feed.feedViewCount}" pattern="#,####"/></i>
		</div>
		
	</div>
	</div>
	</div>
	
	<hr/>
	<!-- 피드의 이미지 -->

	<c:forEach var="images" items="${feed.images}">

		<c:if test="${images.isThumbnail == '0'}">
			<div id="image" onclick='imageModal("${images.imageId}")'>
			<img src="/VIG/images/uploadFiles/${images.imageFile}" style="width:960px"/>
			
									
				<div class="modal fade bd-example-modal-xl" id="${images.imageId }" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
				  <div class="modal-dialog modal-xl">
				    <div class="modal-content" style="align:center">
				    <div style="text-align:center;">
				      <img src="/VIG/images/uploadFiles/${images.imageFile}" style="width: 1200px; align:center"/>
				      
				    </div>
				    </div>
				  </div>
				</div>
				
			</div>
		</c:if>
	</c:forEach>

	<hr/>
	<!-- 작성자 프로필 -->
	<div class="container">
	 <div class="row">
		 <div class="col-8">
		 <span id="profile">
		<img src="/VIG/images/uploadFiles/${feed.writer.profileImg}" class="rounded-circle" width="35px"> &nbsp; <a id="writerName" href="/VIG/myfeed/getMyFeedList?userCode=${feed.writer.userCode}">${feed.writer.userName}</a>
		 </span>
		 </div>
		 <!-- 팔로우와 후원 -->
		 <c:if test="${!empty user.role }">
		
		    <div class="col-4 dofo" align="left">
		    	<c:if test="${feed.writer.userCode != user.userCode }">
		    	<c:if test="${feed.writer.role == 'business' }">
		    	
		    	<span id="donation"><i class="fas fa-dollar-sign"></i></span>
				</c:if>
				
				<c:if test="${ isFollow == 0}">
		    	<button type="button" id="follow" class="btn btn-outline-default btn-rounded" >Follow</button>
		    	</c:if>
		    	<c:if test="${ isFollow == 1}">
		    	<button type="button" id="follow" class="btn btn-default btn-rounded" >following</button>
		    	</c:if>
		    	</c:if>
		    </div>
		    
		  </c:if>
	  </div>
</div>
	<hr/>
	<!--  getFeed 하단부 -->
	<div class="container">
	 <div class="row">
		<div class="col-8">
		<div style="font-size: 25px; font-weight: bold"> Comments </div>
		<div class="row">
		<div class="col-10" id="comform">
		<form id="myform">
			<div class="md-form">
			  <textarea id="textarea-char-counter" class="form-control md-textarea" length="500" rows="2"></textarea>
			  <label for="textarea-char-counter">Type your Comment</label>
			</div>
		</form>
		</div>
		<div class="col-2" align="right" id="combutton">
		<br>
		<button type="submit" class="btn btn-indigo">등록</button>
		</div>
		</div>

		<div id="commentbox" class="text-monospace">
		
		
		<c:if test="${!empty feed.comments }">
			<c:forEach var="comments" items="${feed.comments}">
			<c:set var="i" value="0"/>
			<c:set var="i" value="${i+1 }"/>
			<div id="${comments.commentId}">

			<img width="25px"src="/VIG/images/uploadFiles/${comments.user.profileImg }" style="margin-right:5px" class="rounded-circle"><a href="/VIG/myfeed/getMyFeedList?userCode=${comments.user.userCode}">${ comments.user.userName}</a>
			 ${comments.commentText}  
			 <c:if test="${user.userCode == comments.user.userCode}">
			 <button id= "deleteCom" class="fas fa-trash" onclick="removeComment('${comments.commentId}')"></button>
			 </c:if>

			 <hr>
			 </div>
			 
			</c:forEach>
			
		</c:if>

		
		</div>
		
		<div align="left">
			<br>
			<a id="modalbutton"><i class="fas fa-exclamation-triangle" data-toggle="modal" data-target="#basicExampleModal">신고</i></a>

			</div>
		
		</div>
		
		<div class="col-4" id="feedInfo">
		
			<div class="feedbottom">
			
			<h6 style="font-weight: bold">카테고리    | <a style="display: inline-block; color: black;" href="/VIG/search/getSearchList?Mode=Feed&category=${feed.feedCategory.categoryId }">${feed.feedCategory.categoryName }</a></h6>
			
			</div>
			<br>
			
			
		
			<c:if test="${!empty feed.feedUseGears }">
			<div class="feedbottom">
			<h6 style="font-weight: bold">사용장비</h6>
			
			${feed.feedUseGears}
			</div>
			<br>
			</c:if>
		
		
		
			<c:forEach var="images" items="${feed.images}" begin="0" end="0">
			<c:if test="${!empty images.color }">

			<div class="feedbottom">
			<h6 style="font-weight: bold">색 상</h6>
			
			<c:forEach var="color" items="${images.color}">
			<c:if test="${!empty color }">
				
				<div class="color" style="background-color: ${color.haxcode};" onclick='funcSearchColor("${color.haxcode}")'> &nbsp;  </div>
			
			</c:if>
			</c:forEach>
			</div>
			</c:if>
			<br>
			
			</c:forEach>
	
		
		
		
			
			<c:if test="${!empty feed.coworkers }">
			<div class="feedbottom">	
			<h6 style="font-weight: bold">협업자</h6>
			
			<c:forEach var="coworkers" items="${feed.coworkers}">
				<c:set var="i" value="0"/>
				<c:set var="i" value="${i+1 }"/>
				<a href="/myfeed/${coworkers.user.userCode}">${coworkers.user.userName}</a>
			</c:forEach>
			</div>
			<br>
			</c:if>

			
			<div class="feedbottom" id="tags" style="display:none">
			<h6 style="font-weight: bold">태그</h6>
			
			<c:forEach var="keyword" items="${feed.keywords}">			
				<c:if test="${!empty keyword.keywordOrigin}">
					<c:if test="${keyword.isTag == 1 }">
	
					
						<div id="tag" style=" border: 1px solid #C2C3C2; margin: 3px 1px 3px 1px; padding: 1px 3px 1px 3px; display: inline-block; border-radius: 5px;">
					    <a style="color: black; font-size: 13px;" href="/VIG/search/getSearchList?Mode=Feed&keyword=${keyword.keywordOrigin}">${keyword.keywordOrigin}</a>
						</div>
	
					</c:if>
				</c:if>		
				
			</c:forEach>
			</div>
			
			
			
		</div>
			
	</div>
	</div>
			<jsp:include page="/report/addReport.jsp" />
	
	</div>
	

	</div>
	

</body>
</html>