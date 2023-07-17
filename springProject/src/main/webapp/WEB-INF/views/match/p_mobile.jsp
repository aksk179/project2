<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴대폰결제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style type="text/css">
form {
	padding: 20px;
	text-align: center;
}

.container {
	width: 600px;
	margin: 0 auto;
	font-family: 'Arial', sans-serif;
	background-color: #f7f7f7;
	border-radius: 4px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	padding: 50px;
}

table {
	width: 500px;
	border-collapse: collapse;
}

th {
	width: 400px;
	padding: 10px;
	border: none;
	text-align: center;
	color: #333;
}

td {
	width: 150px;
	padding: 10px;
	border: none;
}

label{
	width:90%;
}

input[name="userName"], input[name="phone"], input[name="phone1"], input[name="phoneCheck"],
	input[name="userEmail"] {
	width: 85%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	outline: none;
	transition: border-color 0.3s;
}

input :focus {
	border-color: #c8220f;
}

input[type="button"] {
	padding: 8px 16px;
	background-color: #c8220f;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="button"]:hover {
	background-color: #c8220f;
}

.doubleChk {
	background-color: #008cba;
}

.message {
	font-style: italic;
	color: #ff0000;
}

.successPhoneChk {
	color: #c8220f;
	font-weight: bold;
}

button[type="submit"], button[type="button"], button[type="reset"] {
    width: 80px;
	padding: 10px 20px;
	background-color: #c8220f;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 10px;
	transition: background-color 0.3s;
}

button[type="submit"]:hover, button[type="reset"]:hover, button[type="button"]:hover
	{
	background-color: #c8220f;
}
</style>
</head>
<h2 align="center">휴대폰결제 페이지</h2>
<body>
	<form action="/spring/match/p_mobilePass.py" method="post" name="paymentPass">
		<table align="center">
			<tr>
				<th>결제금액</th>
				<th>20,000원</th>
				<td></td>
			</tr>
			<tr>
				<td>이름</td>
				<th><input id="userName" name="userName"></th>
				<td></td>
			</tr>
			<tr>
				<td>이메일</td>
				<th><input id="userEmail" name="userEmail"></th>
				<td></td>
			</tr>
			<tr>
				<td><label for="phone" id="phonetitle">휴대폰번호</label></td>
				<th><input id="phone" type="text" name="phone"
					placeholder="ex) 010-1111-1111" required></th>
				<td><input type="button" id="phoneChk" class="doubleChk"
					value="인증번호"></td>
			</tr>
			<tr>
				<td>인증번호</td>
				<th><input id="phone2" type="text" name="phone1"disabled required></th>
				<td><input type="button" id="phoneChk2" class="doubleChk"
						value="결제인증"></td>
			</tr>
			<tr>
				<th colspan="3"><button type="button"
						onclick="closePayPopup()">결제</button> &emsp;
					<button type="button" onclick="cancelPayment()">취소</button></th>
			</tr>
		</table>
		
		<div id="paymentPopup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);">
        <p id="paymentMessage"></p>
        <button onclick="closePaymentPopup()">결제 완료</button>
    </div>
	</form>
	<script>
	function cancelPayment() {
	    window.location.href = "${pageContext.request.contextPath}/index.jsp";
	}

	
	$(function(){
		  // 서버에서 JavaScript 변수로 값을 설정
		  var loginMemberPhone = "${loginMember.phone}";

		  $("#phoneChk").click(function(){
		    var phone = $("#phone").val();
		    var userName = $("#userName").val();
		    var userEmail = $("#userEmail").val();
		    var phonePattern = /^010-\d{4}-\d{4}$/;

		    if (userName !== "${loginMember.userName}" || userEmail !== "${loginMember.userEmail}" || phone !== loginMemberPhone) {
		      alert("입력한 정보와 일치하지 않습니다.");
		      return;
		    }

		    if (!phonePattern.test(phone)) {
		      alert("올바른 휴대폰 번호 형식이 아닙니다.");
		      return;
		    }

                <!--  이하 코드는 정규식 패턴이 일치하는 경우에만 실행됩니다. -->
                
                alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");

                $.ajax({
                    url: "phoneCheck?phone=" + phone,
                    type: "GET",
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
         
         document.getElementById("phone").addEventListener("focusout", () => {
        		setTimeout(() => {
        		const inputPhone = document.getElementById("phone").value;
        		let messagePhone = document.getElementById("messagePhone");
        		const regExp7 = /^(\d{3})-(\d{4})-(\d{4})$/;
        		if (regExp7.test(inputPhone)) {
        		    phoneCheck = true;
        		} else if (inputPhone === "") {
        		    alert("휴대폰 인증은 필수입니다");
        		    phoneCheck = false;
        		} else {
        		    alert( "-를 넣어 전화번호를 입력하세요. 예) 010-6752-7417");
        		    phoneCheck = false;
        		}
        		}, 200);
        		})      
        $("#phoneChk2").click(function(){
            if($("#phone2").val() == code2){
            	alert("결제코드 인증 완료되었습니다.");
                $("#phoneDoubleChk").val("true");
                $("#phone2").attr("disabled",true);
            }else{
            	alert("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
                $("#phoneDoubleChk").val("false");
                $(this).attr("autofocus",true);
            }
        });
   });
    
    function closePayPopup() {
        document.getElementById("paymentPopup").style.display = "none";
        alert("결제가 완료되었습니다");
        paymentPass.submit();
    }
    </script>

</body>
</html>