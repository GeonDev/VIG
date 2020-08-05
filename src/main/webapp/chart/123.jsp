<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>

<css>
canvas{
    margin: 0 auto;
    }
</css>
<style>
	#noDataImg { text-align: center; }
</style>
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <a href="/cal/getSales"><h4 class="page-title"><font size="5em">Sales</font></h4></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-sm-6 col-xs-12">
                        <div class="white-box analytics-info">
                            <h3 class="box-title">누적 정산금</h3>
                            <ul class="list-inline two-part">
                                <li>
                                    <div id="sparklinedash"></div>
                                </li>
                                <li class="text-right"><i class="ti-arrow-up text-success"></i> <span class="counter text-success">${!empty payment ? payment : 0 }</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 col-xs-12">
                        <div class="white-box analytics-info">
                            <h3 class="box-title">순이익</h3>
                            <ul class="list-inline two-part">
                                <li>
                                    <div id="sparklinedash2"></div>
                                </li>
                                <li class="text-right"><i class="ti-arrow-up text-purple"></i> <span class="counter text-purple">${!empty totalCal ? totalCal : 0}</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-sm-6 col-xs-12">
                        <div class="white-box analytics-info">
                            <h3 class="box-title">수수료</h3>
                            <ul class="list-inline two-part">
                                <li>
                                    <div id="sparklinedash3"></div>
                                </li>
                                <li class="text-right"><i class="ti-arrow-up text-info"></i> <span class="counter text-info">${!empty fees ? fees : 0}</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!--/.row -->
                <!--row -->
                <!-- /.row -->
                <div class="row">
                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                        <div class="white-box">
                        <c:if test="${!empty list }">
                        <ul class="list-inline text-left">
                        	<li>
							    <select class="form-control form-control-sm" id="year">
							      <option>2020</option>
							    </select>
						    </li>년
						    <li>
							    <select class="form-control form-control-sm" id="month">
									<c:forEach var="index" begin="1" end="${month }"> 
										<option value="${index }"  ${month == index ? "selected" : "" }>${index }</option>
									</c:forEach>
								</select>								               
							</li>월
						</ul>

                        <ul class="list-inline text-right">
                            <li><h5><i class="fa fa-circle m-r-5 text-info"></i>pc이용금</h5> </li>
                            <li><h5><i class="fa fa-circle m-r-5 text-warning"></i>상품판매금</h5> </li>
							<li><h5><i class="fa fa-circle m-r-5 text-danger"></i>합계</h5> </li>                                    
                        </ul>
                        
                            <canvas id="myChart" style="height:30vh; width:80vw"/>
                            
                        </div>
                    </div>

                </div>
                <input type="hidden" id="page" value=""/>
                <div class="row">
                    <div class="col-md-12 col-lg-12 col-sm-12">
                        <div class="white-box">
                            <div class="col-md-3 col-sm-4 col-xs-6 pull-right">
                                <select class="form-control pull-right row b-none" id="searchType" name="searchType">
                                    <option value = "desc" ${empty searchType || searchType =='desc' ? "selected" : "" }>DESC</option>
                                    <option value = "asc" ${searchType =='asc' ? "selected" : "" }>ASC</option>
                                </select>
                            </div>

							<h3 class="box-title">Franchise Ranking</h3>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Rank</th>
                                            <th>Franchise Name</th>
                                            <th>Partner Name</th>
                                            <th>Calculate Count</th>
                                            <th>Total Payment</th>
                                        </tr>
                                    </thead>
                                    <tbody id="franRanking">
                                    <c:set var="i" value="0" />
										  <c:forEach var="cal" items="${list}">
											<c:set var="i" value="${i + 1 }" />
											<tr>
												<td>${i}</td>
												<td>${cal.franName}</td>											 
												<td>${cal.partnerName}</td>
												<td>${cal.calCount}</td>
												<td>${cal.totalCal} WON</td>
											</tr>
								          </c:forEach>
                                        <tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>  
                    </div>
                    </c:if>
                    <c:if test="${empty list }">
                    	<div id="noDataImg">
                        	<img src="/resources/images/common/noDataImg.jpg">
                        	<h4 class="page-title"><font size="5em">The requested information does not exist</font>
                        </div>
                    </c:if>
                </div>
                
    </div>
	
	<script>
		var labelData = ${dayInfo};
		var paymentData = ${paymentData};
		var productCalData = ${productCalData};
		var pcUseCalData = ${pcUseCalData};
		  	
		var myChart = new Chart.Line($("#myChart"), {
			type: 'line',
			data: {
				labels: labelData,
				datasets: [{
					label: '합계',
					data: paymentData,
					borderColor: [
						'rgba(255, 99, 132, 1)'
					],
					borderWidth: 1
				},{
					label: '상품판매금',
					data: productCalData,
					backgroundColor: [
						'rgba(255, 206, 86, 0.2)'
					],
					borderColor: [
						'rgba(255, 206, 86, 1)'
					],
					borderWidth: 1
				},{
					label: 'pc이용금',
					data: pcUseCalData,
					backgroundColor: [
						'rgba(54, 162, 235, 0.2)'
					],
					borderColor: [
						'rgba(54, 162, 235, 1)'
					],
					borderWidth: 1
				}]
			},
			options: {
				responsive: false,
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero: true
						}
					}]
				},legend: {
				    display: false
				}
			}
		});
		
	    $("#year, #month").on("change", function(){
			$.ajax(
           			{
           				url : "/cal/rest/getSales",
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
							if(JSONData != ''){
							  	myChart.data.labels = JSONData.dayInfo;
							  	myChart.data.datasets[0].data = JSONData.paymentData;
							  	myChart.data.datasets[1].data = JSONData.productCalData;
							  	myChart.data.datasets[2].data = JSONData.pcUseCalData;
									
								myChart.update();									
							}else{
								alert('정산정보가 없습니다.');
							}
						}
        			})
		     });			
	    
	    $("#searchType").on("change", function(){
	    	$.ajax({
                url: '/cal/rest/getFranCalListOrder?&searchType=' + $("#searchType").val(),
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json'
            }).done(function(data, status) {
                var content = "";
                for(var i = 0 ; i < data.list.length ; i++){
                	content += "<tr>"
                			+ "<td>"+ (i + 1) +"</td>"
                			+ "<td>"+ data.list[i].franName +"</td>"
                			+ "<td>"+ data.list[i].partnerName +"</td>"
                			+ "<td>"+ data.list[i].calCount +"</td>"
                			+ "<td>"+ data.list[i].totalCal +" WON </td>"
                			+"</tr>";
                }
                $("#franRanking").html(content);
            })
	    });
	    
	    $(window).scroll(function() {
            // 맨 밑으로 스크롤이 갔을경우 if문을 탑니다. 스크롤 윗부분 + 윈도우창 크기 + 1 > 도큐먼트 창 크기  //스크롤 바닥가기전 1px 전
            if($(window).scrollTop() + $(window).height() + 1 > $(document).height()) {
            	// userId 추가 해서 쏴줘야함
            	var currentPage = $("#page").val();
            	var ctSearchType = $("#searchType").val();
            	
        		if(currentPage == null || currentPage ==""){
        			currentPage = 1;
        		}
        		
           		currentPage++;
           		
           		$("#page").val(currentPage);
           		
           		$.ajax(
           				{
           					url : "/cal/rest/getFranCalList",
							method : "POST" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								page : currentPage,
								orderBy : ctSearchType
							}),
							success : function(JSONData , status) {
								var shap = (currentPage - 1) * 10;
								for(var i = 0 ; i < JSONData.list.length ; i++){
									var newData = "<tr>" + "<td>" + (shap + i) +"</td>" 
											+	"<td>" + JSONData.list[i].franName +"</td>"
											+	"<td>" + JSONData.list[i].partnerName +"</td>"
											+	"<td>" + JSONData.list[i].calCount +"</td>"
											+	"<td>" + JSONData.list[i].totalCal +"WON </td>";;
											
									$( "#franRanking" ).append(newData);
								}
							}
           				})
            }
        }); 				
         </script>
         <footer class="footer text-center"> 2020 &copy; play with wikipicki.com </footer>
</body>
</html>