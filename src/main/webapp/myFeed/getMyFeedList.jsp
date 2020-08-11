<%@page import="com.VIG.mvc.service.domain.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>VIG</title>



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
	
	 <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
		
	
	//최초 페이지 설정
	var page = 0; 	
	
	//페이지의 끝인지 체크
	var isPageEnd = false;
	
	//페이지 로드가 완료 되었는지 체크(ajax 중복 호출 방지용)
	var isLoadPage = false;
	
	
	//전달받은 피드 리스트를 화면에 그린다.
	function getfeedlistFromAjax(item){
		var thumbnail = '';								
		
		$.each(item.images, function(index, item){
			if(item.isThumbnail == 1){
				thumbnail = item.imageFile
			}									
		});
		
		//변수  초기화
		var displayValue ='';
		
		displayValue = 
			"<div class = 'view overlay'>"
				+"<div class = 'img_feed'>"
				+ "<a href='/VIG/feed/getFeed?feedId="+ item.feedId +"' class='text-light'>"
					+ "<img src='/VIG/images/uploadFiles/" + thumbnail + "' alt='thumbnail' class='img-fluid rounded-sm img_feed '>"
					+ "<div class='mask waves-effect waves-light rgba-black-strong' style='text-align: right;'>"	
					+ "<p class='txt_line' style='margin: 65% 10px; font-weight: bold; text-align: left; color : white; font-size : large; vertical-align: bottom'>";								
											
						if(item.feedIsPrime == 1){
							displayValue += "<span class='badge badge-primary'>Prime</span>&nbsp;";
						}						
						
						displayValue += item.feedTitle + "</p>"					
					+ "</div>"
				+ "</a>"
				+"</div>"
			+"</div>";
									
			$("#showFeedList").append(displayValue);		
	}
	
	
	
	//키워드 검색을 통하여 불러온 이미지를 출력한다.
	function getMyfeedList() {
		
		if(isPageEnd == true || isLoadPage == true){
			//페이지의 끝, 또는 페이지 로드중 이라면 실행안함
			return;
		}		
		isLoadPage = true;
		page += 1;
		console.log(page);		
		
		
		$.ajax( 
				{
					url : "/VIG/search/json/getSearchUserFeedResult",
					method : "POST",
					dataType : "Json",					
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data :  JSON.stringify({userCode : '${writer.userCode}', currentPage : page}),
					success : function(JSONData , status) {
						
						//검색 결과가 있는지 체크
						if (JSONData.list.length != 0){					
						
							//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
							if (JSONData.list.length < 10){
								isPageEnd = true;
							}	 						
	 		
	 	 					$.each(JSONData.list, function(index, item) {	 													 								
	 							getfeedlistFromAjax(item);	 												
	 						});	 							
	 							 						
 						//로드가 완료되면 로딩이 되었다고 체크
 						isLoadPage = false;
	 					
	 					//검색결과가 없는 경우	
						}else{
							
							//첫번째 페이지를 로드 했을 경우에만 발생
							if(page == 1){
								isPageEnd = true;
								getNoSearchResult();
							}
						}
					}
			});		
	}



	$(function(){			
		// 최초 진입시 첫번째 페이지 로딩
		getMyfeedList();
			
		$(window).scroll(function() {
		    if ($(window).scrollTop() + 500 >= $(document).height() - $(window).height()) {     			     
		    	getMyfeedList();  			    	
		    }
		});		    			
		
	});	
	


	</script>
	
	<style>
	
	body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
	h1 { margin-left: 100px;}
	.col-md-12{ margin-bottom: 50px;}
	
	.img_feed {	width: auto; height: 290px; overflow:hidden;}	
	.view {	 margin: 5px 10px;}	
	.txt_line { width:380px;  padding:0 5px; overflow:hidden; text-overflow:ellipsis;  white-space:nowrap; }	
	.row.justify-content-center { margin: 50px 0px 10px 0px;}
	
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	
	/* 버튼 CSS */
		.box_body_m {box-sizing: border-box; font-family: "Futura PT", "Futura", sans-serif; -webkit-font-smoothing: antialiased;}
		.wrap_m {text-align: center;}
		#btn_ch_m { padding: 12px 50px;text-decoration: none;font-size: 12px; ;margin: 3px 20px; display:flex; float:left;}
		.btn:hover, .btn:link:hover, .btn:visited:hover {box-shadow: 0 4em 0 0 #2c3e50 inset, 0em 0em 0 0 #bbb;-webkit-transform: translate(0.3em, 0.2em);transform: translate(0.3em, 0.2em); color: #fff;}
		.btn3, .btn3:link, .btn3:visited {color: #333;font-size: .8em;text-transform: uppercase;min-width: 100px;position: relative;
		  	margin: 0 auto;border: 2px solid transparent;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:after, .btn3:before, .btn3:link:after, .btn3:link:before, .btn3:visited:after, .btn3:visited:before { content: "";position: absolute;letter-spacing: .1em;left: -1em;top: -2px; height: 3em; width: 0;
			border: 1px solid #c75842;-webkit-transition: inherit;transition: inherit;}
		.btn3:after, .btn3:link:after, .btn3:visited:after {left: auto;right: -1em;}
		.btn3:hover, .btn3:link:hover, .btn3:visited:hover {border-color: #c75842;-webkit-transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: border-color 0.2s 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:hover:after, .btn3:hover:before, .btn3:link:hover:after, .btn3:link:hover:before, .btn3:visited:hover:after, .btn3:visited:hover:before {
		  right: -2px;-webkit-transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);transition: all 0.2s cubic-bezier(0.455, 0.03, 0.515, 0.955);}
		.btn3:hover:before, .btn3:link:hover:before, .btn3:visited:hover:before {left: -2px;right: auto;}
		@-webkit-keyframes gelatine {
		  from,to {-webkit-transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);}
		  from,to {-webkit-transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);}}
		@keyframes gelatine {from,to {-webkit-transform: scale(1, 1); transform: scale(1, 1);}
		  25% {-webkit-transform: scale(0.9, 1.1); transform: scale(0.9, 1.1);}
		  50% {-webkit-transform: scale(1.1, 0.9);transform: scale(1.1, 0.9);}
		  75% {-webkit-transform: scale(0.95, 1.05);t}
			/* 버튼 CSS */
	
	
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
					<h1>
						<strong>${writer.userName}</strong> 님의 마이피드
					</h1>	
					<hr/>
					
			<!-- 본문 -->
		 		<div class="row justify-content-center">
					 <div class="box_body_m">
					 <div class="wrap_m">
					 	<a id="btn_ch_m" class="btn3" id="follwer_btn" data-toggle="modal" data-target="#followModal">팔로워</a>
						<a id="btn_ch_m" class="btn3" data-toggle="modal" data-target="#followModal">팔로잉</a>
						<a id="btn_ch_m" class="btn3" href="#">채 팅</a>
			
					</div>	 			
				</div>   		
			    	<br/>	
			    	
			  <!-- 팔로잉 팔로워 모달-->
					<div class="modal fade" id="followModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
					  aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      
					        팔로우 목록
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					      </div>
					    </div>
					  </div>
					</div>
			    	
			    	
			    	
			    			    		
			    		
			<!-- 피드리스트를 그려줄 부분 -->		
				<div id="showFeedList" class="row justify-content-center" style="margin: 50px 30px 10px 30px;"></div>
			    				    
				</div>					
			</div>
		</div>
	

</body>
</html>
