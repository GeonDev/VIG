<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIG</title>

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
		<script type="text/javascript">
		
		function fncAddUser() {
			
			$("form").attr("method" , "POST").attr("action" , "addUser").submit();
		}
			
			$(function() {
				
				$('#password').focusout(function () {
					var pwd = $("input[name='password']").val();
			        var pwd2 = $("input[name='password2']").val();
			 
			        if ( pwd != '' && pwd2 == '' ) {
			            null;
			        } else if (pwd != "" || pwd2 != "") {
			            if (pwd == pwd2) {
			                $("#alert-success").css('display', 'inline-block');
			                $("#alert-danger").css('display', 'none');
			            } else {
			                //alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
			                $("#alert-success").css('display', 'none');
			                $("#alert-danger").css('display', 'inline-block');
			            }
			       	  }
					});
				$( "#signUp_btn" ).on("click" , function() {
					fncAddUser();
				});
				$( function() {
					$("#ty").on("click" , function() {
						self.location = "../user/loginView.jsp";
					});
				});				
			});

				
		</script>
		<style type="text/css">
		.container{
	  padding-right: 300px;
	  padding-left: 300px;
	  padding-top: 100px;'
	  margin-right: auto;
	  margin-left: auto;
	 
	}
		</style>
</head>
<body>

<jsp:include page="../main/toolbar.jsp"></jsp:include>

>
<div class="container">
<div class="text-center border border-light p-5">
  <div class="row">

    <p class="h4 mb-6">Sign up</p>
<form>
    <!-- id -->
    <input type="text" id="userCode" name="userCode" class="form-control mb-4" placeholder="id">
	<label data-error="wrong" data-success="right" for="userName"></label>
	
	<input type="text" id="userName" name="userName" class="form-control mb-4" placeholder="nickName">
	<label data-error="wrong" data-success="right" for="nickName"></label>
    
    <!-- Password -->
    <input type="password" id="password" name="password" class="form-control mb-4" placeholder="Password">
	<label data-error="wrong" data-success="right" for="password"></label>
	
	<input type="text" id="password" name="password2" class="form-control mb-4" placeholder="Password">
    <label data-error="wrong" data-success="right" for="password2"></label>
                 <span id="alert-success" style="display: none;">비밀번호가 일치합니다.</span>
   				 <span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; ">비밀번호가 일치하지 않습니다.</span>
   	
   	<input type="email" id="email" name="email" class="form-control mb-4" placeholder="email">
    <label data-error="wrong" data-success="right" for="email"></label>  
 </form>   
 
        <button  class="btn btn-info btn-block my-4" id="signUp_btn" >Sign up</button>   
         
          <p >Already a member? 
          <span id="ty" class="blue-text ml-1"> sign in</span>
           
           

    

   

	</div>
	</div>
	</div>



<!--       <div class="row">        
    <input type="radio" id="sex" name="sex" value="male" /> 
    <label data-error="wrong" data-success="right" >male</label>
    <input type="radio" id="sex" name="sex" value="female"/>
     <label data-error="wrong" data-success="right" >female</label>
     </div>     -->

</body>
</html>