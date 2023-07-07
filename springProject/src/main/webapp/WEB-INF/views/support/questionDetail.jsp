<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support/question.css?v=<%=System.currentTimeMillis()%>">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="상세보기" name="title"/>
</jsp:include>
<div id="container">
	<h1>- 질문게시판게시글 -</h1>
		<form action="${pageContext.request.contextPath}/support/questionUpdate.su" method="post" enctype="multipart/form-data">>
		<table id="detailTable">
			<tr>
				<th>제목 &emsp; : &emsp;</th>
				<td>
					<c:choose>
						<c:when test="${loginMember.userId == question.questionWriter}">
							<input type="text" name="questionTitle" value="${question.questionTitle}" size="120"/>
						</c:when>
						<c:otherwise>
							${question.questionTitle}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>작성자 &emsp; : &emsp;</th>
				<td>${question.questionWriter}</td>
			</tr>
			<tr>
				<th>첨부파일 &emsp; : &emsp;</th>
				<td>
					<c:choose>
						<c:when test="${loginMember.userId == question.questionWriter}">
							<c:if test="${not empty question.originalFilename}">
								<button type="button" id="detailFile" class="btn btn-outline-secondary"
									onclick="location.href='${pageContext.request.contextPath}/support/fileDownloadQuestion.su?questionNo=${question.questionNo}'">${question.originalFilename}
								</button>
							</c:if>
							<c:if test="${empty question.originalFilename}">
								파일없음
							</c:if>
							<input type="file" name="upFile">
						</c:when>
						<c:otherwise>
							<c:if test="${not empty question.originalFilename}">
								<button type="button" id="detailFile" class="btn btn-outline-secondary"
									onclick="location.href='${pageContext.request.contextPath}/support/fileDownloadQuestion.su?questionNo=${question.questionNo}'">${question.originalFilename}
								</button>
							</c:if>
							<c:if test="${empty question.originalFilename}">
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
						<c:when test="${loginMember.userId == question.questionWriter}">
							<textarea name="content" rows="50" cols="100" required>${question.content}</textarea>
						</c:when>
						<c:otherwise>
							${question.content}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>조회수 &emsp; : &emsp;</th>
				<td>${question.count}</td>
			</tr>
			<tr>
				<th>작성일 &emsp; : &emsp;</th>
				<td>${question.createDate}</td>
			</tr>
			<tr>
				<th>답변상태 &emsp; : &emsp;</th>
				<c:if test="${question.questionStatus == 0}">
					<td style="color:red">답변대기중</td>
				</c:if>
				<c:if test="${question.questionStatus == 1}">
					<td style="color:blue">답변완료</td>
				</c:if>
			</tr>
			<tr>
				<th></th>
				<td><input type="hidden" name="questionNo" value="${question.questionNo}"></td>
			</tr>
		</table>
		<div id="detailButton">
			<c:if test="${question.depth == 0}">
				<c:if test="${loginMember.userId == question.questionWriter}">
					<button type="submit">수정</button>&emsp;
					<button type="reset">취소</button>&emsp;
					<button type="button" id="deleteQuestion">삭제</button>
				</c:if>
				<c:if test="${loginMember.userType == 'admin'}">
					<button type="button" id="answerQuestion" onclick="location.href='${pageContext.request.contextPath}/support/questionAnswerForm.su?questionNo=${question.questionNo}&questionWriter=${question.questionWriter}'">답변하기</button>
				</c:if>
			</c:if>
			<c:if test="${question.depth == 1}">
				<c:if test="${loginMember.userType == 'admin'}">
					<button type="reset">취소</button>&emsp;
					<button type="button" id="deleteQuestion">삭제</button>
				</c:if>
			</c:if>
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/support/questionList.su'">&emsp;리스트보기</button>&emsp;
		</div>
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
	$("#deleteQuestion").click(function() {
	    location.href = '${pageContext.request.contextPath}/support/questionDelete.su?questionNo=${question.questionNo}';
	});
</script>	
</html>
