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
/* $(document).ready(function check_today(indexs, weeks, dates){
    if(dates > today_days){
        //인덱스가 오늘의 날짜보다 크다면(미래: 일정 추가 가능)
        weeks[indexs].style.backgroundColor = '#FFEFD5'; //CSS 불러오기
    } else if(dates == today_days){
         //인덱스가 오늘의 날짜와 같다면(현재: 일정 추가 가능)
         weeks[indexs].style.backgroundColor = '#DB7093'; //CSS 불러오기
    } else if(dates < today_days){
        //인덱스가 오늘의 날짜보다 작다면(지나온 날: 일정 추가 불가)
        weeks[indexs].style.backgroundColor = 'gray'; //CSS 불러오기
    } */
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