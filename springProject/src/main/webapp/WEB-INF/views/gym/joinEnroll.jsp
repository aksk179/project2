<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gym/join.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="가맹점신청" name="title"/>
	</jsp:include>
	<div id="container">
		<div id="describe">
			<h1>- 가맹점 신청 -</h1>
			<h3>( 빈체로 공식 체육관이 된다면 ?&ensp; 다음과 같은 혜택이 있습니다 ! )</h3>
			<p>스포츠를 즐기는 다양한 빈체로 유저들이 관장님의 체육관을 매치를 위해 쉽게 예약 가능 !</p>
			<p>체육관에서 진행되는 매치의 대부분 수익은 관장님께 !</p>
			<p>많은 사람에게 체육관을 홍보 할 수 있는 절호의 기회 !</p>
		</div>
		<div id="join">
			<div id="image">
				<img src="${pageContext.request.contextPath}/resources/img/gym/taekwon.jpg" alt="taekwondo" width="750px" height="750px">
			</div>
			<div id="table">
				<form action="${pageContext.request.contextPath}/gym/joinEnrollForm.gym" name="joinForm" method="post">
					<table>
						<tr>
							<td colspan="2">
								<h2>가맹점신청란</h2>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<i>1. 회원가입 및 로그인 먼저 진행 해주세요</i>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<i>2. 가맹점 신청란에 정보를 입력하시고, 가맹신청을 누르세요</i>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<i>3. 모든 정보는 계약상의 정보로서 정확히 입력해주세요</i>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<i>4. 신청을 하시면, 빈체로가 빠른 시일내에 연락을 취할 것입니다</i><br>
							</td>
						</tr>
						<tr>
							<th>
								<label for="gymBoss">사업자대표명&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="gymBoss" name="gymBoss" placeholder="&emsp;사업자 대표명 입력란" required>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="messageGymBoss" class="message"></td>
						</tr>
						<tr>
							<th>
								<label for="businessNo">사업자번호&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="businessNo" name="businessNo" placeholder="&emsp;숫자로만 10글자 입력란" required>
							</td>
						</tr>	
						<tr>
							<td colspan="2" id="messageBusinessNo" class="message"></td>
						</tr>
						<tr>
							<th>
								<label for="gymCoach">관장님성함&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="gymCoach" name="gymCoach" value="${loginMember.userName}" readonly>
							</td>
						</tr>
						<tr>
							<th>
								<label for="gymName">체육관이름&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="gymName" name="gymName" placeholder="&emsp;체육관 이름 입력란" required>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="messageGymName" class="message"></td>
						</tr>
						<tr>
							<th>
								<label for="gymType">체육관종목&emsp;:&emsp;</label>
							</th>
							<td>
								<select id="gymType" name="gymType">
									<option value="taek">태권도</option>
								    <option value="grap">잡기류 ex)유도, 주짓수</option>
								    <option value="striker">킥복싱류 ex)무에타이, 킥복싱</option>
								    <option value="box">복싱</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>
								<label for="coachPhone">관장님전화번호&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="coachPhone" name="coachPhone" value="${loginMember.phone}" readonly>
							</td>
						</tr>
						<tr>
							<th>
								<label for="gymPhone">체육관전화번호&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="gymPhone" name="gymPhone" placeholder="&emsp;000-0000-0000" required>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="messageGymPhone" class="message"></td>
						</tr>
						<tr>
							<th>
								<label for="gymZipcode">체육관우편번호&emsp;:&emsp; </label>
							</th>
							<td>
								<input type="text" id="gymZipcode" name="gymZipcode" readonly placeholder="&emsp;주소찾기를 클릭" required>
								<input type="button" id="addressButton" value="주소찾기" onclick="findAddr();">
							</td>
						</tr>
						<tr>
							<th>
								<label for="gymAddress">체육관주소&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="gymAddress" name="gymAddress" readonly placeholder="&emsp;주소찾기를 클릭" required>
							</td>
						</tr>
						<tr>
							<th>
								<label for="gymDetailaddress">체육관상세주소&emsp;:&emsp;</label>
							</th>
							<td>
								<input type="text" id="gymDetailaddress" name="gymDetailaddress" placeholder="&emsp;상세 주소를 입력란" required>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="messageGymDetailaddress" class="message"></td>
						</tr>
						<tr>
							<th>
							</th>
							<td>
								<input type="hidden" name="userId" value="${loginMember.userId}">
							</td>
						</tr>
					</table>
					<div id="button">
						<input id="submitButton" type="submit" value="가맹신청" onclick="inputCheck()">
						<input id="resetButton" type="reset" value="다시쓰기">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
let gymBossCheck = false;
let businessNoCheck = false;
let gymNameCheck = false;
let gymPhoneCheck = false;
let gymDetailaddressCheck = false;

document.getElementById("gymBoss").addEventListener("focusout", () => {
	setTimeout(() => {
	    const inputGymBoss = document.getElementById("gymBoss").value;
	    const messageGymBoss = document.getElementById("messageGymBoss");
	    const regExpGymBoss = /^[가-힣]{2,6}$/;
		if(regExpGymBoss.test(inputGymBoss)) {
		    messageGymBoss.innerHTML = "<span style='color: blue;'>멋진 이름입니다 !</span>";
		    gymBossCheck = true;
		} else if (inputGymBoss === "") {
		    messageGymBoss.innerHTML = "<span style='color: red;'>필수 정보입니다 !</span>";
		    gymBossCheck = false;
		} else {
		    messageGymBoss.innerHTML = "<span style='color: red;'>한글 2글자 이상, 6자 이하로 입력하세요 !</span>";
		    gymBossCheck = false;
		}
	}, 200);
})

document.getElementById("businessNo").addEventListener("focusout", () => {
	setTimeout(() => {
	    const inputBusinessNo = document.getElementById("businessNo").value;
	    const messageBusinessNo = document.getElementById("messageBusinessNo");
	    const regExpBusinessNo = /^\d{10}$/;
		if(regExpBusinessNo.test(inputBusinessNo)) {
		    messageBusinessNo.innerHTML = "<span style='color: blue;'>사업자 번호를 입력하셨습니다 !</span>";
		    businessNoCheck = true;
		} else if (inputBusinessNo === "") {
			messageBusinessNo.innerHTML = "<span style='color: red;'>필수 정보입니다 !</span>";
		    businessNoCheck = false;
		} else {
			messageBusinessNo.innerHTML = "<span style='color: red;'>숫자로만 '-' 없이 10자로 입력하세요 !</span>";
		    businessNoCheck = false;
		}
	}, 200);
})

document.getElementById("gymName").addEventListener("focusout", () => {
	setTimeout(() => {
	    const inputGymName = document.getElementById("gymName").value;
	    const messageGymName = document.getElementById("messageGymName");
	    const regExpGymName = /^[가-힣]{1,10}$/;
		if(regExpGymName.test(inputGymName)) {
		    messageGymName.innerHTML = "<span style='color: blue;'>멋진 체육관 이름입니다 !</span>";
		    gymNameCheck = true;
		} else if (inputGymName === "") {
			messageGymName.innerHTML = "<span style='color: red;'>필수 정보입니다 !</span>";
			gymNameCheck = false;
		} else {
			messageGymName.innerHTML = "<span style='color: red;'>한글로만 1글자에서 10글자 사이로 입력해주세요 !</span>";
			gymNameCheck = false;
		}
	}, 200);
})

document.getElementById("gymPhone").addEventListener("focusout", () => {
	setTimeout(() => {
	    const inputGymPhone = document.getElementById("gymPhone").value;
	    const messageGymPhone = document.getElementById("messageGymPhone");
	    const regExpGymPhone = /^\d{2,3}-\d{3,4}-\d{4}$/;
		if(regExpGymPhone.test(inputGymPhone)) {
		    messageGymPhone.innerHTML = "<span style='color: blue;'>올바른 체육관 번호를 입력하셨습니다 !</span>";
		    gymPhoneCheck = true;
		} else if (inputGymPhone === "") {
			messageGymPhone.innerHTML = "<span style='color: red;'>필수 정보입니다 !</span>";
			gymPhoneCheck = false;
		} else {
			messageGymPhone.innerHTML = "<span style='color: red;'>체육관 번호는 반드시 '-'를 넣어 기입해주세요 !</span>";
			gymPhoneCheck = false;
		}
	}, 200);
})

document.getElementById("gymDetailaddress").addEventListener("focusout", () => {
	setTimeout(() => {
	    const inputGymDetailaddress = document.getElementById("gymDetailaddress").value;
	    const messageGymDetailaddress = document.getElementById("messageGymDetailaddress");
	    const regExpGymDetailaddress = /^[-\s\p{L}\p{N}\p{S}]{3,50}$/u;
		if(regExpGymDetailaddress.test(inputGymDetailaddress)) {
		    messageGymDetailaddress.innerHTML = "<span style='color: blue;'>상세주소를 입력하셨습니다 !</span>";
		    gymDetailaddressCheck = true;
		} else if (inputGymDetailaddress === "") {
			messageGymDetailaddress.innerHTML = "<span style='color: red;'>필수 정보입니다 !</span>";
			gymDetailaddressCheck = false;
		} else {
			messageGymDetailaddress.innerHTML = "<span style='color: red;'>정확한 주소를 입력하세요 !</span>";
			gymDetailaddressCheck = false;
		}
	}, 200);
})

function inputCheck() {
	console.log("a");
	let inputAgain = [];
	if(gymBossCheck && businessNoCheck && gymNameCheck && gymPhoneCheck && gymDetailaddressCheck) {
	    joinForm.submit();
	} else {
	    if (gymBossCheck === false) {
	        inputAgain.push("사업자명");
	        $("#gymBoss").val("");
	        messageGymBoss.innerHTML = "";
	    }
	    if (businessNoCheck === false) {
	        inputAgain.push("사업자번호");
	        $("#businessNo").val("");
	        messageBusinessNo.innerHTML = "";
	    }
	    if (gymNameCheck === false) {
	        inputAgain.push("체육관이름");
	        $("#gymName").val("");
	        messageGymName.innerHTML = "";
	    }
	    if (gymPhoneCheck === false) {
	        inputAgain.push("체육관번호");
	        $("#gymPhone").val("");
	        messageGymPhone.innerHTML = "";
	    }
	    if (gymDetailaddressCheck === false) {
	        inputAgain.push("상세주소");
	        $("#gymDetailaddress").val("");
	        messageGymDetailaddress.innerHTML = "";
	    }
	    alert(inputAgain + "란을 확인하세요.");
	}
}
	
function findAddr() {
    new daum.Postcode({
        oncomplete: function (data) {
            let roadAddr = data.roadAddress;
            let jibunAddr = data.jibunAddress;
            let extraAddr = '';
         
            document.getElementById("gymZipcode").value = data.zonecode;

            if (data.userSelectedType == 'R') {
                if (roadAddr != '')	 {
                    if (data.bname != '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName != '') {
                        extraAddr += extraAddr != '' ? ', ' + data.buildingName : data.buildingName;
                    }
                    roadAddr += extraAddr != '' ? '(' + extraAddr + ')' : '';
                    document.getElementById("gymAddress").value = roadAddr;
                }
            } else if (data.userSelectedType == 'J') {
                document.getElementById("gymAddress").value = jibunAddr;
            }

            document.getElementById("gymDetailaddress").focus();
        }
    }).open();
}
</script>
</html>