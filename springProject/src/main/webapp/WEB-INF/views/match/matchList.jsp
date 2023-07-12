<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style>
	table {
		width: 100%;
	}
	td {
		width: 14%;
		height: 60px;
		text-align: center;
	}
</style>
<script>
	function redirectToToday() {
		var url = "${pageContext.request.contextPath}/match/matchReg.ma?userId=${loginMember.userId}&day=";
		
		window.location.href = url;
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div id="nav2">
	<div id="matching"></div>
	<div id="matching"></div>
	<div id="gym"><a onclick="redirectToToday();">매치 등록</a></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/match/matchList.ma">상대방 찾기</a></div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>