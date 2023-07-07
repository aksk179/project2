<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>문서</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/profileEnroll.css">
	 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
/* 개별 스타일 */
#imgThumb {
	width: 100px;
	height: 100px;
}

#nickc {
	font-size: small;
	text-decoration: none;
}

.btn_file input[type="file"] {
	display: none;
}

/* 추가 스타일링 */
.table1, .table2 {
	border-collapse: collapse;
	width: 68%;
}

input[type="text"], input[type="file"] {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	outline: none;
	transition: border-color 0.3s;
}

.table1 th, .table1 td, .table2 th, .table2 td {
	border: 1px solid #ccc;
	padding: 10px;
}

.table1 th, .table2 th {
	background-color: #f2f2f2;
}

.textarea {
	width: 100%;
	height: 200px;
	resize: none;
}

input#proLevel {
	width: 255px;
}

input#height {
	width: 100px;
}

input#weight {
	width: 100px;
}

#gymType {
	width: 275px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	outline: none;
	transition: border-color 0.3s;
}
button[type="submit"], button[type="reset"], button[type="button"] {
	padding: 10px 20px;
	background-color: #c8220f;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 10px;
	transition: background-color 0.3s;
}
.form {
	
}
</style>
</head>

<body>
	<div class="form" align="center">
		<form action="${pageContext.request.contextPath}/profile/profileEnroll.pr" method="post" enctype="multipart/form-data">
			<table border="1" class="table1">
				<tr>
					<th rowspan="3">
						<div class="profile_photo">
							<img id="imgThumb"
								src="https://static.nid.naver.com/images/web/user/default.png?type=s160">
						</div>
					</th>
					<th>닉네임</th>
					<td><input type="hidden" id="userId" name="userId" value="${loginMember.userId}"> 
						<input type="text" id="proNick" name="proNick" required> 
						<input type="button" id="nickc" value="중복확인" onclick="nickCheck();"></td>
				</tr>
				<tr>
					<th>주종목</th>
					<td><select id="gymType" name="proMajor">
							<option value="no">없음</option>
							<option value="taek">태권도</option>
							<option value="grap">잡기류 ex)유도, 주짓수</option>
							<option value="striker">킥복싱류 ex)무에타이, 킥복싱</option>
							<option value="box">복싱</option>
					</select></td>
				</tr>
				<tr>
					<th><label for="level">급수</label></th>
					<td><input type="text" id="proLevel" name="proLevel"
						placeholder="ex) 3단, 블루벨트"></td>
				</tr>
				<tr>
					<th>
						<div>
							<span class="btn_file">
								<div id="filepointer"> 
								<input type="file" id="file" name="upFile" type="hidden">						
								<label for="file">클릭하여 사진첨부</label>
								</div>
							</span>
						</div>
					</th>
					<th>전적</th>
					<td>승 : <input type="text" id="win" name="win" placeholder="0"
						disabled> &emsp; 패 : <input type="text" id="lose"
						name="lose" placeholder="0" disabled></td>
				</tr>
			</table>
			<table border="1" class="table2">
				<tr>
					<th>키</th>
					<td><input type="text" id="height" name="proHeight" required>
						cm</td>
					<th>몸무게</th>
					<td><input type="text" id="weight" name="proWeight" required>
						kg</td>
				</tr>
				<tr>
					<th colspan="4">개인대회</th>
				</tr>
				<tr>
					<td colspan="4"><textarea class="textarea" name="personal"
							cols="35" rows="10" placeholder="ex) 용인대 35회 우승"></textarea></td>
				</tr>
				<tr>
					<th colspan="4">건강상태</th>
				</tr>
				<tr>
					<td colspan="4"><textarea class="textarea" name="note"
							cols="35" rows="10" placeholder="응급상황을 위해서 작성해주세요! ex) 어깨탈골, 기흉"></textarea></td>
				</tr>
				<tr>
					<th colspan="4">누적경고</th>
				</tr>
				<tr id="warn">
					<th width="193px">욕설</th>
					<td> 0회</td>
					<th width="193px">지각</th>
					<td> 0회</td>
				</tr>
				<tr>
					<th>룰 위반</th>
					<td> 0회</td>
					<th>기타 비매너</th>
					<td> 0회</td>
				</tr>
				
			</table>

			
			<div class="btn" align="center">
			<button type="submit">등록</button>
			&emsp;
			<button type="reset">초기화</button>
			</div>
		</form>
	</div>

</body>
<script type="text/javascript">
function nickCheck() {
	  $.ajax({
	       url: "${pageContext.request.contextPath}/profile/nick.ch",
	       data : {proNick : $("#proNick").val()},
	       
         success(result) {
	           const {proNick, available} = result;
	           console.log("proNick" + proNick);
	           console.log("available" + available);
	           if(available) {
	              
	        	   alert("사용가능한 닉네임입니다");
	              document.getElementById("nickcheck").addEventListener("focusout", () => {
	                  const inputNick = document.getElementById("proNick").value;
	                  let messageNick = document.getElementById("messageNick");
	                  const regExp1 = /^[a-zA-Z][a-zA-Z0-9]{2,12}$/;

	                  if (regExp1.test(inputNick)) {
	                      nickCheck = true;
	                  } else if (inputNick === " ") {
	                	  alert("필수정보입니다");
	                     
	                  } 
	              })
 
	              $("#nickbtncheck").val("nickCheck");
	              
	           } else {
	        	   alert("이미 사용중인 닉네임입니다");
	              nickdCheck = false;
	              $("#nickbtncheck").val("nickUncheck");
	           }
      },
      error : console.log
      
	   });
}		

	
</script>
</html>
