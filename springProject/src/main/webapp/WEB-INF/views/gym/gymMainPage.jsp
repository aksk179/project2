<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/manager/mnGym.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="체육관 정보 리스트" name="title" />
</jsp:include>

<div id="nav2">
	<div id="gym"><a href="${pageContext.request.contextPath}/gym/gymForm.gym?gymNo=${gym.gymNo}">나의 체육관 정보</a></div>
	<div id="matching"></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/gym/gymCalendar.gym">일정 관리</a></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/gym/gymView.gym">사용자 통계</a></div>
</div>

<div style="display: flex; justify-content: center;">
	<form>
	<h1>내 체육관 경기</h1>
	<!-- 내 체육관 경기 리스트 테이블 -->
	<table class="table">
		<tr>
			<th>일정</th>
			<th>시간</th>
			<th>영상 업로드</th>
			<th>신청자1</th>
			<th>매치 관리</th>
			<th>신청자2</th>
		</tr>

		<c:forEach items="${matchList}" var="gymMatch">
			<tr align="center">
				<td>${gymMatch.matchdate}</td>
				<td>${gymMatch.matchtime}</td>
				<td><button type="button">영상 업로드</button></td>
				<td>${gymMatch.proNick}</td>
				<td><button type="button" target="_blank" onclick="openProfile('${gymMatch.userId1}', '${gymMatch.userId2}');">매치 관리</button></td>
				<td>${gymMatch.proNick2}</td>
			</tr>
		</c:forEach>	
	</table>
	</form>
</div>

<!-- 페이지 코드 -->
	<nav>
		<ul>
			<!-- 1페이지면 이전버튼이 활성화되지않도록 if문 추가 -->
			<c:if test="${pi.nowPage eq 1}">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/gym/gymMainPage.gym?nowPage=${pi.nowPage}" >이전</a>
				</li>
			</c:if>
			<c:if test="${pi.nowPage ne 1}">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/gym/gymMainPage.gym?nowPage=${pi.nowPage-1}" >이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
				<c:choose>
					<c:when test="${p eq pi.nowPage}">
						<li class="page-item active">
							<a class="page-link" href="${pageContext.request.contextPath}/gym/gymMainPage.gym?nowPage=${p}">${p}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/gym/gymMainPage.gym?nowPage=${p}">${p}</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 마지막 페이지면 다음버튼이 활성화되지않도록 if문 추가 -->
			<c:if test="${ pi.nowPage eq pi.totalPage }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/gym/gymMainPage.gym?nowPage=${pi.nowPage}">다음</a>
				</li>
			</c:if>	
			<c:if test="${ pi.nowPage ne pi.totalPage }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/gym/gymMainPage.gym?nowPage=${pi.nowPage+1}">다음</a>
				</li>
			</c:if>
		</ul>
	</nav>

<script>
	function openProfile(userId1, userId2){		
		window.open("${pageContext.request.contextPath}/profile/profileDetailTwice.pr?userId1="+userId1+"&userId2="+userId2, "_blank", "width=1100px, height=600px top=50px left=200px");
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />