<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/match/myMatch.css?v=<%=System.currentTimeMillis()%>">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div id="myMatch">
   <div id="upperStuff">
      <div id="view">
         <input type="button" value="내등록" onclick="myReg('${loginMember.userId}');">
         <input type="button" value="내도전" onclick="myChal('${loginMember.userId}');">
         <input type="button" value="성사중인 내등록" onclick="waitingRegPay('${loginMember.userId}');">
         <input type="button" value="성사중인 내도전" onclick="waitingChalPay('${loginMember.userId}');">
      </div>
   </div>
<div id="myGame">
   <div id="table">
      <table>
         <thead>
            <tr>
               <th width="10%">날짜</th>
               <th width="10%">시간</th>
               <th width="30%">장소</th>
               <th width="15%">내상대</th>
               <th width="15%">상태</th>
               <th width="10%">관리</th>
            </tr>
         </thead>
         <tbody>
               <c:forEach var="myMatch" items="${myMatch}">
                  <tr>
                     <td>${myMatch.matchdatestring}</td>
                     <td>${myMatch.matchtime}</td>
                     <td>${myMatch.gymAddress}<br>${myMatch.gymDetailaddress}</td>
                     <c:choose>
                     	<c:when test="${myMatch.matchStatus == 3}">
                     		<c:choose>
                     			<c:when test="${loginMember.userId == myMatch.userId1}">
                     				<td>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.userId2}"><span class="nickName3">${myMatch.challenger1Nick}</span></a>
	                    			</td>
                     			</c:when>
                     			<c:otherwise>
                     				<td>
                     					<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.userId1}"><span class="nickName3">${myMatch.proNick}</span></a>
                     				</td>
                     			</c:otherwise>
                     		</c:choose>
	                    </c:when>
                     	<c:when test="${myMatch.userId1 == loginMember.userId}">
	                    	<td>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger1 != null &&
	                    			                myMatch.challenger2 != null &&
	                    			                myMatch.challenger3 != null &&
	                    			                myMatch.challenger4 != null &&
	                    			                myMatch.challenger5 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger1}"><span class="nickName">${myMatch.challenger1Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="${pageContext.request.contextPath}/alarm/acceptMatch.al">수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger1}','${loginMember.userId}');">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger2}"><span class="nickName">${myMatch.challenger2Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="${pageContext.request.contextPath}/alarm/acceptMatch.al">수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger2}','${loginMember.userId}');">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger3}"><span class="nickName">${myMatch.challenger3Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="${pageContext.request.contextPath}/alarm/acceptMatch.al">수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger3}','${loginMember.userId}');">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger4}"><span class="nickName">${myMatch.challenger4Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="${pageContext.request.contextPath}/alarm/acceptMatch.al">수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger4}','${loginMember.userId}');">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger5}"><span class="nickName">${myMatch.challenger5Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="${pageContext.request.contextPath}/alarm/acceptMatch.al">수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger5}','${loginMember.userId}');">거절</button></span>
	                    			</c:when>
	                    			<c:when test="${myMatch.challenger1 == null &&
	                    			                myMatch.challenger2 == null &&
	                    			                myMatch.challenger3 == null &&
	                    			                myMatch.challenger4 == null &&
	                    			                myMatch.challenger5 == null}">
	                    			  	<span class="nickName2">상대없음</span>
	                    			</c:when>
	                    			<c:otherwise>
	                    				<c:choose>
	                    			<c:when test="${myMatch.challenger1 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger1}"><span class="nickName">${myMatch.challenger1Nick}</span></a>
	                    				<span class="nickNameButton"><button>수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger1}','${loginMember.userId}');">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
	                    			</c:otherwise>
	                    		</c:choose>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger2 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger2}"><span class="nickName">${myMatch.challenger2Nick}</span></a>
	                    				<span class="nickNameButton"><button>수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger2}','${loginMember.userId}');">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
	                    			</c:otherwise>
	                    		</c:choose>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger3 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger3}"><span class="nickName">${myMatch.challenger3Nick}</span></a>
	                    				<span class="nickNameButton"><button>수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger3}','${loginMember.userId}');">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
	                    			</c:otherwise>
	                    		</c:choose>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger4 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger4}"><span class="nickName">${myMatch.challenger4Nick}</span></a>
	                    				<span class="nickNameButton"><button>수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger4}','${loginMember.userId}');">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
                    				</c:otherwise>
                    			</c:choose>
                    			<c:choose>
	                    			<c:when test="${myMatch.challenger5 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger5}"><span class="nickName">${myMatch.challenger5Nick}</span></a>
	                    				<span class="nickNameButton"><button>수락</button>&ensp;<button onclick="chalCancelFromMe('${myMatch.no}','${myMatch.challenger5}','${loginMember.userId}');">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
                    				</c:otherwise>
                    			</c:choose>
	                    			</c:otherwise>
	                    		</c:choose>
	                    	</td>
	                    </c:when>
	                    <c:when test="${myMatch.userId2 == loginMember.userId}">
	                    	<td>
	                    		<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.userId1}"><span class="nickName2">${myMatch.proNick}</span></a>
	                    	</td>
	                    </c:when>
                     </c:choose>
                     <td>
                     	<c:choose>
                     		<c:when test="${myMatch.matchStatus == 1}">
                     			매칭중
                     		</c:when>
                     		<c:when test="${myMatch.matchStatus == 3}">
                     			매치성사전
                     		</c:when>
                     		<c:when test="${myMatch.matchStatus == 4}">
                     			매치성사
                     		</c:when>
                     		<c:when test="${myMatch.matchStatus == 5}">
                     			매치종료
                     		</c:when>
                     	</c:choose>
                     </td>
                     <td>
                     	<c:choose>
                     		<c:when test="${myMatch.matchStatus == 3}">
                     			<button id="challengeButton">결제</button>
                     		</c:when>
                     		<c:otherwise>
                     			<c:choose>
						  <c:when test="${empty loginMember.userId}">
						    <button id="challengeButton" onclick="challenge('${myMatch.userId}', '${loginMember.userId}', '${loginMember.userStatus}', '${myMatch.no}', '${myMatch.matchdatestring}', '${myMatch.matchtime}', '${myMatch.gymName}', '${myMatch.proNick}');">도전신청</button>
						  </c:when>
						  <c:otherwise>
						    <c:choose>
						      <c:when test="${not empty myMatch && myMatch.userId1 == loginMember.userId}">
						        <button id="challengeButton" onclick="regCancel('${myMatch.matchNo}', '${myMatch.userId1}', '${loginMember.userId}', '${loginMember.userStatus}');" style="background-color:tomato">등록취소</button>
						      </c:when>
						      <c:when test="${not empty myMatch &&
						                        (myMatch.challenger1 == loginMember.userId ||
						                         myMatch.challenger2 == loginMember.userId ||
						                         myMatch.challenger3 == loginMember.userId ||
						                         myMatch.challenger4 == loginMember.userId ||
						                         myMatch.challenger5 == loginMember.userId)}">
						       <button id="challengeButton" onclick="chalCancel('${myMatch.no}', '${loginMember.userId}');" style="background-color:pink">도전취소</button>
						
						      </c:when>
						      <c:otherwise>
						        <button id="challengeButton" onclick="challenge('${myMatch.userId}', '${loginMember.userId}', '${loginMember.userStatus}', '${myMatch.no}', '${myMatch.matchdatestring}', '${myMatch.matchtime}', '${myMatch.gymName}', '${myMatch.proNick}');">도전신청</button>
						      </c:otherwise>
						    </c:choose>
						  </c:otherwise>
						</c:choose>
                     		</c:otherwise>
                     	</c:choose>
                        
                     </td>
                  </tr>
               </c:forEach>
         </tbody>
      </table>
   </div>   
</div>
   <nav aria-label="Page navigation example">
      <ul class="pagination justify-content-center">
         <c:if test="${pi.nowPage ne 1}">
            <li class="page-item">
               <a class="page-link" href="${pageContext.request.contextPath}/match/myMatch.ma?nowPage=${pi.nowPage-1}&${filterType}=${filterTypeValue}">Previous&emsp;</a>
            </li>
         </c:if>
         <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
            <c:choose>
               <c:when test="${p eq pi.nowPage}">
                  <li class="page-item active">
                     <a class="page-link" href="${pageContext.request.contextPath}/match/myMatch.ma?nowPage=${p}&${filterType}=${filterTypeValue}">&emsp;${p}&emsp;</a>
                  </li>
               </c:when>
               <c:otherwise>
                  <li class="page-item">
                     <a class="page-link" href="${pageContext.request.contextPath}/match/myMatch.ma?nowPage=${p}&${filterType}=${filterTypeValue}">&emsp;${p}&emsp;</a>
                  </li>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         <c:if test="${ pi.nowPage ne pi.totalPage }">
            <li class="page-item">
               <a class="page-link" href="${pageContext.request.contextPath}/match/myMatch.ma?nowPage=${pi.nowPage+1}&${filterType}=${filterTypeValue}">Next</a>
            </li>
         </c:if>
      </ul>
   </nav>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
<script>
function regCancel(matchNo, userId1, userId, userStatus) {
   const url = "${pageContext.request.contextPath}/match/regCancel.ma?matchNo=" + matchNo + "&userId1=" + userId1 + "&from=myMatch"
   location.href = url;
    
}
 
 function chalCancel(no, userId) {
        let userId2 = userId;
        const url = "${pageContext.request.contextPath}/match/chalCancel.ma?no=" + no + "&userId2=" + userId2 + "&from=myMatch"
        location.href = url;
}
 
 function chalCancelFromMe(no, userId, loginUserId) {
     let userId2 = userId;
     const url = "${pageContext.request.contextPath}/match/chalCancelFromMe.ma?no=" + no + "&userId2=" + userId2 + "&from=myMatch" + "&loginUserId=" + loginUserId
     location.href = url;
}
 
function myReg(userId) {
	const userId1 = userId;
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId1=" + userId1
	location.href = url;
} 
function myChal(userId) {
    const userId2 = userId;
    const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId2=" + userId2
    location.href = url;
}

function waitingRegPay(userId3) {
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId3=" + userId3
    location.href = url;
}

function waitingChalPay(userId4) {
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId4=" + userId4
    location.href = url;
}
</script>
</html>