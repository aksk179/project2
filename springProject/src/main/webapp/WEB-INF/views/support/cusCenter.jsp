<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<a href="${pageContext.request.contextPath}/support/questionList.su">질문게시판</a>
<a href="${pageContext.request.contextPath}/support/publicEmergency.su">공공체육시설안내</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>