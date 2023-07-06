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
	<jsp:param value="질문게시판 글쓰기" name="title"/>
</jsp:include>
<div id="container">
<h1>- 질문게시판 글쓰기 -</h1>
	<form action="${pageContext.request.contextPath}/support/questionEnroll.su" method="post" name="enrollfrm" enctype="multipart/form-data">
		<table id="questionTable">
			<tr>
				<th>제목&emsp; : &emsp;</th>
				<td>
					<input name="questionTitle" size="100" required>
				</td>
			</tr>
			<tr>
				<th>작성자&emsp; : &emsp;</th>
				<td>
					<input name="questionWriter" value="${loginMember.userId}" readonly>
				</td>
			</tr>
			<tr>
				<th>첨부파일&emsp; : &emsp;</th>
				<td>
					<input type="file" name="upFile">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="content" rows="50" cols="100" required></textarea>
				</td>
			</tr>
		</table>
		<c:if test="${not empty loginMember.userId}">
			<div id="questionButton">
					<button type="submit" class="btn btn-outline-success">등록</button>&emsp;
					<button type="reset" class="btn btn-outline-success">초기화</button>
			</div>
		</c:if>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>