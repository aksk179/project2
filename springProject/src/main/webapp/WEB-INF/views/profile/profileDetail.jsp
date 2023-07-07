<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문서</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profileEnroll.css">
  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  
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
	width: 68%;
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

#gymType {
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

    </style>
</head>

<body>
    <div class="form" align="center">
        <form action="${pageContext.request.contextPath}/profile/profileUpdate.pr" method="post" name="proInfofrm" enctype="multipart/form-data">
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
                        <input type="hidden" id="userId" name="userId" value="${profileMember.userId}" readonly>
                        <input type="text" id="proNick" name="proNick" value="${profileMember.proNick}" readonly style="background-color: #eeeeee; color: gray;">
                    <!--    <input type="button" id="nickc" value="중복확인" onclick="nickCheck();"> -->
                    </td>
                </tr>
			
                <!-- 주종목 -->
                <tr>
                    <th>주종목</th scope="col">
                    <td scope="col">
                        <input type="text" id="proMajor" name="proMajor" value="${profileMember.proMajor}" readonly style="background-color: #eeeeee; color: gray;">
                    </td>
                </tr>

                <!-- 급수 -->
                <tr>
                    <th scope="col"><label for="level">급수</label></th>
                    <td scope="col"><input type="text" id="proLevel" name="proLevel" value="${profileMember.proLevel}"required></td>
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
                    <td scope="col">승 : ${profileMember.win} 회 &emsp;패 : ${profileMember.lose} 회</td>
                </tr>
            </table>

            <!-- 기타 정보 -->
            <table border="1" class="table2">
                <tr>
                    <th scope="col"  width="80px">키</th>
                    <td scope="col"><input type="text" id="height" name="proHeight" value="${profileMember.proHeight}" required> cm</td>
                    <th scope="col">몸무게</th>
                    <td scope="col"><input type="text" id="weight" name="proWeight" value="${profileMember.proWeight}" required> kg</td>
                </tr>
                <tr>
                    <th colspan="4" scope="col">개인대회</th>
                </tr>
                <tr>
                    <td colspan="4" scope="col">
                    <textarea class="textarea" name="personal" cols="35" rows="10">${profileMember.personal}</textarea>
                    </td>
                </tr>
                <tr>
					<th colspan="4">건강상태</th>
				</tr>
				<tr>
					<td colspan="4"><textarea class="textarea" name="note"
							cols="35" rows="10">${profileMember.note}</textarea></td>
				</tr>
                <tr>
                    <td colspan="4">
                        <button type="submit">수정</button>
                        <button type="reset">취소</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
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
	
	
</script>
</html>
