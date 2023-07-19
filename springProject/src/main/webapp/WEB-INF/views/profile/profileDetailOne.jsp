<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp" /> --%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile/profileDetailTwice.css">
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
	width: 460px;
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

input#proMajor {
    width: 163px;
}

#schedule {
	display: flex;
	flex-direction: column;
	margin-top: 10px;
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
	margin-top: 10px;
	margin-right: 100px;
}

</style>
<form name="gameOver" action="${pageContext.request.contextPath}/profile/gameOver.pr" method="post">
	<div id="section">
	    <div id="container">
            <table border="1" class="table1">
                <!-- 닉네임 -->
                <tr>
                    <th rowspan="3" scope="col">
                        <div class="profile_photo">
                           <a><img src="${pageContext.request.contextPath}/resources/upload/profile/${profile1.changeFilename}" width="150" height="150"></a>
                        </div>
                    </th>
                    <th scope="col">닉네임</th>
                    <td>
                        <input type="hidden" id="userId1" name="userId1" value="${profile1.userId}" readonly>
                        ${profile1.proNick}
                    </td>
                </tr>
			
                <!-- 주종목 -->
                <tr>
                    <th>주종목</th scope="col">
                    <td scope="col">${profile1.proMajor}</td>
                </tr>

                <!-- 급수 -->
                <tr>
                    <th scope="col"><label for="level">급수</label></th>
                    <td>${profile1.proLevel}</td>
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
                    <th width="20%">키</th>
                    <td width="30%">${profile1.proHeight} cm</td>
                    <th width="20%">몸무게</th>
                    <td width="30%">${profile1.proWeight} kg</td>
                </tr>
                <tr>
                    <th colspan="4">개인대회</th>
                </tr>
                <tr>
                    <td colspan="4" height="42px">${profile1.personal}</td>
                </tr>
                <tr>
					<th colspan="4">건강상태</th>
				</tr>
				<tr>
					<td colspan="4" height="42px">${profile1.note}</td>
				</tr>
				<tr>
					<th scope="col" colspan="4" width="80px" style="background-color: black; color: white;">🥋🥋매치 종료 후 결과 입력해주세요!🥊🥊</th>
				</tr>
				<tr>
					<th scope="col" width="80px" height="48px">경고주기</th>
                    <td scope="col" colspan="3">
    					<label><input type="checkbox" name="0" value="0">없음</label>&nbsp;
    					<label><input type="checkbox" name="user1Warn1" value="1">욕설</label>&nbsp;
    					<label><input type="checkbox" name="user1Warn2" value="1">지각</label><br>
    					<label><input type="checkbox" name="user1Warn3" value="1">룰위반</label>&nbsp;
    					<label><input type="checkbox" name="user1Warn4" value="1">기타비매너</label>&nbsp;
	                </td>
				</tr>
				<tr>
					<th scope="col" colspan="2" width="80px">경기결과</th> 
					<td colspan="2">
						<button type="button" id="winButton1" class="button2" value="1" name="resultValue1" onclick="setResultValue1('1')">승</button>
						<button type="button" id="loseButton1" class="button2" value="0" name="resultValue1" onclick="setResultValue1('0')">패</button>
						<input type="hidden" name="resultValue1" id="resultValue1">
					</td>
				</tr>  
            </table>
    </div>


<div align="center">
	<table>
    	 <tr>
            <td>
            <button type="submit" class="button1" id="gameOver">수락</button>
            <button type="button" class="button1" onclick="javascript:history.back();">거절</button>
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
	
	let resultValue1 = null;
	function setResultValue1(value) { 
		resultValue1 = value;
		if (value === 1) {
		    document.getElementById('winButton1').classList.add('red');
		    document.getElementById('loseButton1').classList.remove('red');
		    document.getElementById('winButton2').classList.remove('red');
		    document.getElementById('loseButton2').classList.add('red');
		} else if (value === 1) {
		    document.getElementById('winButton1').classList.remove('red');
		    document.getElementById('loseButton1').classList.add('red');
		    document.getElementById('winButton2').classList.add('red');
		    document.getElementById('loseButton2').classList.remove('red');
		}
		console.log(resultValue1);			
	};
	
	let resultValue2 = null;
	function setResultValue2(value) {
		resultValue2 = value;
		if (value === 1) {
		    document.getElementById('winButton2').classList.add('red');
		    document.getElementById('loseButton2').classList.remove('red');
		    document.getElementById('winButton1').classList.remove('red');
		    document.getElementById('loseButton1').classList.add('red');
		} else if (value === 1) {
		    document.getElementById('winButton2').classList.remove('red');
		    document.getElementById('loseButton2').classList.add('red');
		    document.getElementById('winButton1').classList.add('red');
		    document.getElementById('loseButton1').classList.remove('red');
		}
		console.log(resultValue2);
	};
	
	document.getElementById("gameOver").addEventListener("click", function() {		
		console.log(gameOver);
		document.getElementById("resultValue1").value = resultValue1;
	    document.getElementById("resultValue2").value = resultValue2;			    
	    
		document.gameOver.submit();
		alert("매치 기록이 기록되었습니다.");
		window.close();
	});
	
</script>
