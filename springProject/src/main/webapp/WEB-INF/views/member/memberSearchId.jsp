<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"href="${pageContext.request.contextPath}/resources/css/member/memberSearchId.css">
<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"/>
<script src="${pageContext.request.contextPath}/resources/js/member.js"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/member.js"></script>

<script>
function getUserId() {
  var userEmail = $('#userEmail').val();

  $.ajax({
    url: '${pageContext.request.contextPath}/member/memberSerchId.me',
    method: 'GET',
    data: { userEmail: userEmail },
    success: function(response) {
      
      alert('사용자 아이디: ' + response);
    },
    error: function() {
      alert('이메일 주소를 확인하세요.');
    }
  });
}
</script>

</head>
<body>
	<form onsubmit="return false;">
		<h1 id="h1">아이디 찾기</h1>
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
					<td><input id="phone" type="text" name="phone" placeholder="ex) 010-1111-1111"></td>
					<td><input type="button" id="phoneChk" class="doubleChk" value="인증번호 보내기"></td>
				</tr>
				<tr>
					<td colspan="2" id="messagePw" class="message"></td>
				</tr>
				<tr>
					<th>인증번호</th>
					<td><input id="phone2" type="text" disabled required></td>
					<td><input type="button" id="phoneChk2" class="doubleChk" value="본인인증"></td>
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
</body>
</html>