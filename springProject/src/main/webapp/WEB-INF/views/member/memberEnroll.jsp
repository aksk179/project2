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
<!--  <script src="${pageContext.request.contextPath}/resources/js/member.js"></script> -->
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
						placeholder="ex) 010-1111-1111" required></td>
					<td><input type="button" id="phoneChk" class="doubleChk"
						value="인증번호 보내기"></td>
				</tr>
				<tr>
					<th>인증번호</th>
					<td><input id="phone2" type="text" disabled required>
					</td>
					<td><input type="button" id="phoneChk2" class="doubleChk"
						value="본인인증" ></td>
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
					<td colspan="2" id="messageEmail" class="message" ></td>
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
					<td colspan="2"><input name="detailAddress" id="detailAddr"
						placeholder="상세주소를 입력하세요" required></td>
				</tr>
				<tr>
					<th>개인정보동의</th>
					<td style="font-size: small">&emsp;<input type="checkBox" name="userInfo" id="userInfo"
						checked disabled >&emsp;개인정보 동의를 완료하였습니다.</td>

					<td></td>
				</tr>
				<tr>
					<td colspan="2" id="messageRnn" class="message"></td>
				</tr>
		</table>
		</tbody>
		<div class="btn">
			<button type="submit"  onclick="inputCheck()">회원가입</button>
			&emsp;

		</div>
	</form>
<body>
<script type="text/javascript">

function inputCheck() {
  var userId = document.getElementById('userId').value;
  var userPw = document.getElementById('userPw').value;
  var pwc = document.getElementById('pwc').value;
  var userName = document.getElementById('userName').value;
  var userRnn = document.getElementById('userRnn').value;
  var phone = document.getElementById('phone').value;
  var phone2 = document.getElementById('phone2').value;
  var userEmail = document.getElementById('userEmail').value;
  
  alert("회원가입을 축하합니다!");
  // 아이디 유효성 검사
  var userIdPattern = /^[a-zA-Z0-9]{5,13}$/;
  if (!userIdPattern.test(userId)) {
    alert('아이디는 6~13자의 영문 대소문자와 숫자로만 입력해야 합니다.');
    return false;
  }

  // 비밀번호 유효성 검사
  var userPwPattern = /^[a-zA-Z0-9!@#$%^&*()]{8,16}$/;
  if (!userPwPattern.test(userPw)) {
    alert('비밀번호는 8~16자의 영문 대소문자, 숫자, 특수문자로만 입력해야 합니다.');
    return false;
  }

  // 비밀번호 확인
  if (userPw !== pwc) {
    alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
    return false;
  }

  // 이름 유효성 검사
  var userNamePattern = /^[가-힣]{2,6}$/;
  if (!userNamePattern.test(userName)) {
    alert('이름은 2~6자의 한글로만 입력해야 합니다.');
    return false;
  }

  // 주민등록번호 유효성 검사
  var userRnnPattern = /^\d{6}-\d{7}$/;
  if (!userRnnPattern.test(userRnn)) {
    alert('주민등록번호는 XXXXXX-XXXXXXX 형식으로 입력해야 합니다.');
    return false;
  }

  // 휴대폰번호 유효성 검사
  var phonePattern = /^\d{3}-\d{4}-\d{4}$/;
  if (!phonePattern.test(phone)) {
    alert('휴대폰번호는 XXX-XXXX-XXXX 형식으로 입력해야 합니다.');
    return false;
  }

  // 인증번호 확인
  if (phone2 === '') {
    alert('인증번호를 입력해야 합니다.');
    return false;
  }

  // 이메일 유효성 검사
  var userEmailPattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  if (!userEmailPattern.test(userEmail)) {
    alert('이메일 주소를 올바른 형식으로 입력해야 합니다.');
    return false;
  }

  // 개인정보 동의 확인
  var userInfo = document.getElementById('userInfo').checked;
  if (!userInfo) {
    alert('개인정보 동의에 체크해야 합니다.');
    return false;
  }

  // 모든 유효성 검사 통과
  return true;
  
}

document.getElementById("userId").addEventListener("focusout", () => {
	setTimeout(() => {
	const inputId = document.getElementById("userId").value;
	let messageId = document.getElementById("messageId");
	const regExp1 = /^[a-zA-Z][a-zA-Z0-9]{6,15}$/;

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
	//const regExp2 = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,15}$/;
	const regExp2 = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

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
	
	
	
	$(function(){
	//휴대폰 번호 인증var code2 = "";

	/* $("#phoneChk").click(function(){
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
	 }); */
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


	});
	function deleteMember() {
		if(window.confirm("탈퇴하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/member/deleteMember.me";
		}
		
	}
	function nice() {
		  alert("회원가입을 축하합니다!");
		}
	function nextBlank(N, Obj, nextB) {
	   if(document.getElementById(Obj).value.length == N) {
	      document.getElementById(nextB).focus();
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

	

	function idChecka() {
	  $.ajax({
	       url: "/spring/member/id.ch",
	       type: "get",
	       data : {ida : $("#userId").val()},
	       dataType : "json",
	      
	           success(result) {
	                 console.log(result);
	           
	           const {userId, available} = result;
	           console.log(result);
	           
	           if(available) {
	              
	              $("#messageId").text("멋진 아이디네요 !");
	              document.getElementById("idc").addEventListener("focusout", () => {
	                  const inputId = document.getElementById("userId").value;
	                  let messageId = document.getElementById("messageId");
	                  const regExp1 = /^[a-zA-Z][a-zA-Z0-9]{5,12}$/;

	                  if (regExp1.test(inputId)) {
	                      idCheck = true;
	                  } else if (inputId === " ") {
	                      messageId.innerHTML = "필수 정보입니다.";
	                      idCheck = false;
	                  } else {
	                      messageId.innerHTML = "첫글자는 반드시 영문자이며, 숫자 포함 총 6~13자로 입력하시오.";
	                      idCheck = false;
	                  }
	              })

	              iddCheck = true;
	              
	              $("#idbtncheck").val("idCheck");
	           } else {
	              $("#messageId").text("이미 사용중이거나 탈퇴한 아이디입니다");
	              iddCheck = false;
	              $("#idbtncheck").val("idUncheck");
	           }

	        },
	        error : console.log
	   });
	}

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
</script>


	<div class="footer" align="center" style="padding: 50px;">

		<p>&copy; 2023 VINCERO. All rights reserved.</p>
	</div>

</html>