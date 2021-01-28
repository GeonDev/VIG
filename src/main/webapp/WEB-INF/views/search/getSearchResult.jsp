<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
	<!-- Bootstrap core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<!-- MDB core JavaScript -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
	
	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
	<!-- 색상선택기 플러그인 -->
	<script type="text/javascript" src="/VIG/javascript/farbtastic.js"></script>
 	<link rel="stylesheet" href="/VIG/css/farbtastic.css" type="text/css" />

	<style>
	body {
    padding-top : 50px;
    }        
        
    .img_image {
	width: auto; height: auto;
	max-width: 600px;
	max-height: 300px;	  
	}
		
    .img_feed {	
    width: 500px; height: 375px; 	
	overflow:hidden;	
	}
		
	.img_feed_thumb {	  
	max-width: 125px;
	max-height: 100px;	
	}
		
	.view {	  
	margin: 5px 10px;
	}
		
	.view_small {	  
	margin: 2px 5px;
	} 
		
	.txt_line {
	 width:380px; 
	 padding:0 5px; 
	 overflow:hidden; 
	 text-overflow:ellipsis; 
	 white-space:nowrap; 
	 }

    

    </style>
	
	<script type="text/javascript">
	
	//최초 입장시 모드 지정
	var Mode = '${mode}';	

	//최초 페이지 설정
	var page = 0; 	
	
	//페이지의 끝인지 체크
	var isPageEnd = false;
	
	//페이지 로드가 완료 되었는지 체크(ajax 중복 호출 방지용)
	var isLoadPage = false;	
	
	var pageSize = '${pageSize}'
	
	//전달받은 피드 리스트를 화면에 그린다.
	function getfeedlistFromAjax(item, user){
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
					+ "<div class='mask waves-effect waves-light rgba-black-strong' style='text-align: right;'>";					
						if(user != ''){
							displayValue +="<button type='button' onclick='addhideFeed("+ item.feedId +")' class='btn btn-link' style='width: 50px; height:50px; padding-left: 0px; padding-right: 0px;'>"											
								+ "<h4><i class='far fa-times-circle' style='color: white; text-align: center;'></i></h4>"
							+"</button>"
							+"<p class='txt_line' style='margin: 55% 10px; font-weight: bold; text-align: left; color : white; font-size : large; vertical-align: bottom'>";					
						}else{
							displayValue += "<p class='txt_line' style='margin: 65% 10px; font-weight: bold; text-align: left; color : white; font-size : large; vertical-align: bottom'>";								
						}					
					
						
						if(item.feedIsPrime == 1){
							displayValue += "<span class='badge badge-primary'>Prime</span>&nbsp;";
						}						
						
						displayValue += item.feedTitle + "</p>"					
					+ "</div>"
				+ "</a>"
				+"</div>"
			+"</div>";
									
			$(".row:last").append(displayValue);		
	}
	
	
	
	//전달받은 이미지 리스트를 화면에 그림
	function getImagelistFromAjax(item){
		//변수  초기화
		var displayValue ='';
		displayValue =
			"<div class = 'view overlay'>"
				+ "<div class = 'img_image'>"
					+ "<a href='/VIG/search/getSearchImages?imageId="+ item.imageId +"' class='text-light'>"
					+ "<img src='/VIG/images/uploadFiles/" + item.imageFile + "' alt='thumbnail' class='img-fluid rounded-sm ' style='width: auto; height: 300px;'>"
						+"<div class='mask flex-center waves-effect waves-light rgba-black-strong'>"						
						+"</div>"
					+ "</a>"
				+ "</div>"
			+ "</div>";
			
			$(".row:last").append(displayValue);		
	}
	
	
	//검색결과가 없을 때
	function getNoSearchResult(){
		
		console.log('들어옴');
		//변수  초기화
		var displayValue ='';
		displayValue =
			"<div class = 'view overlay'>"								
			+ "<img src='/VIG/images/others/noResults.jpg'>"				
			+ "</div>";
			
			$(".row:last").append(displayValue);		
	}
	
	
	
	//전달받은 유저 리스트를 화면에 그림
	function getUserlistFromAjax(item) {
		//변수  초기화
		var displayValue ='';
		displayValue =
			"<div class = 'view'>"
				+"<div class = 'row'>"
					+"<a class = 'col-md-1' href='/VIG/myfeed/getMyFeedList?userCode="+ item.userCode + "'>"
					+ "<img src='/VIG/images/uploadFiles/" + item.profileImg + "' alt='thumbnail' class='img-fluid rounded-circle ' style=' width: 100%; padding-left: 0px; padding-right: 0px; margin-left : 15px;'>"
					+"</a>"
					+"<div class='userInfo col-md-4 mt-2'>"
						+"<h2 style='margin-bottom : 1px;'><b>" + item.userName +"</b></h2>"
						+"<h5 class='txt_line' style='margin-top : 1px; margin-bottom : 5px;'>" + item.selfIntroduce +"</h5>"						
					+"</div>"
					+"<div class='feedList col-md-6 row' id = 'feed_" + item.userCode + "'>"									
					+"</div>"
				+"</div>"
				+"<hr/>"
			+"</div>";			
			
			$("#users").append(displayValue);
	}
	
	//유저의 피드리스트를 작게 그려줌 - getUserlistFromAjax와 같이 사용됨
	function getUserFeedlistFromAjax(item){
		var thumbnail = '';
		
		var feed_code = "feed_" + item.writer.userCode;	 	 							
		
		//썸네일 이미지 찾기
		$.each(item.images, function(index, item){
			if(item.isThumbnail == 1){
				thumbnail = item.imageFile
			}									
		});
		
		var displayValue =
		"<div class = 'view_small'>"
			+"<div class = 'img_feed_thumb'>"
			+"<a href='/VIG/feed/getFeed?feedId="+ item.feedId +"'>"
			+ "<img src='/VIG/images/uploadFiles/" + thumbnail 	+ "' alt='thumbnail' class='img-fluid rounded-sm ' style='width: 125px; height: 100px;'>" 	 							
			+"</a>"
			+"</div>"
		+"</div>";		
		
		$("#"+feed_code).append(displayValue);		
	}
	
	
	
	//키워드 검색을 통하여 불러온 이미지를 출력한다.
	function getItemList() {
		
		if(isPageEnd == true || isLoadPage == true){
			//페이지의 끝, 또는 페이지 로드중 이라면 실행안함
			return;
		}		
		isLoadPage = true;
		page += 1;
		console.log(page);		
		
		
		$.ajax( 
				{
					url : "/VIG/search/json/getSearchResultList",
					method : "POST",
					dataType : "Json",					
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data :  JSON.stringify({keyword : $("#Keyword").val(), mode : Mode, currentPage : page, category: $("#categorySelecter").val()}),
					success : function(JSONData , status) {
						
						//검색 결과가 있는지 체크
						if (JSONData.list.length != 0){					
						
							//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
							if (JSONData.list.length < pageSize){
								isPageEnd = true;
							}
	 						
	 						//유저를 불러올 경우 유저리스트를 생성한 후 피드를 삽입한다 
	 						if(Mode == 'Writer'){							
	 							
	 	 						$.each(JSONData.list, function(index, item) { 						
	 								getUserlistFromAjax(item); 									
	 													
	 							});	
	 	 						
	 	 						$.each(JSONData.feeds, function(index, item) { 						
	 	 							getUserFeedlistFromAjax(item);	 							
	 													
	 							});	 							
	 							
	 						}else{
	 	 						$.each(JSONData.list, function(index, item) {						
	 								
	 								if(Mode == 'Feed'){						 								
	 									getfeedlistFromAjax(item, '${user}');
	 										
	 								}else if(Mode == 'Image'){			
	 									getImagelistFromAjax(item); 									
	 								}					
	 							});	 							
	 						}	 						
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
	
	//검색어 자동완성을 처리한다.
	function getkeywords() {
		$.ajax("/VIG/search/json/getSearchKeyword",
		  {
			method : "POST",
			dataType : "Json",							
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data :  JSON.stringify({keyword : $("#Keyword").val(), mode : Mode }),						
			success : function(JSONData, status) {
				//검색 결과가 있으면 처리			
				if(JSONData.length != 0){								
				 	$("#Keyword").autocomplete({			 		
				        source: JSONData
				    });		
				}
			}							
		});
	}
	
	
	function startKeywordSearch(){	   	
    	$( 'div' ).remove( '.view' );
    	page = 0;
    	isPageEnd = false;
    	isLoadPage = false;	   
        getItemList();		            	    			
	}
	
	
	//피드를 숨길지 물어본다.
	function addhideFeed(feedId){	   	
		event.preventDefault();
		console.log(feedId);
		var result = confirm("해당 피드를 숨기시겠습니까?");
		if(result){
			var link ='/VIG/history/addHideFeed?Id=';
			link =  link.concat(feedId);
			$(location).attr("href", link); 
		}      	    			
	}
	
	$(function(){				
			
			
			//최초 전달 받은 모드 세팅
			$(".mode:contains('${mode}')").attr("class","btn btn-indigo mode");	
			
			//색상 선택기 로드
			 $("#picker").farbtastic('#color');
			
			//전달 받은 카테고리 세팅
			 $("#categorySelecter").val('${categoryId}')
			
			
			//최초 페이지 요청
			 getItemList();
		
			//모드 버튼을 누르는 경우 페이지 초기화
			$(".mode").on("click",function(){			
				
				//모드 변경 버튼 활성화
				Mode = $(this).text();
				$( 'div' ).remove('.view');			
				page = 0;
				isPageEnd = false;
				isLoadPage = false;	
				$("#Keyword").val("");
				
				$(".mode").attr("class","btn btn-cyan mode");
				$(this).attr("class","btn btn-indigo mode");
				
				if(Mode == 'Feed'){					
					$("#categorySelecter").prop("disabled", false);
					$("#colorSelecter").prop("disabled", false);
				}else if(Mode == 'Image'){
					$("#categorySelecter").prop("disabled", true);
					$("#categorySelecter").val(0);
					$("#colorSelecter").prop("disabled", false);
				}else{
					$("#categorySelecter").prop("disabled", true);
					$("#categorySelecter").val(0);
					$("#colorSelecter").prop("disabled", true);
				}	
				
				//현재 URL을 가지고 옴
				var newURL = (location.href).split("?");				
				
				//Url에 모드를 넣고 변경
				history.pushState(null, null, newURL[0]+"?Mode="+Mode);
				
	
				//모드를 변경했음으로 페이지 다시 로드
				getItemList();
	
			});		
			
   			
			$(window).scroll(function() {
   			    if ($(window).scrollTop() + 600 >= $(document).height() - $(window).height()) {     			     
	   				getItemList();   			    	
   			    }
   			});		
		
		
			//자동완성 기능
			$("#Keyword").on("keyup", function(){				
				if($("#Keyword").val().length > 1){
					getkeywords();
				}					
			});				
			
			
			//엔터를 누르면 키워드 검색을 수행한다.
	       $("#Keyword").keydown(function(key) {
	            if (key.keyCode == 13) {
	            	startKeywordSearch();
	            }
	        });	
			
			
			//검색 아이콘을 클릭하면 검색 수행
			$("#startedSearchIcon").on("click", function(){				
				if($("#Keyword").val().length > 1){
					startKeywordSearch();
				}	
			});				
			
			
			//색상값 변경이 생기면 키워드로 세팅
			$("#picker").on("click", function(){				
				$("#Keyword").val($("#color").val());
				$("#showColor").css('color',$("#color").val());
			});					
	});	
	
	</script>
		

    
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../main/toolbar.jsp" />
		
	<div class="container-lg-fluid">
	
		<div class="row justify-content-center">
	
		
			<div class="col-sm-9">				
				<div class="row">
					<div class="col-sm-1">				
						<i id="startedSearchIcon" class="fas fa-search d-flex justify-content-end mt-3" aria-hidden="true" style="font-size: x-large;"></i>
					</div>
					
					<div class="col-sm-11">
						<div class="d-flex justify-content-center md-form mt-0 mb-0">					  
							  <input id="Keyword" class="form-control w-100" type="text" placeholder="Search" aria-label="Search" value="${keyword}" style="font-size: x-large;">
						</div>	
					</div>	
				</div>								
			</div>
			
			<div class="col-sm-3 ">
				<div class="row row-cols-4">
					<button type="button" class="btn btn-cyan mode" style="padding-left: 0px; padding-right: 0px;">Feed</button>
					<button type="button" class="btn btn-cyan mode" style="padding-left: 0px; padding-right: 0px;">Image</button>
					<button type="button" class="btn btn-cyan mode" style="padding-left: 0px; padding-right: 0px;">Writer</button>
				</div>
			
									
			</div>							
		</div>
		
	
		
		<div class="row justify-content-start mt-0">
		
		<div class="col-sm-3">
			<div class ="row">
			
				<div  class="col-sm-4"></div>
				<div class="col-sm-4 mb-0" style="padding-right: 0px;  text-align: right;">				

					<select id="categorySelecter" class="custom-select">
						<c:forEach var ="category" items="${categorylist}">
						
							 <option value="${category.categoryId}">${category.categoryName}&nbsp;</option>
						
						</c:forEach>					

					</select>		
				</div>			
			
			
				<div class="col-sm-4" style="padding-left: 0px; text-align: left;">		
					<button id="colorSelecter" class="btn btn-outline-light dropdown-toggle btn-sm form-inline mb-0 mt-0" type="button" data-toggle="dropdown" style="padding-left: 10px; padding-right: 10px;">
						<i id="showColor" class="fas fa-circle" style="color: #0000FF; font-size: large; margin-left: -2px;"></i>
						<p style="padding: 0px; margin-bottom: 0px; margin-top : 2px; margin-left : 4px; text-align: top; float: right; color: black;">Color</p>				 	
					</button>
					
					<div class="dropdown-menu">
						<div id="picker" ></div>	
					</div>					
				</div>		
				

			</div>	
		</div>					


			<!-- 실제 색상을 선택하고 반영하는 부분 -->
			<div class="col-sm-1">					
				<form action="" >
					<div class="form-item">							
				  		<input class="form-control form-control-sm" type="hidden" id="color" name="color" value="#0000FF"/>
				  	</div>						
				</form>				
			</div>
			
			
			
			
		</div>		
			
		<hr/>
		
		<!-- 피드, 이미지가 출력되는 부분  -->
		<div class="row justify-content-center" style="margin-left: 10px; margin-right: 10px;">	</div>
		
		<!-- 유저 정보를 넣을 부분  -->
		<div class="userlist " id="users" ></div>
	
	</div>

</body>
</html>