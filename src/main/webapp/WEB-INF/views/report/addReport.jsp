<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">

	function funcAddReport() {
		
		
		
		document.forms["addReport"].submit();		
	}
	
</script>

<meta charset="UTF-8">
</head>
<body>
			<form name = "addReport" method="Post" action="/VIG/report/addReport">

					<!-- Modal -->
				<div class="modal fade" id="basicExampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				  aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">신고 하기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				       
					       <div class="container-fluid">					  
					       
						       <div class="row">
						      
								<div class="custom-control custom-radio">
								  <input type="radio" class="custom-control-input"  id="defaultGroupExample1"  name="reportType" value="1" checked >
								  <label class="custom-control-label" for="defaultGroupExample1">혐오 표현 </label>
								</div>							

						       </div>
						       
						       <div class="row">
						       	
									<div class="custom-control custom-radio">
									  <input type="radio" class="custom-control-input" id="defaultGroupExample2"  name="reportType" value="2">
									  <label class="custom-control-label" for="defaultGroupExample2">성인 콘텐츠/음란물</label>
									</div>
						       </div>
						       
						      <div class="row">
						     
								<div class="custom-control custom-radio">
								  <input type="radio" class="custom-control-input" id="defaultGroupExample3"  name="reportType" value="3">
								  <label class="custom-control-label" for="defaultGroupExample3">타인을 모욕하는 내용</label>
								</div>
						      </div>
						      
						      <div class="row">
						      						      
								<div class="custom-control custom-radio">
								  <input type="radio" class="custom-control-input" id="defaultGroupExample4"  name="reportType" value="4">
								  <label class="custom-control-label" for="defaultGroupExample4">저작권 침해</label>
								</div>
						      
						      
						      </div>
						       
					       
						       <div class="row">
							       <div class="md-form col-md-12">
								   <textarea id="form" class="md-textarea form-control" name="reportMessage" rows="1"></textarea>
								   <label for="form">추가 메세지 입력</label>
							   		</div>
						       </div>
						       
						       <input type="hidden" name="reportFeedId" value="${feed.feedId}">
						       <input type="hidden" name="violatorCode" value="${feed.writer.userCode}">
					       
					       </div>
				    
				       
				      </div>
				      <div class="modal-footer">				        
				        <button type="button" class="btn btn-primary" onclick="funcAddReport()">제출</button>
				      </div>
				    </div>
				  </div>
				</div>
			 </form> 
</body>
</html>