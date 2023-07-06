<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/manager/mnMember.css">
	<jsp:include page="/WEB-INF/views/common/header.jsp">
      <jsp:param value="회원 정보 리스트" name="title" />
  	</jsp:include>



	<!-- 검색필터 
	<form name="searchFrm" action="${pageContext.request.contextPath}/manager/mnMemberList.mn" method="post">
	  <select name="searchType">
	      <option value="userId">아이디</option>
	      <option value="userEmail">이메일</option>
	      <option value="userName">이름</option>
	      <option value="userGender">성별</option>
	      <option value="userType">타입</option>
	      <option value="userStatus">상태</option>
	      <option value="userRegdate">가입일</option>
	  </select>
	  
	  <input type="text" name="keyword" />
	  
	  <button type="submit">검색</button>
 	</form>
	-->
	
	<!-- 회원정보 리스트 테이블 -->
<div style="display: flex; justify-content: center;">
	<form>
	<h1>빈체로 회원 리스트</h1>
	<table class="table">
		<tr align="center">
			<th rowspan="2">아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>성별</th>
			<th>주소</th>
			<th>타입</th>
			<th>상태</th>
		</tr>
		<tr>
			<th>주민번호</th>
			<th>휴대폰 번호</th>
			<th>우편번호</th>
			<th>상세주소</th>
			<th>가입일</th>
			<th>통제기간</th>
		</tr>
		
		<c:forEach items="${memberList}" var="member">
			<tr>
				<td>${member.userId}<br><br><button type="button" onclick="mnMemberUpdate('${member.userId}');">수정하기</button></td>
				<td>${member.userName}<hr>${member.userRnn}</td>
				<td>${member.userEmail}<hr>${member.phone}</td>
				<td>${member.userGender}<hr>${member.zipcode}</td>
				<td>${member.address}<hr>${member.detailaddress}</td>
			<tr align="center">
				<td>${member.userId}<br><br><button onclick="mnMemberUpdate('${member.userId}');">수정하기</button></td>
				<td>${member.userRnn}</td>
				<td>${member.userName}</td>
				<td>${member.userGender}</td>
				<td>${member.userEmail}</td>
				<td>${member.phone}</td>
				<td>${member.zipcode}</td>
				<td>${member.address}</td>
				<td>${member.detailaddress}</td>
				<td>
					<c:if test="${member.userType eq 'admin'}">
						관리자
					</c:if> 
					<c:if test="${member.userType eq 'coach'}">
						관장님
					</c:if> 
					<c:if test="${member.userType eq 'user'}">
						일반
					</c:if> 
					<c:if test="${member.userType eq 'young'}">
						청소년
					</c:if>
					<hr>
					${member.userRegdate}
				</td> 
				<td>
					<c:if test="${member.userStatus eq 0}">
						탈퇴
					</c:if> 
					<c:if test="${member.userStatus eq 1}">
						회원가입
					</c:if> 
					<c:if test="${member.userStatus eq 2}">
						프로필
					</c:if> 
					<c:if test="${member.userStatus eq 4}">
						제재상태
					</c:if> 
					<hr>
					<c:if test="${member.userControl eq 0}">
					</c:if>
					<c:if test="${member.userControl eq 1}">
						7일
					</c:if> 
					<c:if test="${member.userControl eq 2}">
						30일
					</c:if> 
					<c:if test="${member.userControl eq 3}">
						60일
					</c:if> 
					<c:if test="${member.userControl eq 4}">
						100일
					</c:if> 
					<c:if test="${member.userControl eq 5}">
						무기한
					</c:if> 
				</td>
			</tr>
		</c:forEach>	
		
		<c:forEach items="${searchResults}" var="member">
			<tr align="center">
				<td>${member.userId}<br><br><button onclick="mnMemberUpdate('${member.userId}');">수정하기</button></td>
				<td>${member.userRnn}</td>
				<td>${member.userName}</td>
				<td>${member.userGender}</td>
				<td>${member.userEmail}</td>
				<td>${member.phone}</td>
				<td>${member.zipcode}</td>
				<td>${member.address}</td>
				<td>${member.detailaddress}</td>
				<td>
					<c:if test="${member.userType eq 'admin'}">
						관리자
					</c:if> 
					<c:if test="${member.userType eq 'coach'}">
						관장님
					</c:if> 
					<c:if test="${member.userType eq 'user'}">
						일반
					</c:if> 
					<c:if test="${member.userType eq 'young'}">
						청소년
					</c:if>
				</td> 
				<td>
					<c:if test="${member.userStatus eq 0}">
						탈퇴
					</c:if> 
					<c:if test="${member.userStatus eq 1}">
						회원가입
					</c:if> 
					<c:if test="${member.userStatus eq 2}">
						프로필
					</c:if> 
					<c:if test="${member.userStatus eq 4}">
						제재상태
					</c:if> 
				</td>
				<td>
					<c:if test="${member.userControl eq 0}">
					</c:if>
					<c:if test="${member.userControl eq 1}">
						7일
					</c:if> 
					<c:if test="${member.userControl eq 2}">
						30일
					</c:if> 
					<c:if test="${member.userControl eq 3}">
						60일
					</c:if> 
					<c:if test="${member.userControl eq 4}">
						100일
					</c:if> 
					<c:if test="${member.userControl eq 5}">
						무기한
					</c:if> 
				</td>
				<td>${member.userRegdate}</td>
			</tr>
		</c:forEach>	
	</table>
</div>
	
	<!-- 페이지 코드 -->
	<nav>
		<ul>
			<!-- 1페이지면 이전버튼이 활성화되지않도록 if문 추가 -->
			<c:if test="${pi.nowPage eq 1}">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/manager/mnMemberList.mn?nowPage=${pi.nowPage}" >이전</a>
				</li>
			</c:if>
			<c:if test="${pi.nowPage ne 1}">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/manager/mnMemberList.mn?nowPage=${pi.nowPage-1}" >이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
				<c:choose>
					<c:when test="${p eq pi.nowPage}">
						<li class="page-item active">
							<a class="page-link" href="${pageContext.request.contextPath}/manager/mnMemberList.mn?nowPage=${p}">${p}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/manager/mnMemberList.mn?nowPage=${p}">${p}</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<!-- 마지막 페이지면 다음버튼이 활성화되지않도록 if문 추가 -->
			<c:if test="${ pi.nowPage eq pi.totalPage }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/manager/mnMemberList.mn?nowPage=${pi.nowPage}">다음</a>
				</li>
			</c:if>	
			<c:if test="${ pi.nowPage ne pi.totalPage }">
				<li class="page-item">
					<a class="page-link" href="${pageContext.request.contextPath}/manager/mnMemberList.mn?nowPage=${pi.nowPage+1}">다음</a>
				</li>
			</c:if>
		</ul>
	</nav>
</form>


<!-- 수정하기버튼을 누르면 작동하는 스크립트 --> 
<script>
	function mnMemberUpdate(userId) {
		location.href='${pageContext.request.contextPath}/manager/mnMemberUpdate.mn?userId='+userId;
	}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />


