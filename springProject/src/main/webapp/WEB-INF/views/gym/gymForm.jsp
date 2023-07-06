<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/gym/gym.css">
	<jsp:include page="/WEB-INF/views/common/header.jsp">
      <jsp:param value="${gym.gymCoach}님 체육관 정보" name="title" />
  	</jsp:include>

<div style="display: flex; justify-content: center;">
	<form>
		<h1>${gym.gymCoach}님 체육관 정보</h1>
	<!-- 체육관정보 리스트 테이블 -->
		<table class="container" style="float:left;" id="table1">
		<tr>
			<th>계약 고유번호</th>
			<td>${gym.gymNo}</td>
		</tr>
		<tr>
			<th>계약일</th>
			<td>${gym.gymRegdate}</td>
		</tr>		
		<tr>
			<th>사업자 번호</th>
			<td>${gym.businessNo}</td>
		</tr>
		<tr>
			<th>체육관 이름</th>
			<td>${gym.gymName}</td>
		</tr>
		<tr>
			<th>종목</th>
			<td>					
				<c:if test="${gym.gymType eq 'taek'}">
					태권도
				</c:if> 
				<c:if test="${gym.gymType eq 'grap'}">
					잡기류
				</c:if> 
				<c:if test="${gym.gymType eq 'striker'}">
					킥복싱류
				</c:if> 
				<c:if test="${gym.gymType eq 'box'}">
					복싱
				</c:if>
			</td>
		</tr>
		<tr>
			<th>대표자 이름</th>
			<td>${gym.gymBoss}</td>
		</tr>
		<tr>
			<th>매치 수</th>
			<td>${gym.matchCount}</td>
		</tr>
	</table>
		
	<div style="width: 50px; float: left;"></div>
		
	<table class="container" style="float:right;" id="table2">
		<tr>
			<th>체육관 번호</th>
			<td>${gym.gymPhone}</td>
		</tr>
		<tr>
			<th>관장 이름</th>
			<td>${gym.gymCoach}</td>
		</tr>
		<tr>
			<th>관장 번호</th>
			<td>${gym.coachPhone}</td>
		</tr>
		<tr>
			<th>체육관 우편번호</th>
			<td>${gym.gymZipcode}</td>
		</tr>
		<tr>
			<th>체육관 주소</th>
			<td>${gym.gymAddress}</td>
		</tr>
		<tr>
			<th>체육관 상세주소</th>
			<td>${gym.gymDetailaddress}</td>
		</tr>
		<tr>
			<th>은행명</th>
			<c:if test="${gym.gymBank == null}">
				<td>은행명을 입력해주세요</td>
			</c:if>
			<c:if test="${gym.gymBank != null}">
				<td>${gym.gymBank}</td>
			</c:if>
		</tr>
		<tr>
			<th>계좌</th>
			<c:if test="${gym.gymAccount == null || gym.gymAccount == 0}">
				<td>계좌번호를 입력해주세요</td>
			</c:if>
			<c:if test="${gym.gymAccount != null and gym.gymAccount != 0}">
				<td>${gym.gymAccount}</td>
			</c:if>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="button" onclick="gymUpdate(${gym.gymNo});">수정하기</button>
				&emsp;
				<button type="button" onclick="javascript:history.back()">뒤로가기</button>
			</td>
		</tr>
	</table>
	</form>	
</div>


<!-- 버튼을 누르면 수정하는 페이지로 가는 스크립트 -->
<script>
	function gymUpdate(gymNo) {
		location.href='${pageContext.request.contextPath}/gym/gymUpdate.gym?gymNo='+gymNo;
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
