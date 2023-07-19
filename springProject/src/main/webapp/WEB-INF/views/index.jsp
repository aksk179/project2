<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="홈페이지" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/index.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/index.js"></script>

<div id="billboard">
	<div>
		<img src="${pageContext.request.contextPath}/resources/img/match2.png" alt="match2" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/slogan1.png" alt="slogan1" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/event.png" alt="event" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/slogan3.png" alt="slogan3" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/join.png" alt="join" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/slogan4.png" alt="slogan4" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/league.png" alt="league" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/match1.png" alt="match1" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/slogan2.png" alt="slogan2" width="1024px" height="346px">
		<img src="${pageContext.request.contextPath}/resources/img/match2.png" alt="match2" width="1024px" height="346px">
	</div>
</div>

${msg}

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
