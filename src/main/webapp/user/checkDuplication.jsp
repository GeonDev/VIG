<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>���̵� �ߺ� Ȯ��</title>

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

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
	
	/*
		$(function() {
			
			$("#userId").focus();
		
			//==> keydown Event ����
			//==> CallBackFunction  :  EventObject ���ڷ� ������ �ִ�.
			//==> ���ǽ� ������
			//==> - Event Object �� ���ڷ� ���� �� �ִ� �� Ȯ��.
			//==> - keyCode �� alert() Ȯ���ϴ� �� ���� ����
			$("#userId").on("keydown" , function(event) {
				
				alert("keyCode  : "+event.keyCode);
				
				if(event.keyCode == '13'){
					//fncCheckDuplication();
				}
			});
			
		});
		*/
		
		//==> "�ߺ�Ȯ��"  Event ó��
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.				
			$("#iDcheck_btn").on("click" , function() {
				
				//==>Debug
				//alert($("td.ct_btn:contains('�ߺ�Ȯ��')").html())
				
				// Form ��ȿ�� ����
				if( $("#userCode").val() != null && $("#userCode").val().length >0) {
					$("form").attr("method" , "POST");
				    $("form").attr("action" , "/VIG/user/checkDuplication");
				    $("form").submit();
				}else {
					alert('���̵�� �ݵ�� �Է��ϼž� �մϴ�.');
				}
				$("#userCode").focus();
			});
		});
		
		
		//==>"���"  Event ó��
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			$("#iDcheck_ok").on("click" , function() {
				
				//==>Debug
				//alert($("td.ct_btn01:contains('���')").html())
				
				if(opener) {
					opener.$("input[name='userCode']").val("${userCode}");
					opener.$("input[name='userName']").focus();
				}
				
				window.close();
			});
		});
		
		
		//==> "�ݱ�"  Event  ó��
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
			$("#iDcheck_no").on("click" , function() {
				//==>Debug
				//alert($("td.ct_btn01:contains('�ݱ�')").html())
				window.close();
			});
		});

	</script>		
	
</head>

<body>

<form>

<!-- Ÿ��Ʋ ���� -->
	<span>���̵� üũ</span>
<!-- Ÿ��Ʋ �� -->

<!-- �˻���� ���� -->
					<span>
						<c:if test="${ ! empty result }">
							${userId} �� ���
							${ result ? "" : "��" }���� �մϴ�.
						</c:if>
					</span>
<!-- �˻���� �� -->

<!-- ��� ���̺���� -->

		<span>���̵�</span>
		
						<input type="text" name="userCode" id="userCode" value="${ ! empty result && result ? userCode : '' }" 
						class="ct_input_g" style="width:100px; height:19px"  maxLength="20" >		
						<hr/>
						<button type="button" class="btn btn-primary btn-sm" id="iDcheck_btn">�ߺ�Ȯ��</button>								
					

<!-- ��ư ���� -->

					<c:if test="${ ! empty result && result }">
						<td width="17" height="23">
							<button type="button" class="btn btn-primary btn-sm" id="iDcheck_ok">���</button>
					</c:if>
							<button type="button" class="btn btn-primary btn-sm" id="iDcheck_no">�ݱ�</button>

</form>

</body>

</html>