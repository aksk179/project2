<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/memberDetail.css">

</head>
<body>
	<form action="${pageContext.request.contextPath}/member/memberFindId.me" method="post" name="memInfofrm">
		<h1>아이디 찾기</h1>
		<table class="container">
			<tbody>
				<tr>
					<th><label for="userEmail">이메일</label></th>
					<td><input type="text" id="userEmail" name="userEmail" placeholder="이메일 주소를 입력하세요" required></td>
					<td><span id="result"></span></td>
				</tr>
				<tr>
					<td colspan="2" id="messageId" class="message"></td>
				</tr>
						 <tr>
					<th><label for="phone" id="phonetitle">휴대폰번호</label></th>
					<td><input id="phone" type="text" name="phone"
						placeholder="ex) 010-1111-1111"></td>
					<td><input type="button" id="phoneChk" class="doubleChk"
						value="인증번호 보내기"></td>
				</tr>
				<tr>
					<td colspan="2" id="messagePhone" class="successPhoneChk"></td>
				</tr> 
				<tr>
					<th>인증번호</th>
					<td><input id="phone2" type="text" disabled required></td>
					<td><input type="button" id="phoneChk2" class="doubleChk"
						value="본인인증"></td>
				</tr>
				<tr>
					<td colspan="2" id="messagePwc" class="message"></td>
				</tr> 
			</tbody>
		</table>
		<div class="btn">
			 <button type="button" onclick="getUserId()">확인</button>
		</div>
	</form>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script>
	
	$(document).ready(function() {
    $("form[name='memInfofrm']").submit(function(event) {
        event.preventDefault();
        getUserId();
    });
});

function getUserId() {
    var userEmail = document.getElementById('userEmail').value;

    $.ajax({
        url: '${pageContext.request.contextPath}/member/memberFindId.me',
        method: 'POST',
        data: {
            userEmail: userEmail
        },
        success: function(response) {
            if (response.userId) {
                alert('사용자 아이디: ' + response.userId);
            } else {
                alert('일치하는 사용자를 찾을 수 없습니다.');
            }
            window.location.href = '${pageContext.request.contextPath}/member/GoLoginPage.me';
        },
        error: function() {
            alert('오류가 발생했습니다.');
        }
    });
}
document.getElementById("phone").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputPhone = document.getElementById("phone").value;
	let messagePhone = document.getElementById("messagePhone");
	const regExp7 = /^(\d{3})-(\d{4})-(\d{4})$/;
	if (regExp7.test(inputPhone)) {
	    messagePhone.innerHTML = "멋진 전화번호입니다 !";
	    phoneCheck = true;
	} else if (inputPhone === "") {
	    messagePhone.innerHTML = "필수 정보입니다.";
	    phoneCheck = false;
	} else {
	    messagePhone.innerHTML = "-를 넣어 전화번호를 입력하세요. 예) 010-6752-7417";
	    phoneCheck = false;
	}
	}, 200);
	})      
	
	$("#phoneChk").click(function(){
	    var phone = $("#phone").val();
	    
	    // 정규식 패턴
	    var phonePattern = /^010-\d{4}-\d{4}$/;

	    if (!phonePattern.test(phone)) {
	        alert("올바른 휴대폰 번호 형식이 아닙니다.");
	        return;
	    }

	    // 이하 코드는 정규식 패턴이 일치하는 경우에만 실행됩니다.
	    
	    alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");

	    $.ajax({
	        type: "GET",
	        url: "phoneCheck?phone=" + phone,
	        cache: false,
	        success: function(data) {
	            if (data == "error") {
	                alert("휴대폰 번호가 올바르지 않습니다.");
	                $(".successPhoneChk").text("유효한 번호를 입력해주세요.");
	                $("#phone").attr("autofocus", true);
	            } else {                    
	                $("#phone2").attr("disabled", false);
	                $("#phoneChk2").css("display", "inline-block");
	                $(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
	                $("#phone").attr("readonly", true);
	                code2 = data;
	            }
	        }
	    });
	});
 
$("#phoneChk2").click(function(){
	if($("#phone2").val() == code2){
		$(".successPhoneChk").text("인증번호가 일치합니다.");
		$("#phoneDoubleChk").val("true");
		$("#phone2").attr("disabled",true);
	}else{
		$(".successPhoneChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
		$("#phoneDoubleChk").val("false");
		$(this).attr("autofocus",true);
	}
});
	</script>
</body>
</html>
