<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>getFeed</title>

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
	
	img #image {
	  margin: 1em 0;
	  display: block;
	  background: rgb(240, 240, 240);
	  border: 1px solid rgb(0, 0, 0);
	}
	
	}
	#writerInfo {

    display: table-cell;
    vertical-align: middle;

	
	}
	#writerName {
	
	padding-top: 5px;
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
	
	.fa-exclamation-triangle {
	
	color: red;
	
	}
	#feedbottom {
	
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
	padding: 3px 3px 3px 3px;
	
	
	}
	#donation i {
	
	
	vertical-align: middle;
	color: White;
	font-size: 27px;
	
	}
	


</style>


<script type="text/javascript">

$(function(){
	
	$("#writerInfo").on("click", function (){
		self.location="../myfeed/getMyFeed/${feed.writer.userCode}";
		
	});
	
	//scrollTop 부드럽게 이동하는 부분
	$( window ).scroll( function() {
		if ( $( this ).scrollTop() > 200 ) {
			$( '.top' ).fadeIn();
		} else {
			$( '.top' ).fadeOut();
		}
	} );
	
	//스크롤탑 애니메이션
	$( '.top' ).click( function() {
		$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
		return false;
	} );
	
	//follow 구현
	$("#follow").on("click", function(){
		var fm = $("#follow").text();
		//self.location="../팔로우 add 팔로우";
		if(fm == "Follow"){
			
		$("#follow").text("following").attr("class", "btn btn-default btn-rounded");
		
		} else {
		
			//alert("Do you really want to unfollow?");
			$("#follow").text("Follow").attr("class", "btn btn-outline-default btn-rounded");
			
		}
	});
	
	//댓글 구현
	$("button:contains('등록')").on("click", function(){
	
		alert("등록되었습니다.");
		
	});
	
	//신고 모달창
	$("i:contains('신고')").on("hover", function(){
		
		$('[data-toggle="tooltip"]').tooltip();
		
	});
	

	
	//좋아요 연결
	$("body").on("dblclick", function(){
		var likeClass = $("#like").attr("class");
		console.log(likeClass);
		if(likeClass =='far fa-heart'){
			
		$("#like").attr("class", "fas fa-heart");
		//addLike 추가
		}else{
			
		$("#like").attr("class", "far fa-heart");
		//deleteLike 추가
		}

	});
	
	$("#like").on("click", function(){
		
		var likeClass = $("#like").attr("class");
		console.log(likeClass);
		if(likeClass =='far fa-heart'){
			
		$("#like").attr("class", "fas fa-heart");
		//addLike 추가
		
		}else{
			
		$("#like").attr("class", "far fa-heart");
		//deleteLike 추가
		}
		
	});
	
	$("#donation").on("click", function(){
		
		var cf = confirm("후원을 진행 하시겠습니까?");
		
		if(cf==true){
			
		self.location="../payment/addPayment?feedId=${feed.feedId}&userCode=${user.userCode}"; //세션에서 user코드를 가져온다.
		
		} else if (cf==false) {
			
			
			
		}
		
	});
	
	

	
})


</script>


</head>
<body>



<jsp:include page="../main/toolbar.jsp" />
	
	<div id="outline">

	<div id="main">
	
	<br/>
	<br/>
	
	<!-- 피드 제목, 설명  -->
	<div class="container">
	<div class="row">
	<div class="col-10">
	<h2> <strong> ${feed.feedTitle} </strong></h2>
	<br>
	<!-- Medium input -->
	<h5> ${feed.feedExplanation}</h5>
	</div>
	
	<div class="col-2">
	<br>
		<!-- 좋아요 & 조회수 -->
		<div align="right">
		<i id="like" class="far fa-heart" style="font-size: 25px"></i>
		</div>
		<br>
		<div align="right">
		<i class="far fa-eye" style="font-size: 25px">                         ${feed.feedViewCount}</i>
		</div>
		
	</div>
	</div>
	</div>
	
	<hr/>
	<!-- 피드의 이미지 -->
	<c:forEach var="images" items="${feed.images}">
		<c:set var="i" value="0"/>
		<c:set var="i" value="${i+1 }"/>
		<c:if test="${images.isThumbnail == '0'}">
			<div id="image">
			<img src="../../images/uploadFiles/${images.imageFile}" style="width:960px" />
			</div>
		</c:if>
	</c:forEach>

	<hr/>
	<!-- 작성자 프로필 -->
	<div class="container">
	 <div class="row">
		 <div class="col-8">
		 <span id="profile">
		<img src="../../images/others/default-profile-picture1.jpg" class="rounded-circle" width="35px"> &nbsp; <a id="writerName" href="../../myfeed/getMyFeedList?userCode=${feed.writer.userCode}">${feed.writer.userName}</a>
		 </span>
		 </div>
		 <!-- 팔로우와 후원 -->
	    <div class="col-4 dofo" align="center">
	    	<c:if test="${feed.writer.role == 'business' }">
	    	<span id="donation"><i class="fas fa-dollar-sign"></i></span>
			</c:if>
	    	<button type="button" id="follow" class="btn btn-outline-default btn-rounded" >Follow</button>
	    </div>
	  </div>
</div>
	<hr/>
	<br/>
	<!--  getFeed 하단부 -->
	<div class="container">
	 <div class="row">
		<div class="col-8">

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

		<div id="feedbottom">
		<c:choose>
		
		<c:when test="${!empty feed.comments }">
			<c:forEach var="comments" items="${feed.comments}">
			<c:set var="i" value="0"/>
			<c:set var="i" value="${i+1 }"/>
			<img src="../images/others/default-profile-picture1.jpg" class="rounded-circle" width="15px"><a href="/마이피드/${comments.user.userCode}">${ comments.user.userName}</a>
			comment ${comments.commentText }
			</c:forEach>
		</c:when>
		<c:when test="${empty feed.comments}">
			<br>
			<br>
			<h6 align="center"> Please leave your comments! </h6>
			<br>
			<br>
		</c:when>
		
		</c:choose>
		</div>
		
		</div>
		
		<div class="col-4" id="feedInfo">
		<div id="feedbottom">
			<h6>사용장비</h6>
			<c:if test="${!empty feed.feedUseGears }">
			
			${feed.feedUseGears}
			
			</c:if>
			<c:if test="${empty feed.feedUseGears }">
				<p align="center" style="font-size: 13px; font-style:italic;">사용 장비가 없습니다.</p>
			</c:if>
		</div>
		<br>
		<div id="feedbottom">
			<h6>색 상</h6>
			<c:forEach var="images" items="${feed.images}" begin="0" end="0">
			<c:if test="${!empty image.color }">
			<c:if test="${images.isThumbnail == '1' }">
			
			<c:forEach var="color" items="${images.color}">
			<c:if test="${!empty color }">
				R: ${color.red}  G: ${color.green } B: ${color.blue}
			</c:if>

			</c:forEach>
			</c:if>
			</c:if>
			<c:if test="${empty color }">
				<p align="center" style="font-size: 13px; font-style:italic;">No colors</p>
			</c:if>
			</c:forEach>
		</div>
		<br>
		<div id="feedbottom">	
			<h6>협업자</h6>
			
			<c:if test="${!empty feed.coworkers }">
			
			<c:forEach var="coworkers" items="${feed.coworkers}">
				<c:set var="i" value="0"/>
				<c:set var="i" value="${i+1 }"/>
				<a href="/myfeed/${coworkers.user.userCode}">${coworkers.user.userName}</a>
			</c:forEach>
			</c:if>
			<c:if test="${empty feed.coworkers }">
				<p align="center" style="font-size: 13px; font-style:italic;">협업자가 없습니다.</p>
			</c:if>

		</div>
		<br>
		<div id="feedbottom">	
			<h6>태그</h6>
			<c:forEach var="images" items="${feed.images}" begin="0" end="0">
			<c:if test="${!empty keyword }">
				<c:forEach var="tag" items="${images.keyword}">
				<c:set var="i" value="0"/>
				<c:set var="i" value="${i+1}"/>
				
					<a href="/search/getSearchResult/${tag}">${tag}</a>
				
				</c:forEach>
			</c:if>
			<c:if test="${empty keyword }">
				
					<p align="center" style="font-size: 13px; font-style:italic;">태그가 없습니다..</p>
			
			</c:if>	

			</c:forEach>
		</div>	
			
			<div align="right">
			<br>
			<a id="modalbutton"><i class="fas fa-exclamation-triangle">신고</i></a>

			</div>
		</div>
			
	</div>
	</div>
	
	
	</div>
	
	</div>

</body>
</html>