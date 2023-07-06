<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support/publicEmergency.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="전국외상센터" name="title"/>
</jsp:include>
<div id="open-container" class="form-floating">
	<div id="title">
		<h2>전국외상센터</h2>
		<div id="select">
			<select id="location">
				<option value="서울특별시">서울특별시</option>
				<option value="경기">경기도</option>
				<option value="충청남도">충청남도</option>
				<option value="충청북도">충청북도</option>
				<option value="강원특별자치도">강원특별자치도</option>
				<option value="경상남도">경상남도</option>
				<option value="경상북도">경상북도</option>
				<option value="전라남도">전라남도</option>
				<option value="전라북도">전라북도</option>
				<option value="제주특별자치도">제주특별자치도</option>
			</select>
		</div>
		<button type="button" class="btn btn-outline-secondary" id="btn1">외상센터조회</button>
	</div>
	<table class="table" id="result1">
	<thead>
	<tr>
	<th scope="col">기관명</th>
	<th scope="col">주소</th>
	<th scope="col">대표전화</th>
	<th scope="col">응급실전화</th>
	</tr>
	</thead>
	<tbody>
	</tbody>
	</table>
</div>
</body>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector("#btn1").click();
});

document.querySelector("#btn1").addEventListener('click', (e) => {
$.ajax({
	url:"emergency.su",
	data: {location: $("#location").val()},
	success(data) {
		const itemArr = $(data).find("item");
		console.log(itemArr);
		let value = "";
		itemArr.each(function(i, item) {
			value += "<tr>"
				  + 	"<td>" + $(item).find("dutyName").text() + "</td>"
				  +		"<td>" + $(item).find("dutyAddr").text() + "</td>"
				  + 	"<td>" + $(item).find("dutyTel1").text() + "</td>"
				  + 	"<td>" + $(item).find("dutyTel3").text() + "</td>"
				  + "</tr>"
		})
		$("#result1 tbody").html(value);
	},
	error: console.log
});
});
</script>
</html>