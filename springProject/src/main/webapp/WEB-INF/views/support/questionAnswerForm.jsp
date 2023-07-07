<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support/question.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="질문 답변하기" name="title"/>
</jsp:include>
<div id="container">
<h1>- 질문 답변하기 -</h1>
	<form action="${pageContext.request.contextPath}/support/questionAnswerEnroll.su" method="post" enctype="multipart/form-data">
		<table id="questionTable">
			<tr>
				<td>
					<input type="hidden" name="questionTitle" size="100" value="질문에 대한 답변입니다.">
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="questionWriter" value="${questionWriterFromParent}" readonly>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="content" rows="50" cols="100" required></textarea>
					<input type="hidden" name="ref" value="${questionNoFromParent}" readonly>
				</td>
			</tr>
		</table>
		<c:if test="${loginMember.userType == 'admin'}">
			<div id="questionButton">
				<button type="submit">답변</button>&emsp;
				<button type="reset">초기화</button>
			</div>
		</c:if>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>