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
	href="${pageContext.request.contextPath}/resources/css/member/memberDetail.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body id="">

	<div>
		<form id="form" action="${pageContext.request.contextPath}/member/memberUpdate.me" method="post" name="memInfofrm" align="center !important">
			<h1 id="name">마이페이지</h1>
			<table class="container">		
					<tr>
						<th class="name" scope="col">아이디</th>
						<td class="note" scope="col"><input  name="userId" id="userId"  type="text" value="${loginMember.userId}" style="background-color: #f1f0f0;" readonly ></td>
					<tr>
						<td class="note" colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th class="name" scope="col">비밀번호</th>
						<td class="note" scope="col"><input name="userPw" id="userPw" type="password" placeholder="******" required></td>
					</tr>
					<tr>
						<td class="note" colspan="2" id="message" class="message"></td>
					</tr>

					<tr>
						<th class="name" scope="col">이름</th>
						<td class="note" scope="col" > <input name="userName" id="userName" type="text" value="${loginMember.userName}" readonly style="background-color: #f1f0f0;"></td>
					</tr>
					<tr>
						<td class="note" colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th class="name" scope="col">주민번호</th>
						<td class="note" scope="col"> <input name="userRnn" id="userRnn" type="text" value="${loginMember.userRnn}" readonly style="background-color: #f1f0f0;"></td>
					</tr>
					<tr>
						<td class="note" colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th class="name" scope="col">전화번호</th>
						<td class="note" scope="col"><input name="phone" id="phone" type="text" value="${loginMember.phone}"></td>
					</tr>
					<tr>
						<td class="note" colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th class="name" scope="col">이메일</th>
						<td class="note" scope="col"><input name="userEmail" id="userEmail" type="text" value="${loginMember.userEmail}"></td>
					</tr>
					<tr>
						<td class="note" colspan="2" id="message" class="message"></td>
					</tr>
					<tr>
						<th></th>
						<td class="note"><input id="input" name="zipcode" id="postcode" value="${loginMember.zipcode}"></td>
						<td class="note"><input id="input" type="button" value="우편번호 찾기" onclick="findAddr();"></td>
					</tr>
					<tr>
						<th class="name">주소</th>
						<td class="note" colspan="2"><input id="input" name="address" id="addr" value="${loginMember.address}"></td>
					</tr>
					<tr>
						<th></th>
						<td class="note" colspan="2"><input id="input" name="detailaddress" id="detailAddr" value="${loginMember.detailaddress}"></td>
					</tr>
			</table>
			<!-- <button type="button" class="btn btn-outline-success" onclick="inputCheck();">수정</button> -->
			<button type="submit" class="btn btn-outline-success">수정</button>
			<button type="button" onclick="deleteMember();">탈퇴</button>
		</form>
		<div class="footer" align="center" style="padding: 50px;">

			<p>&copy; 2023 VINCERO. All rights reserved.</p>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>

	function deleteMember() {
		var userPw = document.getElementById("userPw").value;
		if (userPw === null || userPw === '') {
			alert('비밀번호를 입력하세요.');
			return;
		}
		if(window.confirm("탈퇴하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/member/deleteMember.me";
		}
		
	}
</script>
</html>