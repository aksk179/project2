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
		/*width: 14%;
		height: 60px;*/
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


<div>
	<table border="1">
		<tr>
			<th>알람시간</th>
			<th>알람내용</th>
			<th>비고</th>
		</tr>
		<c:forEach items="${selectAlarmList}" var="alarm" varStatus = "d">
			<c:if test="${alarm.alarmStatus eq 1}">
			<tr>
				<td>${alarm.alarmTime}</td>
				<td>${alarm.alarmMsg}</td>
				<td>
					<button type="button" onclick="">수락</button>
					<button type="button" onclick="">거절</button>
				</td>
			</tr>
			</c:if>
			<c:if test="${alarm.alarmStatus eq 0}">
			<tr>
				<td>${alarm.alarmTime}</td>
				<td>${alarm.alarmMsg}</td>
				<td></td>
			</tr>
			</c:if>
		</c:forEach>
	</table>
</div>

</body>
</html>