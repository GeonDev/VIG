<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

	
		<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script type="text/javascript">
		
	$( function(){
			$("#userName").focus();			
			$("#login_btn").on("click" ,function(){
				
				var id=$("input:text").val();
				var pw=$("input:password").val();				
				if(id == null || id.length <1) {
					alert('ID 를 입력해주세요.');
					$("input:text").focus();
					return;
				}				
				if(pw == null || pw.length <1) {
					alert('비밀번호를 입력해주세요.');
					$("input:password").focus();
					return;
				}
				$.ajax( 
						{
							url : "/user/json/login",
							method : "POST" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								userId : id,
								password : pw
							}),
							success : function(JSONData , status) {

								//Debug...
								alert(status);
								alert("JSONData : \n"+JSONData);
								alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								alert( JSONData != null );
								
								if( JSONData != null ){
									$(window.parent.document.location).attr("href","/index.jsp");
								}else{
									alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
								}
							}
					}); 
				
			});
		});
	</script>
</head>
<body>

  id<input type="text" id="userCode" name=" userCode" class="form-control validate"><br/>
  pw<input type="password" id="password" name="password" class="form-control validate">
   <button class="btn btn-default" id="login_btn">Login</button>
</body>
</html>
