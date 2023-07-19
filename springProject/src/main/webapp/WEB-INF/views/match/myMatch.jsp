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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div id="myMatch">
   <div id="upperStuff">
      <div id="view">
         <input type="button" value="등록경기" onclick="myReg('${loginMember.userId}');">
         <input type="button" value="도전경기" onclick="myChal('${loginMember.userId}');">&emsp;<hr>&emsp;
         <input type="button" value="성사중 내등록" onclick="waitingRegPay('${loginMember.userId}');">
         <input type="button" value="성사중 내도전" onclick="waitingChalPay('${loginMember.userId}');">&emsp;<hr>&emsp;
         <input type="button" value="성사된 내등록" onclick="afterRegPay('${loginMember.userId}');">
         <input type="button" value="성사된 내도전" onclick="afterChalPay('${loginMember.userId}');">&emsp;<hr>&emsp;
         <input type="button" value="종료된 내등록" onclick="afterRegEnd('${loginMember.userId}');">
         <input type="button" value="종료된 내도전" onclick="afterChalEnd('${loginMember.userId}');">
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
                     	<c:when test="${myMatch.matchStatus == 3 || myMatch.matchStatus == 4 || myMatch.matchStatus == 5}">
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
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger1No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger1No}')">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger2}"><span class="nickName">${myMatch.challenger2Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger2No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger2No}')">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger3}"><span class="nickName">${myMatch.challenger3Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger3No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger3No}')">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger4}"><span class="nickName">${myMatch.challenger4Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger4No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger4No}')">거절</button></span><br><br>
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger5}"><span class="nickName">${myMatch.challenger5Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger5No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger5No}')">거절</button></span>
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
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger1No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger1No}')">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
	                    			</c:otherwise>
	                    		</c:choose>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger2 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger2}"><span class="nickName">${myMatch.challenger2Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger2No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger2No}')">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
	                    			</c:otherwise>
	                    		</c:choose>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger3 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger3}"><span class="nickName">${myMatch.challenger3Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger3No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger3No}')">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
	                    			</c:otherwise>
	                    		</c:choose>
	                    		<c:choose>
	                    			<c:when test="${myMatch.challenger4 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger4}"><span class="nickName">${myMatch.challenger4Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger4No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger4No}')">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
                    				</c:otherwise>
                    			</c:choose>
                    			<c:choose>
	                    			<c:when test="${myMatch.challenger5 != null}">
	                    				<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.challenger5}"><span class="nickName">${myMatch.challenger5Nick}</span></a>
	                    				<span class="nickNameButton"><button onclick="accept('${myMatch.challenger5No}');">수락</button>&ensp;<button onclick="reject('${myMatch.challenger5No}')">거절</button></span><br><br>
	                    			</c:when>
	                    			<c:otherwise>
                    				</c:otherwise>
                    			</c:choose>
	                    			</c:otherwise>
	                    		</c:choose>
	                    	</td>
	                    </c:when>
	                    <c:otherwise>
	                    	<td>
	                    		<a href="${pageContext.request.contextPath}/profile/profileDetail.pr?userId=${myMatch.userId1}"><span class="nickName2">${myMatch.proNick}</span></a>
	                    	</td>
	                    </c:otherwise>
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
                     			종료된매치
                     		</c:when>
                     	</c:choose>
                     </td>
                     <td>
                     	<c:choose>
                     		<c:when test="${myMatch.matchStatus == 5}">
                     			<c:choose>
                     				<c:when test="${myMatch.userId1 == loginMember.userId}">
                     					<c:choose>
                     						<c:when test="${myMatch.score1 == 1}">
                     							<span style="color:blue; font-size:15px">승리</span>
                     						</c:when>
                     						<c:otherwise>
                     							<span style="color:red; font-size:15px">패배</span>
                     						</c:otherwise>
                     					</c:choose>
                     				</c:when>
                     				<c:when test="${myMatch.userId2 == loginMember.userId}">
                     					<c:choose>
                     						<c:when test="${myMatch.score1 == 0}">
                     							<span style="color:blue; font-size:15px">승리</span>
                     						</c:when>
                     						<c:otherwise>
                     							<span style="color:red; font-size:15px">패배</span>
                     						</c:otherwise>
                     					</c:choose>
                     				</c:when>
                     			</c:choose>
                     		</c:when>
                     		<c:when test="${myMatch.matchStatus == 4}">
                     			<button id="challengeButton" onclick="openBankBackModal()">매치취소</button>
                     		</c:when>
                     		<c:when test="${myMatch.matchStatus == 3}">
                     			<c:choose>
                     				<c:when test="${myMatch.user1Paystatus == 1 && loginMember.userId == myMatch.userId1}">
                     					<button id="challengeButton" style="background-color:red;" onclick="refund('${myMatch.no}');">환불</button>
                     				</c:when>
                     				<c:when test="${myMatch.user2Paystatus == 1 && loginMember.userId == myMatch.userId2}">
                     					<button id="challengeButton" style="background-color:red;" onclick="refund('${myMatch.no}');">환불</button>
                     				</c:when>
                     				<c:otherwise>
                     					<button id="challengeButton" onclick="pay('${myMatch.no}')">결제</button>
                     				</c:otherwise>
                     			</c:choose>
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
                     </td>
                  </tr>
               </c:forEach>
         </tbody>
      </table>
      <!-- Mobile Back Modal -->
      <div id="mobileBackModal" class="modal">
          <div class="modal-content">
              <h3>폰결제환불</h3>
              <div class="button-row">
                  <button onclick="location.href='${pageContext.request.contextPath}/match/p_mobileBack.py'" class="button">폰 결제 환불</button>
              </div>
          </div>
      </div>
      <!-- Bank Back Modal -->
      <div id="bankBackModal" class="modal">
          <div class="modal-content">
              <h3>계좌이체환불</h3>
              <div class="button-row">
                  <button onclick="location.href='${pageContext.request.contextPath}/match/p_bankRefund?no=${myMatch.no}" class="button">계좌 이체 환불</button>
              </div>
          </div>
      </div>
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

function afterRegPay(userId5) {
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId5=" + userId5
    location.href = url;
}

function afterChalPay(userId6) {
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId6=" + userId6
    location.href = url;
}

function afterRegEnd(userId7) {
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId7=" + userId7
    location.href = url;
}

function afterChalEnd(userId8) {
	const url = "${pageContext.request.contextPath}/match/myMatch.ma?userId8=" + userId8
    location.href = url;
}

	     //수락 버튼
	   	function accept(no) {		
	   		console.log(no);
	   		var accept = {};
	   		accept.no = no;

	   		$.ajax({
	   			url: "${pageContext.request.contextPath}/alarm/acceptMatch.al",
	   			type: "post",
	   			data: JSON.stringify(accept),
	   			dataType: "JSON",
	   	        contentType : "application/json",
	   			success : function(data, status, xhr) {
	   				console.log(data.result);
	   				alert(data.msg);
	   				readAlarmAjax();
	   			},
	   			error : function(xhr, status, error) {
	   				alert(status);
	   			}
	   		});			
	   	}
	   	
	   	//거절 버튼
	function reject(no) {
		var reject = {};
		reject.no = no;

		$.ajax({
			url: "${pageContext.request.contextPath}/alarm/rejectMatch.al",
			type: "post",
			data: JSON.stringify(reject),
			dataType: "JSON",
	        contentType : "application/json",
			success : function(data, status, xhr) {
				console.log(data.result);
				alert(data.msg);
				readAlarmAjax();
			},
			error : function(xhr, status, error) {
				alert(status);
			}
		});			
	}
	
	//결제 버튼
	function pay(no) {
		var pay = {};
		pay.no = no;

		$.ajax({
			url: "${pageContext.request.contextPath}/match/payment.ma",
			type: "POST",
			data: JSON.stringify(pay),
			dataType: "JSON",
	        contentType : "application/json",
			success : function(data, status, xhr) {
				console.log(data.result);
				console.log(data.no);
	            window.location.href = "${pageContext.request.contextPath}/match/payment.ma?no="+data.no;
			},
			error : function(xhr, status, error) {
				alert(status);
			}
		});
    }
	
	function refund(no) {
		alert("안녕");
          if (!confirm("신청하시겠습니까?")) {
             alert("취소를 누르셨습니다.");
          } else {
        	  alert("환불을 신청하셨습니다.");
        	  
        	  var refund = {};
        	  refund.no = no;

      		  $.ajax({
      		 	url: "${pageContext.request.contextPath}/match/p_bankRefund.ma",
      		 	type: "GET",
      			data: JSON.stringify(refund),
      			dataType: "JSON",
      	        contentType : "application/json",
      			success : function(data, status, xhr) {
      				console.log(data.result);
      				console.log(data.no);
      			},
      			error : function(xhr, status, error) {
      				alert(status);
      			}
      		 }); 
          }
	}
	
	//결제 모달
	var paymentModal = document.getElementById("paymentModal");

	function openPaymentModal() {
        paymentModal.style.display = "block";
        document.addEventListener("click", closeModalOutsidePayment);
    }
	
	function closeModalOutsidePayment(event) {
        if (event.target === paymentModal) {
            paymentModal.style.display = "none";
            document.removeEventListener("click", closeModalOutsidePayment);
        }
    }

   
    var mobileBackModal = document.getElementById("mobileBackModal");

    function openMobileBackModal() {
        mobileBackModal.style.display = "block";
        document.addEventListener("click", closeModalOutsideMobileBack);
    }

    function closeModalOutsideMobileBack(event) {
        if (event.target === mobileBackModal) {
            mobileBackModal.style.display = "none";
            document.removeEventListener("click", closeModalOutsideMobileBack);
        }
    }
   
    var bankBackModal = document.getElementById("bankBackModal");

    function openBankBackModal() {
        bankBackModal.style.display = "block";
        document.addEventListener("click", closeModalOutsideBankBack);
    }

    function closeModalOutsideBankBack(event) {
        if (event.target === bankBackModal) {
            bankBackModal.style.display = "none";
            document.removeEventListener("click", closeModalOutsideBankBack);
        }
    }
</script>
</html>