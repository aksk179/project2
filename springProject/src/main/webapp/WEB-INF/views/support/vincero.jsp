<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support/vincero.css?v=<%=System.currentTimeMillis()%>">
</head>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<body>
   <a href="${pageContext.request.contextPath}/support/support.su">빈체로소개</a>
   <a href="${pageContext.request.contextPath}/gym/joinEnroll.gym">가맹점신청</a>
   <a href="${pageContext.request.contextPath}/support/noticeList.su">공지게시판</a>
   <a href="${pageContext.request.contextPath}/support/cusCenter.su">고객센터</a>
    <div class="logo">
        <div>
            <img class="img1" src="${pageContext.request.contextPath}/resources/img/logo.png">
        </div>
        <div>
            <h2 class="note1">빈체로(vincero)란 이탈리아어로 승리하다, 이길것이다 라는 뜻. <br><br>
                 즉, 대련을 통하여 원하는 목적을 얻고 승리하기를 원한다!</h2>
        </div>
    </div>
    <div class="howTo">
        <h1 style="margin-bottom: 40px;">HOW TO</h1>
        <img src="${pageContext.request.contextPath}/resources/img/flow.jpg">
    </div>
    <div class="logo">
        <h2 class="note2">싸움이 목적이 아닌 자신의 기술을 시험해보고 <br><br>
             대련을 통하여 자신의 수준을 평가하는 것이 목적이다.</h2> 
        <img class="img2" src="${pageContext.request.contextPath}/resources/img/kickboxing.jpg">
    </div>
    <div class="logo">
        <img class="img3" src="${pageContext.request.contextPath}/resources/img/taekwon.png">
        <h2 class="note3">대련을 목적으로 격투 기술을 연습하기 위한것으로  <br><br>
           부상을 만드는것이 아닌 안전성을 최우선으로 실행합니다.</h2>
    </div>
    <div class="logo">
        <h2  class="note4">보호장비를 착용하고 미리 정해진 규칙과 제한사항에 따라 진행!</h2>
        <img class="img4" src="${pageContext.request.contextPath}/resources/img/glove.png">
    </div>
</body>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</html>