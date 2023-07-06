<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.spring.gym.model.vo.Gym, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/manager/mnGym.css">
<script
   src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>   
	<jsp:include page="/WEB-INF/views/common/header.jsp">
      <jsp:param value="no.${gym.gymNo}&ensp;체육관의 정보 수정" name="title" />
  	</jsp:include>

<div style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
	<!-- 체육관정보 리스트 테이블 -->
	<form name="frm" method="post" action="${pageContext.request.contextPath}/manager/mnGymUpdate.mn">
	<h1>no.${gym.gymNo}&ensp;체육관 정보 수정</h1>
	<table>
		<tr>
			<th>계약 고유번호</th>
			<th>계약일</th>
			<th>사업자 번호</th>
			<th>대표자 이름</th>
			<th>체육관 이름</th>
			<th>종목</th>
			<th>매치 수</th>
			<th>체육관상태</th>
			<th>사유</th>
			<th>ID 상태</th>
			<th>관장 ID</th>
		</tr>
			<tr align="center">
				<td>
					<input type="text" style="border:0 solid black;width:70px;" id="gymNo" name="gymNo" value="${gym.gymNo}" readonly>
				</td>
				<td>
					<input type="date" id="gymRegdate" name="gymRegdate" style="width:130px;" value="${gym.gymRegdate}">
				</td>
				
				<td>
					<input type="text" id="businessNo" name="businessNo" style="width:140px;" value="${gym.businessNo}">
				</td>
				<td>
					<input type="text" id="gymBoss" name="gymBoss" style="width:90px;" value="${gym.gymBoss}">
				</td>
				<td>
					<input type="text" id="gymName" name="gymName" style="width:140px;" value="${gym.gymName}">
				</td>
				<td>
					<select name="gymType" style="width:90px;">
						<option value="taek" ${gym.gymType eq 'taek' ? 'selected' : '' }>태권도</option>
						<option value="grap" ${gym.gymType eq 'grap' ? 'selected' : '' }>잡기류</option>
						<option value="striker" ${gym.gymType eq 'striker' ? 'selected' : '' }>킥복싱류</option>
						<option value="box" ${gym.gymType eq 'box' ? 'selected' : '' }>복싱</option>
					</select>
				</td>
				<td>
					<input type="text" id="matchCount" name="matchCount" style="width:60px;" value="${gym.matchCount}">
				</td>
				<td>
					<select name="gymStatus" onchange="handleGymStatusChange(this)">
						<option value=0 ${gym.gymStatus eq 0 ? 'selected' : '' }>가맹신청</option>
						<option value=1 ${gym.gymStatus eq 1 ? 'selected' : '' }>심사중</option>
						<option value=2 ${gym.gymStatus eq 2 ? 'selected' : ''   }>계약체결</option>
						<option value=3 ${gym.gymStatus eq 3 ? 'selected' : '' }>계약실패</option>
						<option value=4 ${gym.gymStatus eq 4 ? 'selected' : '' }>계약해지</option>
					</select>
				</td>
				<td>
					<!-- gymStatus의 값이 4로 저장되어있으면 reason <input>태그의 타입을 date로 보여지게 -->
					<input type="${gym.gymStatus eq 4 ? 'date' : 'text'}" id="reason" name="reason" value="${gym.reason}" ${gym.gymStatus eq 3 || gym.gymStatus eq 4 ? '' : 'disabled'}>
				</td>
				<td>
					<c:if test="${gym.gymStatus ne 2}">
						일반
					</c:if>
					<c:if test="${gym.gymStatus eq 2}">
						관장님
					</c:if>
				</td>
				<td>
					<c:if test="${gym.userId == null}">
					</c:if>
					<c:if test="${gym.userId != null}">
						${gym.userId}
						<input type="hidden" id="userId" name="userId" value="${gym.userId}">
					</c:if>
				</td>
			</tr>
	</table>
	
	<div id="btnmem">
		<button type="button" style="width:80px" onclick="javascript:history.back()">목록으로</button>
		<button type="button" style="width:110px" onclick="gymToggle()">상세정보 보기</button>
		<button type="reset" style="width:80px" >원래대로</button>
		<button type="submit" style="width:80px">수정완료</button>
	</div>

	
	<div style="margin-bottom: 10px;"></div>
	
	<!--  체육관 상세보기 -->
	<h1 id="gymH1" style="display: none;">no.${gym.gymNo}&ensp;체육관 상세정보 수정</h1>
	<table id="gymTable" style="display: none;">
		<tr>
			<th>관장 이름</th>
			<th>관장 번호</th>
			<th>체육관 우편번호</th>
			<th>체육관 주소</th>
			<th>체육관 상세주소</th>
			<th>체육관 번호</th>
			<th>은행명</th>
			<th>계좌</th>
		</tr>
		<tr>
			<td>
				<input type="text" id="gymCoach" name="gymCoach" style="width:90px;" value="${gym.gymCoach}">
			</td>
			<td>
				<input type="text" id="coachPhone" name="coachPhone" style="width:140px;" value="${gym.coachPhone}">
			</td>
			<td>
				<input type="text" id="gymZipcode" name="gymZipcode" style="width:80px;" value="${gym.gymZipcode}">
				<button onclick="findAddr();">찾기</button>
			</td>
			<td>
				<input type="text" id="gymAddress" name="gymAddress" style="width:210px;" value="${gym.gymAddress}" readonly>
			</td>
			<td>
				<input type="text" id="gymDetailaddress" name="gymDetailaddress" style="width:210px;" value="${gym.gymDetailaddress}">
			</td>
			<td>
				<input type="text" id="gymPhone" name="gymPhone" style="width:140px;" value="${gym.gymPhone}">
			</td>
			<td>
				<input type="text" id="gymBank" name="gymBank" style="width:100px;" value="${gym.gymBank}">
			</td>
			<td>
				<input type="text" id="gymAccount" name="gymAccount" style="width:140px;" value="${gym.gymAccount}">
			</td>
		</tr>
	</table>
</form>
</div>


<!-- 체육관 상태에 대한 스크립트 -->
<script>
	function handleGymStatusChange(selectElement) {
		var reasonInput = document.getElementById('reason');
		var selectedValue = selectElement.value;
		
		// 계약실패(3) 또는 계약해지(4)를 선택하였을때 사유입력란이 활성화되도록 하는 스크립트
	    if (selectedValue === '3' || selectedValue === '4') {
	        reasonInput.disabled = false; // 비활성화를 false함
	      } else {
	        reasonInput.disabled = true; // 비활성화를 true함
	      }
		
		// 계약해지(4)를 선택하였을때 <input>태그 타입이 날짜로 변경되게 하는 스크립트
		if (selectedValue === '4') {
		  reasonInput.type = 'date'; // 계약해지(4)로 들어와서 if문이 true면 date타입으로 
		  							 // date형식으로 날짜를 입력받지만 DB에 reason은 varchar2이므로 String으로 저장됨
		} else {
		  reasonInput.type = 'text'; // 그외의 값으로 들어와서 if문이 false면 text타입으로 
		}

	}
</script>

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

<!-- 상세정보가 보여지거나 숨기게 하는 스크립트 -->
<script>
	document.addEventListener("DOMContentLoaded", function() {
	    var button = document.getElementById("gymButton");
	    button.style.display = "none"; // 버튼을 숨김으로 설정
	  });


  function gymToggle() {
    var table = document.getElementById("gymTable");
    var button = document.getElementById("gymButton");
    var h1 = document.getElementById("gymH1");
    
    if (table.style.display === "none") {
      table.style.display = "table";
      button.style.display = "inline";
      h1.style.display = "block"; // h1 요소를 나타나게 함
    } else {
      table.style.display = "none";
      button.style.display = "none";
      h1.style.display = "none"; // h1 요소를 숨김
    }
  }
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />


