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
		
		<script type="text/javascript">
		
		var Mode = 'Feed';
		
		//최초 페이지는 0으로 설정
		var page = 0; 	
		
		//페이지의 끝인지 체크
		var isPageEnd = false;
		
		//페이지 로드가 완료 되었는지 체크(ajax 중복 호출 방지용)
		var isLoadPage = false;
		
		
		
		
		function getfeedlistFromAjax(item){
			var thumbnail = '';								
			
			$.each(item.images, function(index, item){
				if(item.isThumbnail == 1){
					thumbnail = item.imageFile
				}									
			});										
			
			var displayValue =
				"<div class = 'view overlay'>"
					+"<div class = 'img_feed'>"
					+ "<a href='/VIG/feed/getFeed?feedId="+ item.feedId +"' class='text-light'>"
						+ "<img src='/VIG/images/uploadFiles/" + thumbnail + "' alt='thumbnail' class='img-fluid rounded-sm' style='width: 400px; height: 300px;'>"
						+ "<div class='mask waves-effect waves-light rgba-black-strong'>"
							+ "<h5 style='font-weight: bold;'>&ensp;"+ item.feedTitle +"</h5>"					
						+ "</div>"
					+ "</a>"
					+"</div>"
				+"</div>";
										
				$(".row:last").append(displayValue);		
		}
		
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
						data :  JSON.stringify({keyword : $("#Keyword").val(), mode : Mode, currentPage : page}),
						success : function(JSONData , status) {
							
							//불러와야 되는 페이지보다 개수가 적은 경우 페이지가 끝났다
							if (JSONData.list.length < 10){
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
	 									getfeedlistFromAjax(item);
	 										
	 								}else if(Mode == 'Image'){			
	 									getImagelistFromAjax(item); 									
	 								}					
	 							});	 							
	 						}
	 						
	 						//로드가 완료되면 로딩이 되었다고 체크
	 						isLoadPage = false;						
						}
				});		
		}
	
		
		$(function(){			
			// 최초 진입시 첫번째 페이지 로딩
			getItemList();
		});
		
		</script>
	
		<style>
		
		.lightbox{
		 width:350px;
		 height:250px;
		}		
		.container-fulid{
			padding-right:50px;
			padding-left:50px;
		}
		
		</style>
		

</head>
<body>
	
		<div class="container-lg-fluid">
	
		<div class="row align-items-center justify-content-md-center">
					
			
			<div class="row justify-content-center" style = "margin: 5px;"></div>
			
			</div>
		</div>
			
			

			
	
</body>
</html>