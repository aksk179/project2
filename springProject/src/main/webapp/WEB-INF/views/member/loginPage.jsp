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
	href="${pageContext.request.contextPath}/resources/css/login.css">
<c:if test="${not empty msg}">
	<script type="text/javascript">
		alert('${msg}');
	</script>
</c:if>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="로그인" name="title" />
	</jsp:include>

	<div class="header" id="login-total">
		<div class="container">
			<form id="login-form"
				action="${pageContext.request.contextPath}/member/memberLogin.me"
				method="post">
				<table>
					<c:if test="${empty loginMember}">
						<tr>
							<th>ID</th>
							<td id="id-part"><input type="text" id="userId"
								name="userId" value="${savedUserId}"
								${savedUserId ? 'readonly' : ''}></td>
							<td rowspan="2"><button class="btn" type="submit">로그인</button></td>
						</tr>
						<tr>
							<th>PW</th>
							<td id="pw-part"><input type="password" id="userPw"
								name="userPw"></td>
						</tr>
						<tr id="signup-part">
							<td></td>
							<td><a
								href="${pageContext.request.contextPath}/member/memberEnroll.me"
								style="text-decoration: none">회원가입&emsp;</a>&ensp; <a
								href="${pageContext.request.contextPath}/member/memberSearchId.me"
								style="text-decoration: none">아이디 찾기</a> <a
								href="${pageContext.request.contextPath}/member/memberNewpw.me"
								style="text-decoration: none">비밀번호 찾기</a></td>

							<td><input type="checkbox" id="saveIdCheckbox"
								name="saveIdCheckbox" ${savedUserId ? 'checked' : ''}>&ensp;ID저장
							</td>
						</tr>
					</c:if>
					<c:if test="${not empty loginMember}">
						<div id="modal">
							<table>
								<tr>
									<td><button class="Logoutbtn" type="button"
											onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.me'">로그아웃</button></td>
									<td><button class="myPagebtn" type="button"
											onclick="location.href='${pageContext.request.contextPath}/member/memberDetail.me'">마이페이지</button></td>
								</tr>
								<tr>
									<td><c:choose>
											<c:when test="${loginMember.userStatus == 2}">
												<button class="profilebtn" type="button"
													onclick="location.href='${pageContext.request.contextPath}/profile/profileUpdate.pr'">프로필
													수정</button>
											</c:when>
											<c:otherwise>
												<button class="profilebtn" type="button"
													onclick="location.href='${pageContext.request.contextPath}/profile/profileEnroll.pr'">프로필
													등록</button>
											</c:otherwise>
										</c:choose></td>
									<td><button class="myMatchbtn" type="button"
											onclick="location.href='#'">내경기</button></td>
								</tr>
								
								<!-- 유저타입에 맞게 버튼을 보여주는 조건문 -->
								<tr>
									<c:choose>
										<c:when test="${loginMember.userType eq 'admin'}">
											<td><button class="managerbtn" type="button"
													onclick="location.href='${pageContext.request.contextPath}/manager/mnMainPage.mn'">관리자</button></td>
										</c:when>
										<c:when test="${loginMember.userType eq 'coach'}">
											<td><button class="coachbtn" type="button"
													onclick="location.href='${pageContext.request.contextPath}/gym/gymMainPage.gym'">관장</button></td>
<%-- 													onclick="location.href='${pageContext.request.contextPath}/gym/gymMainPage.gym?loginId=${loginMember.userId}'">관장</button></td> --%>
										</c:when>
									</c:choose>
								</tr>
							</table>
						</div>
					</c:if>

				</table>
			</form>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function() {
			var saveIdCheckbox = document.getElementById("saveIdCheckbox");
			var userIdInput = document.getElementById("userId");
			var savedUserId = localStorage.getItem("savedUserId");

			if (savedUserId) {
				saveIdCheckbox.checked = true;
				userIdInput.value = savedUserId;
			}

			saveIdCheckbox.addEventListener("change", function(event) {
				if (event.target.checked) {
					localStorage.setItem("savedUserId", userIdInput.value);
				} else {
					localStorage.removeItem("savedUserId");
				}
			});
		});
	</script>
</body>
</html>