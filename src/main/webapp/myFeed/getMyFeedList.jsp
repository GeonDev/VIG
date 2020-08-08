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
	
	.img_feed {	width: auto; height: 290px; overflow:hidden;}	
	.view {	 margin: 5px 10px;}	
	.txt_line { width:380px;  padding:0 5px; overflow:hidden; text-overflow:ellipsis;  white-space:nowrap; }	
	.row.justify-content-center { margin: 50px 0px 10px 0px;}
	
	/*사이드바,본문 배치css*/
	 .col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}
	 #mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	
	
	
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
			!=레이아웃 완료후 지우기 /사이드바 자리  get my feed list=!
				 <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
				 
  			<!-- 타이틀 -->
			    <div class="col-md-10" id="mainMyFeedPage" >					
					<h1>
						<strong>${writer.userName}</strong> 님의 마이피드
					</h1>	
					<hr/>
					
			<!-- 본문 -->
		 		<div class="row justify-content-center">
					 <div class="text-center">
					 	<button class="btn btn-default ml-5 mr-5" data-toggle="modal" data-target="#theModal">팔로워</button>
						<button class="btn btn-default ml-5 mr-5" data-toggle="modal" data-target="#theModal2">팔로잉</button>
						<a type="button" class="btn btn-default ml-5 mr-5" href="#">채 팅</a>
					</div>	 			
				</div>   		
			    	<br/>			    		
			    		
			<!-- 피드리스트를 그려줄 부분 -->		
				<div id="showFeedList" class="row justify-content-center" style="margin-left: 10px; margin-right: 10px;"></div>
			    				    
				</div>					
			</div>
		</div>
	

</body>
</html>
