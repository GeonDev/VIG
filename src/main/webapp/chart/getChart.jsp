<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
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
<head>
 <meta charset="UTF-8">
<title>VIG chart</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
 <script src="/VIG/javascript/numscroller-1.0.js"></script>	

<style>

body { font-family: "Nanum Gothic", sans-serif; padding-top : 100px;}	
	h1 { margin-left: 100px;}
.col-md-12{ margin-bottom: 50px;}
.col-md-2.sideBarPlace { padding:0;  display: inline-block;float:left;}

	#mainMyFeedPage { margin-left: 0px;  display: inline-block; float:right;}
	
	#sbox{
	padding-left:50px;
	}
	
	
	
	.chart-container{
	width:1000px;
	height:500px;
	border:1px solid #ddd;
	padding:20px;
	border-radius:8px;
	
	}
	.txt_lineSize {
	 width:280px; 
	 padding:0 5px; 
	 overflow:hidden; 
	 text-overflow:ellipsis; 
	 white-space:nowrap; 
	 }	
	
	 #momo{
	 	padding-left:50px;
	 	left:120px;
	 	max-width:300px;
	 }
	
	
	 body {
    	padding-top : 50px;
        }
   
	
</style>

</head>
<body>
	<!-- 툴바 -->
			<div class="container-fluid">	
				<div class="row">
					<div class="col-md-12">
						<jsp:include page="/main/toolbar.jsp" />
					</div>
			</div>
<!-- 사이드바  -->				
			<div class="col-md-2 sideBarPlace">		
				 <jsp:include page="/myFeed/sideBar.jsp"></jsp:include>
				 </div>	
				
				
<!-- 타이틀 -->
<div class="col-md-10" id="mainMyFeedPage" >					
					<h1>
						<strong>통계페이지</strong> 
					</h1>	
					<hr/>
						<br>
					
			<div class=row id="sbox">
					
							<div>
							<select class="browser-default custom-select" id="year">
 							 <option selected>Year</option>
 							 <option value="2020">2020</option>
 							 
							</select>
							</div>						
							<div>
							<select class="browser-default custom-select" id="month">
 							 <option selected>Month</option>
 							 <option value="01">1월</option>
 							 <option value="02">2월</option>
						     <option value="03">3월</option>
						     <option value="04">4월</option>
						     <option value="05">5월</option>
						     <option value="06">6월</option>
						     <option value="07">7월</option>
						     <option value="08">8월</option>
						     <option value="09">9월</option>
						     <option value="10">10월</option>
						     <option value="11">11월</option>
						     <option value="12">12월</option>
						     
							</select>								
			    </div>
			    	
			    </div>
			    <br>
			    <div class=row>
			    
			    <div class="col-md-8">
			    
			    <div class="chart-container">
				
				<canvas id="line-chart"></canvas>

			</div>
			</div>
			<div class="col-md-2" id="momo">
			 
			<div class="card  teal lighten-1 white-text">
          <div class="card-body d-flex justify-content-between align-items-center">
			    <div id="countLike">
					Like
					<div class="numscroller" data-min="0" data-max="${likeCount2}"  data-delay="1" data-increment="1"></div>	
					</div>
					<i class="far fa-heart"></i>
					<div>
              
            </div>
          </div>
          <a class="card-footer footer-hover small text-center white-text border-0 p-2">More info<i class="fas fa-arrow-circle-right pl-2"></i></a>
          
          
        </div>
        
       
				<div class="card pink accent-1 white-text">
          <div class="card-body d-flex justify-content-between align-items-center">
					<div id="countView">
					View 
				<div class="numscroller" data-min="0" data-max="${viewCount2}"  data-increment="1" data-delay="1"></div>	
						</div>
						<i class="far fa-eye"></i>
					<div>
             
            </div>
          </div>
          <a class="card-footer footer-hover small text-center white-text border-0 p-2">More info<i class="fas fa-arrow-circle-right pl-2"></i></a>
        </div>
        
        
        
        
        <div class="card cyan darken-4 white-text">
          <div class="card-body d-flex justify-content-between align-items-center">
					<div id="countPrime">
					Prime
					<div class="numscroller" data-min="0" data-max="${primeCount2}" data-increment="1" data-delay="1"></div>
					</div>
					<div>
              <i class="fas fa-crown"></i>
            </div>
          </div>
          <a class="card-footer footer-hover small text-center white-text border-0 p-2">More info<i class="fas fa-arrow-circle-right pl-2"></i></a>
        </div>
			    </div>
			    </div>
			   
		</div>
		</div>


			    
			  





<script>

	//처음 그리는 통계 onLoad시 >> 컨트롤러에서 만든 오늘날짜를 기준으로 그린다. 

	
var likeCount =${likeCount};
var viewCount =${viewCount};
var primeCount =${primeCount};


var ctx = $("#line-chart");
var lineChart = new Chart(ctx,{
	type:'line',
	data:{
		labels:[
			'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'
		],
		datasets:[
			{
				label:'Like',
				data:likeCount,
				backgroundColor: 'rgba(75, 192, 192, 1)',
				borderColor: 'rgba(75, 192, 192, 1)',
				borderWidth:3,
				fill: false
			//	lineTension:0
				
			},
			{
				label:'View',
				data:viewCount,
				backgroundColor: 'rgba(255, 99, 132, 1)',
				borderColor: 'rgba(255, 99, 132, 1)',
				borderWidth:3,
				fill: false
			//	lineTension:0
				
			},
			{
				label:'primefeed',
				data:primeCount,
				backgroundColor: 'rgba(015, 99, 132, 1)',
				borderColor: 'rgba(015, 99, 132, 1)',
				borderWidth:3,
				fill: false
			//	lineTension:0
				
			},
			
			
		]
	},
	options:{
		maintainAspectRatio:false // 크기변동
		
	}
	
	
});

// 년 월에따른 업데이트된 차트 
$("#year, #month").on("change", function(){
	
	var year = $("#year").val();
	var month = $("#month").val();
	//셀렉한 년,월 뷰로 바로 전송
	$("#yyear").text(year);
	$("#mmonth").text(month);
	
	//차트 업데이트
	$.ajax(
   			{
   				url : "/VIG/chart/json/getChart",
				method : "GET" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : {
					month : $("#month").val(),
					year : $("#year").val()
					
				},
				success : function(JSONData , status) {
					
					
					
					
						lineChart.data.datasets[0].data = JSONData.likeCount;
						lineChart.data.datasets[1].data = JSONData.viewCount;
						lineChart.data.datasets[2].data = JSONData.primeCount;
							
						lineChart.update();									
						
					//	var displayValue =
					//	"<div id='countLike'><Strong>년 월의 총 Like수"+JSONData.likeCount2+"</Strong></div><hr><div><Strong>년 월의 총 Like수"+JSONData.viewCount2+"</Strong></div><hr><div><Strong>년 월의 총 Like수"+JSONData.primeCount2+"</Strong></div><hr>";
						
						
						
						$('#countLike').text("Like "+JSONData.likeCount2);
						$('#countView').text("View "+JSONData.viewCount2);
						$('#countPrime').text("Prime "+JSONData.primeCount2);
				}
			})
			//합계 Ajax 시작 
			
			
     });


				

</script>


</body>


</html>