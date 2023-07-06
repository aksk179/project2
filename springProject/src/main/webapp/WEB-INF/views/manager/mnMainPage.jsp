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
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
      <jsp:param value="관리자 페이지" name="title" />
  	</jsp:include>

<div id="nav2">
	<div id="gym"><a href="${pageContext.request.contextPath}/manager/mnGymList.mn">공지사항</a></div>
	<div id="gym"></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/manager/mnGymList.mn">체육관 정보조회</a></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/manager/mnMemberList.mn">회원 정보조회</a></div>
</div>

<div id="container">
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>