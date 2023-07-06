<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="회원가입" name="title" />
	</jsp:include>


	<form action="/spring/member/memberEnroll.me" method="post">
		<h1>회원가입</h1>
		<table class="container">
			<tbody>
				<tr>
					<th><label for="userId">아이디</label></th>
					<td><input type="text" id="userId" name="userId"
						placeholder="아이디를 입력하세요" required></td>
					<td><input type="button" id="idc" value="중복확인"
						onclick="idChecka();"> <span id="result"></span> <input
						type="hidden" name="idbtncheck" value="idUncheck"></td>
				</tr>
				<tr>
					<td colspan="2" id="messageId" class="message"></td>
				</tr>
				<tr>
					<th><label for="userPw">비밀번호</label></th>
					<td><input type="password" id="userPw" name="userPw"
						placeholder="비밀번호를 입력하세요" required></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2" id="messagePw" class="message"></td>
				</tr>
				<tr>
					<th><label for="pwc">비밀번호확인</label></th>
					<td><input type="password" id="pwc"
						placeholder="위와 동일한 비밀번호 입력" required></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2" id="messagePwc" class="message"></td>
				</tr>
				<tr>
					<th><label for="userName">이름</label></th>
					<td><input type="text" id="userName" name="userName"
						placeholder="이름을 입력하세요" required></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2" id="messageName" class="message"></td>
				</tr>
				<tr>
					<th><label for="userRnn">주민등록번호</label></th>
					<td colspan="1"><input type="text" id="userRnn" name="userRnn"
						class="rnnc" placeholder="ex) 910412-1234567"> <!-- onkeyup="nextBlank(6, this.id, 'rm')" -->
						<!-- &emsp;-&emsp;<input type="text" id="rm" class="rnnc"> --></td>
				</tr>
				<tr>
					<td colspan="2" id="messageRnn" class="message"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>&emsp;<input type="radio" id="userGender"
						name="userGender" value="M" required> 남 &emsp; &emsp; <input
						type="radio" id="userGender" name="userGender" value="F" required>
						여
					</td>

					<td></td>
				</tr>
				<tr>
					<td colspan="2" id="messageGender" class="message"></td>
				</tr>
				<tr>
					<th><label for="phone" id="phonetitle">휴대폰번호</label></th>
					<td><input id="phone" type="text" name="phone"
						placeholder="ex) 010-1111-1111"></td>
					<td><input type="button" id="phoneChk" class="doubleChk"
						value="인증번호 보내기"></td>
				</tr>
				<tr>
					<th>인증번호</th>
					<td><input id="phone2" type="text" disabled required>
					</td>
					<td><input type="button" id="phoneChk2" class="doubleChk"
						value="본인인증"></td>
				</tr>

				<tr>
					<td colspan="2" id="messagePhone" class="successPhoneChk"></td>
				</tr>
				<tr>
					<th><label for="userEmail">이메일</label></th>
					<td colspan="1"><input type="text" id="userEmail"
						name="userEmail" placeholder="amuge123@kh.com" required> <!--  @ <input type="text" id="emadress" name="emadress" required> -->
					</td>
					<td>
						<!-- <select id="emselect" name="emselect" onchange="updateEmAddress()">
                  <option value="">직접입력</option>
                  <option value="naver.com">naver.com</option>
                  <option value="daum.net">daum.net</option>
                  <option value="gmail.com">gmail.com</option>
            </select> -->
					</td>
				</tr>
				<tr>
					<td colspan="2" id="messageEmail" class="message"></td>
				</tr>
				<tr>
					<th></th>
					<td><input name="zipcode" id="postcode" placeholder="우편번호"
						readonly></td>
					<td><input type="button" value="우편번호 찾기" onclick="findAddr();"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="2"><input name="address" id="addr" readonly></td>
				</tr>
				<tr>
					<th></th>
					<td colspan="2"><input name="detailaddress" id="detailAddr"
						placeholder="상세주소를 입력하세요" required></td>
				</tr>
				<tr>
					<th>개인정보동의</th>
					<td>&emsp;<input type="checkBox" name="userInfo" id="userInfo"
						checked disabled></td>

					<td></td>
				</tr>
				<tr>
					<td colspan="2" id="messageRnn" class="message"></td>
				</tr>
		</table>
		</tbody>
		<div class="btn">
			<button type="submit"  onclick="nice()">회원가입</button>
			&emsp;

		</div>
	</form>
<body>
<script type="text/javascript">

document.getElementById("userId").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputId = document.getElementById("userId").value;
	let messageId = document.getElementById("messageId");
	const regExp1 = /^[a-zA-Z][a-zA-Z0-9]{5,12}$/;

	if (regExp1.test(inputId)) {
	    idCheck = true;
	    messageId.innerHTML = "중복체크하세요.";
	} else if (inputId === "") {
	    messageId.innerHTML = "필수 정보입니다.";
	    idCheck = false;
	} else {
	    messageId.innerHTML = "첫글자는 반드시 영문자이며, 숫자 포함 총 6~13자로 입력하시오.";
	    idCheck = false;
	}
	}, 200);
	})

document.getElementById("userPw").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputPw = document.getElementById("userPw").value;
	let messagePw = document.getElementById("messagePw");
	const regExp2 = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,15}$/;

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

	document.getElementById("pwc").addEventListener("focusout", () => {
	setTimeout(() => {
	   const inputPw = document.getElementById("userPw").value;
	   const inputPwc = document.getElementById("pwc").value;
	   let messagePwc = document.getElementById("messagePwc");
	   if ((inputPwc == inputPw)) {
	       if (inputPwc === "") {
	           messagePwc.innerHTML = "필수 정보입니다.";
	           pwcCheck = false;
	       } else {
	           messagePwc.innerHTML = "비밀번호가 일치합니다 !";
	           pwcCheck = true;
	       }
	   } else if (inputPw === "") {
	       messagePwc.innerHTML = "필수 정보입니다.";
	       pwcCheck = false;
	   } else {
	       messagePwc.innerHTML = "비밀번호가 일치하지 않습니다.";
	       pwcCheck = false;
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
	let messageMail = document.getElementById("messageEmail");
	const regExp4 = /^[a-zA-Z0-9._-]{3,10}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (regExp4.test(inputMail)) {
	    messageEmail.innerHTML = "멋진 이메일입니다 !";
	    mailCheck = true;
	} else if (inputMail === "") {
	    messageEmail.innerHTML = "필수 정보입니다.";
	    mailCheck = false;
	} else {
	    messageEmail.innerHTML = "이메일 형식에 맞아야 합니다.";
	    mailCheck = false;
	}
	}, 200);
	})

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
	
		document.getElementById("userRnn").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputPhone = document.getElementById("userRnn").value;
	let messagePhone = document.getElementById("messageRnn");
	const regExp8 = /^(\d{6})-(\d{7})$/;
	if (regExp8.test(inputPhone)) {
	    messageRnn.innerHTML = "주민번호 확인되었습니다!";
	    phoneCheck = true;
	} else if (inputPhone === "") {
	    messageRnn.innerHTML = "필수 정보입니다.";
	    phoneCheck = false;
	} else {
	    messageRnn.innerHTML = "-를 넣어 주민번호를 입력하세요. 예) 987654-1234567";
	    phoneCheck = false;
	}
	}, 200);
	})   
</script>
	<div class="footer" align="center" style="padding: 50px;">

		<p>&copy; 2023 VINCERO. All rights reserved.</p>
	</div>

</html>