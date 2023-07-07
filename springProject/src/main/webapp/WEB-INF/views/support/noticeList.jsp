<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support/notice.css?v=<%=System.currentTimeMillis()%>"">
</head>
<body>
${loginMember.userType}
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항" name="title"/>
</jsp:include>
<div id="container">
	<div id="center"><h2>- 공지사항 -</h2></div>
<table id="listTable">
	<tr>
		<th>글번호</th>
		<th>제목</th>
		<th>첨부파일</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:forEach items="${noticeList}" var="notice">
		<tr>
			<td>${notice.noticeNo}</td>
			<td align="left" width="500px"><a href="${pageContext.request.contextPath}/support/noticeDetail.su?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a></td>
			<td>
				<c:if test="${not empty notice.originalFilename}">
					<a href="${pageContext.request.contextPath}/support/fileDownloadNotice.su?noticeNo=${notice.noticeNo}"><img src="${pageContext.request.contextPath}/resources/img/file.png" alt="파일" width="20px"></a>
				</c:if>
			</td>
			<td>${notice.createDate}</td>
			<td>${notice.count}</td>
		</tr>
	</c:forEach>
</table>
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${pi.nowPage ne 1}">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/support/noticeList.su?nowPage=${pi.nowPage-1}" >Previous&emsp;</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
				<c:choose>
					<c:when test="${p eq pi.nowPage}">
						<li class="page-item active">
							<a class="page-link" href="${pageContext.request.contextPath}/support/noticeList.su?nowPage=${p}">&emsp;${p}&emsp;</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/support/noticeList.su?nowPage=${p}">&emsp;${p}&emsp;</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${ pi.nowPage ne pi.totalPage }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/support/noticeList.su?nowPage=${pi.nowPage+1}">&emsp;Next</a>
				</li>
			</c:if>
		</ul>
	</nav>
</div>
<c:if test="${loginMember.userType == 'admin'}">
	<div id="listButton">
		<button id="enrollBtn">글쓰기</button>
	</div>
</c:if>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
	document.querySelector("#enrollBtn").addEventListener('click', (e) => {
		location.href='${pageContext.request.contextPath}/support/noticeForm.su';
	});
</script>
</html>