<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/memberDetail.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>

	<div id="container">
		<form
			action="${pageContext.request.contextPath}/member/memberUpdate.me"
			method="post" name="memInfofrm">
			<h1>마이페이지</h1>
			<table class="container">
				
					<tr>
						<th scope="col">아이디</th>
						<td scope="col"><input  name="userId" id="userId"  type="text" value="${loginMember.userId}" readonly style="background-color: #f1f0f0;"></td>
					<tr>
						<td colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th scope="col">비밀번호</th>
						<td scope="col"><input name="userPw" id="userPw" type="password" placeholder="******" required></td>
					</tr>
					<tr>
						<td colspan="2" id="message" class="message"></td>
					</tr>

					<tr>
						<th scope="col">이름</th>
						<td scope="col" > <input name="userName" id="userName" type="text" value="${loginMember.userName}" readonly style="background-color: #f1f0f0;"></td>
					</tr>
					<tr>
						<td colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th scope="col">주민번호</th>
						<td scope="col"> <input name="userRnn" id="userRnn" type="text" value="${loginMember.userRnn}" readonly style="background-color: #f1f0f0;"></td>
					</tr>
					<tr>
						<td colspan="2" id="messageRnn" class="message"></td>
					</tr>
					<tr>
						<th scope="col">전화번호</th>
						<td scope="col"><input name="phone" id="phone" type="text" value="${loginMember.phone}"></td>
					</tr>
					<tr>
						<td colspan="2" id="messagePhone" class="message"></td>
					</tr>
					<tr>
						<th scope="col">이메일</th>
						<td scope="col"><input name="userEmail" id="userEmail" type="text" value="${loginMember.userEmail}"></td>
					</tr>
					<tr>
						<td colspan="2" id="messageEmail" class="message"></td>
					</tr>
					<tr>
						<th></th>
						<td><input name="zipcode" id="postcode" value="${loginMember.zipcode}"></td>
						<td><input type="button" value="우편번호 찾기" onclick="findAddr();"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="2"><input name="address" id="addr" value="${loginMember.address}"></td>
					</tr>
					<tr>
						<th></th>
						<td colspan="2"><input name="detailAddress" id="detailAddr" value="${loginMember.detailAddress}"></td>
					</tr>
			</table>

			<button type="submit" class="btn btn-outline-success" onclick="inputCheck()">수정</button>
			<button type="button" onclick="deleteMember();">탈퇴</button>
		</form>
		<div class="footer" align="center" style="padding: 50px;">

			<p>&copy; 2023 VINCERO. All rights reserved.</p>
		</div>

	</div>


</body>

<script>
$(function(){

	//휴대폰 번호 인증var code2 = "";

	$("#phoneChk").click(function(){
	    alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
		var phone = $("#phone").val();
		$.ajax({
	        type:"GET",
	        url:"phoneCheck?phone=" + phone,
	        cache : false,
	        success:function(data){
	        	if(data == "error"){
	        		alert("휴대폰 번호가 올바르지 않습니다.")
					$(".successPhoneChk").text("유효한 번호를 입력해주세요.");
					$("#phone").attr("autofocus",true);
	        	}else{	        		
	        		$("#phone2").attr("disabled",false);
	        		$("#phoneChk2").css("display","inline-block");
	        		$(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
	        		$("#phone").attr("readonly",true);
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


	  

	});
	function deleteMember() {
		if(window.confirm("탈퇴하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/member/deleteMember.me";
		}
		
	}
	
		

	function findAddr() {
	    new daum.Postcode({
	        oncomplete: function (data) {
	            let roadAddr = data.roadAddress;
	            let jibunAddr = data.jibunAddress;
	            let extraAddr = '';

	            document.getElementById("postcode").value = data.zonecode;

	            if (data.userSelectedType == 'R') {
	                if (roadAddr != '') {
	                    if (data.bname != '') {
	                        extraAddr += data.bname;
	                    }
	                    if (data.buildingName != '') {
	                        extraAddr += extraAddr != '' ? ', ' + data.buildingName : data.buildingName;
	                    }
	                    roadAddr += extraAddr != '' ? '(' + extraAddr + ')' : '';
	                    document.getElementById("addr").value = roadAddr;
	                }
	            } else if (data.userSelectedType == 'J') {
	                document.getElementById("addr").value = jibunAddr;
	            }

	            document.getElementById("detailAddr").focus();
	        }
	    }).open();
	}

	let idCheck = false;
	let pwCheck = false;
	let pwcCheck = false;
	let nameCheck = false;
	let emailCheck = false;
	let rnnCheck1 = false;
	let rnnCheck2 = false;
	let rnnCheck = false;
	let phoneCheck = false;


	function updateEmAddress() {
	 var emselect = document.getElementById("emselect");
	 var emadress = document.getElementById("emadress");

	 if (emselect.value === "") {
	   // 선택한 값이 "직접입력"일 경우 emadress 입력란을 비웁니다.
	   emadress.value = "";
	   emadress.disabled = false; // 필요에 따라 입력란을 활성화할 수도 있습니다.
	 } else {
	   // 선택한 값이 이메일 도메인일 경우 emadress 입력란을 해당 값으로 설정합니다.
	   emadress.value = emselect.value;
	   emadress.disabled = true; // 필요에 따라 입력란을 비활성화할 수도 있습니다.
	 }
	}

	function inputIdChk() {
	regFrm.idbtncheck.value = "idUncheck";
	}

	document.getElementById("userPw").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputPw = document.getElementById("userPw").value;
	let messagePw = document.getElementById("messagePw");
	const regExp2 = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])([a-zA-Z0-9!@#$%^&*]).{8,15}$/;

	if (regExp2.test(inputPw)) {
	    messagePw.innerHTML = "멋진 비밀번호입니다 !";
	    pwCheck = true;
	} else if (inputPw === "") {
	    messagePw.innerHTML = "필수 정보입니다.";
	    pwCheck = false;
	} else {
	    messagePw.innerHTML = "영문자, 숫자, 특수문자로 총 8~15자로 입력하시오.";
	    pwCheck = false;
	}
	}, 200);
	})

	

	document.getElementById("userName").addEventListener("focusout", () => {
	setTimeout(() => {
	    const inputName = document.getElementById("userName").value;
	    let messageName = document.getElementById("messageName");
	    const regExp3 = /^[가-힣]{2,}$/;
	if (regExp3.test(inputName)) {
	    messageName.innerHTML = "멋진 이름입니다 !";
	    nameCheck = true;
	} else if (inputName === "") {
	    messageName.innerHTML = "필수 정보입니다.";
	    nameCheck = false;
	} else {
	    messageName.innerHTML = "한글 2글자 이상, 15자 이하로 입력하시오.";
	    nameCheck = false;
	}
	}, 200);

	})



	document.getElementById("userEmail").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputMail = document.getElementById("userEmail").value;
	let messageMail = document.getElementById("messagEmail");
	const regExp4 = /^[a-zA-Z0-9._-]{3,10}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (regExp4.test(inputMail)) {
	    messageMail.innerHTML = "멋진 이메일입니다 !";
	    mailCheck = true;
	} else if (inputMail === "") {
	    messageMail.innerHTML = "필수 정보입니다.";
	    mailCheck = false;
	} else {
	    messageMail.innerHTML = "이메일 형식에 맞아야 합니다.";
	    mailCheck = false;
	}
	}, 200);
	}) 

	document.getElementById("phone").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputPhone = document.getElementById("phone").value;
	let messagePhone = document.getElementById("messagePhone");
	const regExp7 = /^(\d{3})-(\d{4})-(\d{4})$/;
	if (regExp6.test(inputPhone)) {
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

	function inputCheck() {
	let inputAgain = [];
	if (idCheck && pwCheck && pwcCheck && nameCheck && mailCheck && phoneCheck && iddCheck && birthCheck) {
	    console.log("회원가입을 축하드립니다");
	    regFrm.submit();
	} else {
	    if (idCheck === false) {
	        inputAgain.push("아이디");
	        $("#userId").val("");
	        messageId.innerHTML = "";
	    }
	    if (pwCheck === false) {
	        inputAgain.push("비밀번호");
	    }
	    if (pwcCheck === false) {
	        inputAgain.push("비밀번호검토");
	        
	    }
	    if (nameCheck === false) {
	        inputAgain.push("이름");
	        $("#userName").val("");
	        messageName.innerHTML = "";
	    }
	    if (mailCheck === false) {
	        inputAgain.push("이메일");
	        $("#userEmail").val("");
	        messageMail.innerHTML = "";
	    }
	    if (birthCheck === false) {
	       inputAgain.push("생년월일");
	       $("#userRnn").val("");
	       messageBirth.innerHTML = "";
	    }
	    if (phoneCheck === false) {
	        inputAgain.push("전화번호");
	        $("#phone").val("");
	        messagePhone.innerHTML = "";
	    }
	    if (regFrm.idbtncheck.value != "idCheck") {
	       inputAgain.push("아이디중복체크");
	       messageId.innerHTML = "";
	       $("#userId").val("");
	    }
	    alert(inputAgain + "를 확인하세요.");
	    
	    $("#userPw").val("");
	    $("#pwc").val("");
	    messagePw.innerHTML = "";
	    messagePwc.innerHTML = "";
	}


	}


</script>
</html>
