<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<jsp:param value="상세보기" name="title"/>
</jsp:include>
<div id="container">
	<h2>- 질문게시판 -</h2>
	<table id="listTable">
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>첨부파일</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>답변여부</th>
		</tr>
		<c:forEach items="${questionList}" var="question">
			<tr>
				<td>${question.questionNo}</td>
				<c:choose>
					<c:when test="${loginMember.userId == question.questionWriter || loginMember.userType == 'admin'}">
						<td width="500px"><a href="${pageContext.request.contextPath}/support/questionDetail.su?questionNo=${question.questionNo}">${question.questionTitle}</a></td>
					</c:when>
					<c:otherwise>
						<td width="500px"><a href="${pageContext.request.contextPath}/support/questionList.su">${question.questionTitle}</a></td>
					</c:otherwise>
				</c:choose>
				<td>${question.questionWriter}</td>
				<td>
					<c:if test="${not empty question.originalFilename}">
						<img src="${pageContext.request.contextPath}/resources/img/file.png" alt="파일" width="20px">
					</c:if>
				</td>
				<td>${question.createDate}</td>
				<td>${question.count}</td>
				<c:if test="${question.questionStatus == 0}">
					<td style="color:red">답변대기중</td>
				</c:if>
				<c:if test="${question.questionStatus == 1}">
					<td style="color:blue">답변완료</td>
				</c:if>
			</tr>
		</c:forEach>
		
	</table>

		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<c:if test="${pi.nowPage ne 1}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/support/questionList.su?nowPage=${pi.nowPage-1}" >Previous&emsp;</a>
					</li>
				</c:if>
				<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
					<c:choose>
						<c:when test="${p eq pi.nowPage}">
							<li class="page-item active">
								<a class="page-link" href="${pageContext.request.contextPath}/support/questionList.su?nowPage=${p}">&emsp;${p}&emsp;</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/support/questionList.su?nowPage=${p}">&emsp;${p}&emsp;</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${ pi.nowPage ne pi.totalPage }">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath}/support/questionList.su?nowPage=${pi.nowPage+1}">&emsp;Next</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div>
	<c:if test="${not empty loginMember.userId}">
		<div id="listButton">
			<button id="enrollBtn">글쓰기</button>
		</div>
	</c:if>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
<script>
	document.querySelector("#enrollBtn").addEventListener('click', (e) => {
		location.href='${pageContext.request.contextPath}/support/questionForm.su';
	});
</script>
</html>