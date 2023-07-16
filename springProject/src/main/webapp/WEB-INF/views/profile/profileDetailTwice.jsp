<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profileEnroll.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  
<style>
/* 개별 스타일 */
#imgThumb {
	width: 100px;
	height: 100px;
}

#nickc {
	font-size: small;
	text-decoration: none;
}

.btn_file input[type="file"] {
	display: none;
}

/* 추가 스타일링 */
.table1, .table2 {
	border-collapse: collapse;
}

input[type="text"], input[type="file"] {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	outline: none;
	transition: border-color 0.3s;
}

.table1 th, .table1 td, .table2 th, .table2 td {
	border: 1px solid #ccc;
	padding: 10px;
}

.table1 th, .table2 th {
	background-color: #f2f2f2;
}

.textarea {
	width: 100%;
	height: 200px;
	resize: none;
}

input#proLevel {
	width: 163px;
}

input#height {
	width: 100px;
}

input#weight {
	width: 100px;
}

#warnType {
	width: 163px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	outline: none;
	transition: border-color 0.3s;
}
button[type="submit"], button[type="reset"], button[type="button"] {
	padding: 10px 20px;
	background-color: #c8220f;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 10px;
	transition: background-color 0.3s;
}
input#proMajor {
    width: 163px;
}

#schedule {
	display: flex;
	flex-direction: column;
	margin-top: 30px;
	align-items: center;
}

#section {
	display: flex;
	flex-direction: row;
	justify-content: center;
}

#container {
	display: flex;
	flex-direction: column;
	align-items: center;
	font-family: 'EF_watermelonSalad';
	margin-top: 30px;
	margin-right: 100px;
}

button#bt {
	background-color: gray;
}
</style>
<form name="gameOver" action="${pageContext.request.contextPath}/match/gameOver.ma" method="post">
	<div id="section">
	    <div id="container">
            <table border="1" class="table1">
                <!-- 닉네임 -->
                <tr>
                    <th rowspan="3" scope="col">
                        <div class="profile_photo">
                           <a><img src="${pageContext.request.contextPath}/resources/upload/profile/${profileMember.changeFilename}" width="150" height="150"></a>
                        </div>
                    </th>
                    <th scope="col">닉네임</th>
                    <td>
                        <input type="hidden" id="userId" name="userId" value="${profile1.userId}" readonly>
                        <input type="text" id="proNick" name="proNick" value="${profile1.proNick}" readonly>
                    <!--    <input type="button" id="nickc" value="중복확인" onclick="nickCheck();"> -->
                    </td>
                </tr>
			
                <!-- 주종목 -->
                <tr>
                    <th>주종목</th scope="col">
                    <td scope="col">
                        <input type="text" id="proMajor" name="proMajor" value="${profile1.proMajor}" readonly>
                    </td>
                </tr>

                <!-- 급수 -->
                <tr>
                    <th scope="col"><label for="level">급수</label></th>
                    <td scope="col"><input type="text" id="proLevel" name="proLevel" value="${profile1.proLevel}" readonly></td>
                </tr>

                <!-- 프로필 사진 -->
                <tr>
                    <th scope="col">
                        <div>
                            <span class="btn_file">
                                <input type="file" id="file" name="upFile">
                                <div id="filepointer">
                                    <label></label>
                                </div>
                            </span>
                        </div>
                    </th>
                    <th scope="col">전적</th>
                    <td scope="col">승 : ${profile1.win} 회 &emsp;패 : ${profile1.lose} 회</td>
                </tr>
            </table>

            <!-- 기타 정보 -->
            <table border="1" class="table2">
                <tr>
                    <th scope="col"  width="80px">키</th>
                    <td scope="col"><input type="text" id="height" name="proHeight" value="${profile1.proHeight}" readonly> cm</td>
                    <th scope="col">몸무게</th>
                    <td scope="col"><input type="text" id="weight" name="proWeight" value="${profile1.proWeight}" readonly> kg</td>
                </tr>
                <tr>
                    <th colspan="4" scope="col">개인대회</th>
                </tr>
                <tr>
                    <td colspan="4" scope="col">
                    <textarea class="textarea" name="personal" cols="35" rows="10">${profile1.personal}</textarea>
                    </td>
                </tr>
                <tr>
					<th colspan="4">건강상태</th>
				</tr>
				<tr>
					<td colspan="4"><textarea class="textarea" name="note"
							cols="35" rows="10" readonly>${profile1.note}</textarea></td>
				</tr>
                <tr>
                    <td colspan="4">
						<button type="button" onclick="javascript:history.back()">취소</button>
                    </td>
                </tr>
            </table>
    </div>

<!-- ============================================================================================================================ -->

	<div id="schedule">
            <table border="1" class="table1">
                <!-- 닉네임 -->
                <tr>
                    <th rowspan="3" scope="col">
                        <div class="profile_photo">
                           <a><img src="${pageContext.request.contextPath}/resources/upload/profile/${profile2.changeFilename}" width="150" height="150"></a>
                        </div>
                    </th>
                    <th scope="col">닉네임</th>
                    <td>
                        <input type="hidden" id="userId" name="userId" value="${profile2.userId}" readonly>
                        <input type="text" id="proNick" name="proNick" value="${profile2.proNick}" readonly>
                    <!--    <input type="button" id="nickc" value="중복확인" onclick="nickCheck();"> -->
                    </td>
                </tr>
			
                <!-- 주종목 -->
                <tr>
                    <th>주종목</th scope="col">
                    <td scope="col">
                        <input type="text" id="proMajor" name="proMajor" value="${profile2.proMajor}" readonly>
                    </td>
                </tr>

                <!-- 급수 -->
                <tr>
                    <th scope="col"><label for="level">급수</label></th>
                    <td scope="col"><input type="text" id="proLevel" name="proLevel" value="${profile2.proLevel}"required></td>
                </tr>

                <!-- 프로필 사진 -->
                <tr>
                    <th scope="col">
                        <div>
                            <span class="btn_file">
                                <input type="file" id="file" name="upFile">
                                <div id="filepointer">
                                    <label for="file">클릭하여 사진첨부</label>
                                </div>
                            </span>
                        </div>
                    </th>
                    <th scope="col">전적</th>
                    <td scope="col">승 : ${profile2.win} 회 &emsp;패 : ${profile2.lose} 회</td>
                </tr>
            </table>

            <!-- 기타 정보 -->
            <table border="1" class="table2">
                <tr>
                    <th scope="col"  width="80px">키</th>
                    <td scope="col"><input type="text" id="height" name="proHeight" value="${profile2.proHeight}" required> cm</td>
                    <th scope="col">몸무게</th>
                    <td scope="col"><input type="text" id="weight" name="proWeight" value="${profile2.proWeight}" required> kg</td>
                </tr>
                <tr>
                    <th colspan="4" scope="col">개인대회</th>
                </tr>
                <tr>
                    <td colspan="4" scope="col">
                    <textarea class="textarea" name="personal" cols="35" rows="10">${profile2.personal}</textarea>
                    </td>
                </tr>
                <tr>
					<th colspan="4">건강상태</th>
				</tr>
				<tr>
					<td colspan="4"><textarea class="textarea" name="note"
							cols="35" rows="10">${profile2.note}</textarea></td>
				</tr>
				<tr>
					<th scope="col" colspan="4" width="80px" style="background-color: black; color: white;">🥋🥋매치 종료 후 결과 입력해주세요!🥊🥊</th>
				</tr>
				<tr>
					<th scope="col" width="80px" height="48px">경고주기</th>
                    <td scope="col" colspan="3">
    					<label><input type="checkbox" name="none" value="0">없음</label>&nbsp;
    					<label><input type="checkbox" name="fuck" value="1">욕설</label>&nbsp;
    					<label><input type="checkbox" name="late" value="2">지각</label>&nbsp;
    					<label><input type="checkbox" name="against" value="3">룰위반</label>&nbsp;
    					<label><input type="checkbox" name="bmanner" value="4">기타비매너</label>&nbsp;
	                </td>
				</tr>
				<tr>
					<th scope="col" colspan="2" width="80px">경기결과</th> 
					<td colspan="2">
						<button type="button" id="bt1" value="win" onclick="setResultValue('win')">승</button>
						<button type="button" id="bt2" value="lose" onclick="setResultValue('lose')">패</button>
					</td>
				</tr>    
            </table>
	    </div>
	</div>
<div align="center">
	<table>
    	 <tr>
            <td>
            <button type="button" onclick="gameOver();">경기종료</button>
            <button type="button" onclick="javascript:history.back();">취소</button>
            </td>
        </tr>
    </table>
</div>
</form>


<script type="text/javascript">
	function nickChecka() {
	  $.ajax({
	       url: "${pageContext.request.contextPath}/profile/nick.ch",
	       data : {nicka : $("#proNick").val()},	      
           success(result) {
                 console.log(result);

           const {proNick, available} = result;
           console.log(result);
           
           if(available) {
              
              $("#messageNick").text("멋진 닉네임이네요 !");
              document.getElementById("nickc").addEventListener("focusout", () => {
                  const inputNick = document.getElementById("proNick").value;
                  let messageId = document.getElementById("messageNick");
                  const regExp1 = /^[a-zA-Z][a-zA-Z0-9]{2,12}$/;

                  if (regExp1.test(inputNick)) {
                      nickCheck = true;
                  } else if (inputNick === " ") {
                      messageNick.innerHTML = "필수 정보입니다.";
                      nickCheck = false;
                  } else {
                      messageNick.innerHTML = "한글, 영문자, 숫자 포함 총 2~6자로 입력하시오.";
                      nickCheck = false;
                  }
              })

              nickdCheck = true;
              
              $("#nickbtncheck").val("nickCheck");
           } else {
              $("#messageNick").text("이미 사용중인 닉네임입니다");
              nickdCheck = false;
              $("#nickbtncheck").val("nickUncheck");
           }
        },
        error : console.log
	   });
	}
	
	function inputNickChk() {
		regFrm.nickbtncheck.value = "nickUncheck";
	}
	
	let resultValue = null;
	
	function setResultValue(value) {
	  	resultValue = value;
	}
	
	document.getElementById('resultForm').onsubmit = function() {
	   	// 값 전송 버튼을 누를 때 숨겨진 input 태그에 선택한 값을 설정합니다.
	   	document.getElementById('resultValue').value = resultValue;
	};

	function gameOver() {	
		gameOver.submit();
	}
	
</script>
