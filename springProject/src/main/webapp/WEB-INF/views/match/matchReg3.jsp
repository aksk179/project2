<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b1a1baddfc194b964c714fcbe3f6d1aa&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/match/matchReg.css?v=<%=System.currentTimeMillis()%>">

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div id="nav2">
	<div id="matching"></div>
	<div id="matching"></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/match/matchReg.ma">매치 등록</a></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/match/matchList.ma">상대방 찾기</a></div>
</div>

<div>
	<table>
		<c:forEach items="${selectAlarmList}" var="alarm">
		<tr>
	        <td>${alarm.alarmMsg}</td>
			<td>
				<button type="button" style="align:right;">수락</button>
				<button type="button" style="align:right;">거절</button>	
			</td>				
		</tr>
		</c:forEach>
	</table>
</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>