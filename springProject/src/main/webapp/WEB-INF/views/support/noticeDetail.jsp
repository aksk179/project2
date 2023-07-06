<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support/notice.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="상세보기" name="title"/>
</jsp:include>
<div id="container">
	<h1>- 공지게시판 -</h1>
		<form action="${pageContext.request.contextPath}/support/noticeUpdate.su" method="post" enctype="multipart/form-data">>
		<table id="detailTable">
			<tr>
				<th>제목 &emsp; : &emsp;</th>
				<td>
					<c:choose>
						<c:when test="${loginMember.userType == 'admin'}">
							<input type="text" name="noticeTitle" value="${notice.noticeTitle}" size="120"/>
						</c:when>
						<c:otherwise>
							${notice.noticeTitle}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>작성자 &emsp; : &emsp;</th>
				<td>${notice.noticeWriter}</td>
			</tr>
			<tr>
				<th>첨부파일 &emsp; : &emsp;</th>
				<td>
					<c:choose>
						<c:when test="${loginMember.userType == 'admin'}">
							<c:if test="${not empty notice.originalFilename}">
								<button type="button" id="detailFile" class="btn btn-outline-secondary"
									onclick="location.href='${pageContext.request.contextPath}/support/fileDownloadNotice.su?noticeNo=${notice.noticeNo}'">${notice.originalFilename}
								</button>
							</c:if>
							<c:if test="${empty notice.originalFilename}">
								파일없음
							</c:if>
							<input type="file" name="upFile">
						</c:when>
						<c:otherwise>
							<c:if test="${not empty notice.originalFilename}">
								<button type="button" id="detailFile" class="btn btn-outline-secondary"
									onclick="location.href='${pageContext.request.contextPath}/support/fileDownloadNotice.su?noticeNo=${notice.noticeNo}'">${notice.originalFilename}
								</button>
							</c:if>
							<c:if test="${empty notice.originalFilename}">
								파일없음
							</c:if>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>내용 &emsp; : &emsp;</th>
				<td>
					<c:choose>
						<c:when test="${loginMember.userType == 'admin'}">
							<textarea name="content" rows="50" cols="100" required>${notice.content}</textarea>
						</c:when>
						<c:otherwise>
							${notice.content}
						</c:otherwise>
					</c:choose>
				</td>
				
					
			</tr>
			<tr>
				<th>조회수 &emsp; : &emsp;</th>
				<td>${notice.count}</td>
			</tr>
			<tr>
				<th>작성일 &emsp; : &emsp;</th>
				<td>${notice.createDate}</td>
			</tr>
			<tr>
				<th></th>
				<td><input type="hidden" name="noticeNo" value="${notice.noticeNo}"></td>
			</tr>
		</table>
		<c:if test="${loginMember.userType == 'admin'}">
			<div id="detailButton">
				<button type="submit">수정</button>&emsp;
				<button type="reset">취소</button>&emsp;
				<button type="button" id="deleteNotice">삭제</button>
			</div>
		</c:if>
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
	document.querySelector("#deleteNotice").addEventListener('click', (e) => {
		const url = "${pageContext.request.contextPath}/support/noticeDelete.su?noticeNo=" + ${notice.noticeNo};
		location.href = url;
	});
</script>
</html>
