<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/gym/gym.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp">
      <jsp:param value="${gym.gymCoach}님 체육관 정보수정" name="title" />
  	</jsp:include>

<div style="display: flex; justify-content: center;">
	<form name="gymFrm" method="post" action="${pageContext.request.contextPath}/gym/gymUpdate.gym">
			<h1>${gym.gymCoach}님 체육관 정보수정</h1>
	<!-- 체육관정보 리스트 테이블 -->
		<table class="container" style="float:left;" id="table1">
			<tr>
				<th>계약 고유번호</th>
				<td width="30px">${gym.gymNo}</td>
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
				<td>
					<input type="text" id="gymPhone" name="gymPhone" value="${gym.gymPhone}">
				</td>
			</tr>
			<tr>
				<th>관장 이름</th>
				<td>
					<input type="text" id="gymCoach" name="gymCoach" value="${gym.gymCoach}">
				</td>
			</tr>
			<tr>
				<th>관장 번호</th>
				<td>
					<input type="text" id="coachPhone" name="coachPhone" value="${gym.coachPhone}">
				</td>
			</tr>
			<tr>
				<th>체육관 우편번호</th>
				<td>
					<input type="text" id="gymZipcode" name="gymZipcode" style="float:left;" value="${gym.gymZipcode}">
					<button style="float:left;margin-left:15px;" onclick="findAddr();">찾기</button>
				</td>
			</tr>
			<tr>
				<th>체육관 주소</th>
				<td>
					<input type="text" id="gymAddress" name="gymAddress" value="${gym.gymAddress}" readonly>
				</td>
			</tr>
			<tr>
				<th>체육관 상세주소</th>
				<td>
					<input type="text" id="gymDetailaddress" name="gymDetailaddress" value="${gym.gymDetailaddress}" >
				</td>
			</tr>
			<tr>
				<th>은행명</th>
				<td>
					<input type="text" id="gymBank" name="gymBank" value="${gym.gymBank}">
				</td>
			</tr>
			<tr>
				<th>계좌</th>
				<td>
					<input type="text" id="gymAccount" name="gymAccount" value="${gym.gymAccount}">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">회원가입</button>
					&emsp;
					<button type="reset">초기화</button>
					&emsp;
					<button type="button" onclick="javascript:history.back()">뒤로가기</button>
				</td>
			</tr>
		</table>
		<!--  
		<div class="btn">
			<button type="submit">회원가입</button>
			&emsp;
			<button type="reset">초기화</button>
		</div>
		-->
	</form>
</div>
</body>


<!-- 체육관 주소설정 스크립트 -->
<script>
function findAddr() {
    new daum.Postcode({
        oncomplete: function (data) {
            let roadAddr = data.roadAddress;
            let jibunAddr = data.jibunAddress;
            let extraAddr = '';

            document.getElementById("gymZipcode").value = data.zonecode;

            if (data.userSelectedType == 'R') {
                if (roadAddr != '') {
                    if (data.bname != '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName != '') {
                        extraAddr += extraAddr != '' ? ', ' + data.buildingName : data.buildingName;
                    }
                    roadAddr += extraAddr != '' ? '(' + extraAddr + ')' : '';
                    document.getElementById("gymAddress").value = roadAddr;
                }
            } else if (data.userSelectedType == 'J') {
                document.getElementById("gymAddress").value = jibunAddr;
            }

            document.getElementById("gymDetailaddress").focus();
        }
    }).open();
}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
