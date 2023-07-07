<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
	<footer>
		<p>
	     상호명 : 빈체로<br>
	     대표자 : 김정민<br>
	     개인정보관리책임자 : 방승환<br>
	     상담전화 : 02-1234-1234<br>
	     이메일주소 : contact@vincero.com <br>
	     사업자번호 : 789-81-77777
	    </p>
	    <ul class="f">
	        <li><a href="#">법적고지</a></li>
	        <li><a href="#">개인정보취급방침</a></li>
	        <li><a href=""${pageContext.request.contextPath}/common/">개인정보처리방침</a></li>
	    </ul>    
    	<ul class="sns">
     		<li><a href="https://www.instagram.com/vincero2023/">인스타그램</a></li>
			<li><a href="https://www.youtube.com/channel/UCV61-dCRehTcS8lduckYrxw">유튜브</a></li>
    	</ul>
	</footer>
</body>
</html>