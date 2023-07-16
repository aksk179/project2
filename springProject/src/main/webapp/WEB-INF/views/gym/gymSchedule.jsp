<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
const selectedBoxes = [];

function toggleSelection(checkbox) {
  var boxes = document.getElementsByClassName('box');

  for (var i = 0; i < boxes.length; i++) {
    if (checkbox.checked) {
      boxes[i].classList.add('selected');
      addBoxId(boxes[i].id);
    } else {
      boxes[i].classList.remove('selected');
      removeBoxId(boxes[i].id);
    }
  }
}

function selectBox(box) {
  box.classList.toggle('selected');

  if (box.classList.contains('selected')) {
    addBoxId(box.id);
  } else {
    removeBoxId(box.id);
  }
}

function addBoxId(boxId) {
  if (!selectedBoxes.includes(boxId)) {
    selectedBoxes.push(boxId);
  }
}

function removeBoxId(boxId) {
  var index = selectedBoxes.indexOf(boxId);
  if (index !== -1) {
    selectedBoxes.splice(index, 1);
  }
}

function getSelectedBoxIds() {
  const totalCodes = [];
  console.log(${ymd});
  const userId = "${loginMember.userId}";
  const ymd = ${ymd};
  console.log(ymd);
  console.log(selectedBoxes);
  console.log(selectedBoxes.length);
  console.log(selectedBoxes.at(1));
  console.log(totalCodes);
  for(let i=0; i<selectedBoxes.length; i++) {
	  totalCodes.push(userId+ymd+selectedBoxes.at(i).substring(8));
  }
  console.log(totalCodes);
  const url = "${pageContext.request.contextPath}/gym/scheduleReg.gym?userId=" + userId + "&totalCodes=" + totalCodes;
  location.href = url;
}

$(function () {
    const tmp = ${timeList};
    for(let i=0; i<tmp.length; i++) {
    	const tmp2 = document.getElementById(tmp.at(i));
    	$(tmp2).css("background-color","#EDE6D6");
    }
});

function delSelectedBoxIds() {
	  const totalCodes = [];
	  console.log(${ymd});
	  const userId = "${loginMember.userId}";
	  const ymd = ${ymd};
	  console.log(ymd);
	  console.log(selectedBoxes);
	  console.log(selectedBoxes.length);
	  console.log(selectedBoxes.at(1));
	  console.log(totalCodes);
	  for(let i=0; i<selectedBoxes.length; i++) {
		  totalCodes.push(userId+ymd+selectedBoxes.at(i).substring(8));
	  }
	  console.log(totalCodes);
	  const url = "${pageContext.request.contextPath}/gym/scheduleDel.gym?userId=" + userId + "&totalCodes=" + totalCodes;
	  location.href = url;
	  console.log(url);
}
</script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gym/calendar.css?v=<%=System.currentTimeMillis()%>">


</head>
<body>
<div id="schedule">
<h3>2. 등록하고 싶은 일정 시간을 선택하고 등록하세요<br>(베이지색은 이미 등록된 일정입니다)</h3>
<c:choose>
	<c:when test="${empty yi && empty mi && empty di}">
		<h3>달력에서 날짜를 선택해주세요</h3>
	</c:when>
	<c:otherwise>
		<h3>${yi} - ${mi} - ${di}</h3>
	</c:otherwise>
</c:choose>

<div id="box">
	<div>
		<div class="box" id="${ymd}0900" onclick="selectBox(this)">09:00 - 09:30</div>
		<div class="box" id="${ymd}0930" onclick="selectBox(this)">09:30 - 10:00</div>
		<div class="box" id="${ymd}1000" onclick="selectBox(this)">10:00 - 10:30</div>
		<div class="box" id="${ymd}1030" onclick="selectBox(this)">10:30 - 11:00</div>
		<div class="box" id="${ymd}1100" onclick="selectBox(this)">11:00 - 11:30</div>
		<div class="box" id="${ymd}1130" onclick="selectBox(this)">11:30 - 12:00</div>
	</div>
	<div>
		<div class="box" id="${ymd}1200" onclick="selectBox(this)">12:00 - 12:30</div>
		<div class="box" id="${ymd}1230" onclick="selectBox(this)">12:30 - 13:00</div>
		<div class="box" id="${ymd}1300" onclick="selectBox(this)">13:00 - 13:30</div>
		<div class="box" id="${ymd}1330" onclick="selectBox(this)">13:30 - 14:00</div>
		<div class="box" id="${ymd}1400" onclick="selectBox(this)">14:00 - 14:30</div>
		<div class="box" id="${ymd}1430" onclick="selectBox(this)">14:30 - 15:00</div>
	</div>
	<div>
		<div class="box" id="${ymd}1500" onclick="selectBox(this)">15:00 - 15:30</div>
		<div class="box" id="${ymd}1530" onclick="selectBox(this)">15:30 - 16:00</div>
		<div class="box" id="${ymd}1600" onclick="selectBox(this)">16:00 - 16:30</div>
		<div class="box" id="${ymd}1630" onclick="selectBox(this)">16:30 - 17:00</div>
		<div class="box" id="${ymd}1700" onclick="selectBox(this)">17:00 - 17:30</div>
		<div class="box" id="${ymd}1730" onclick="selectBox(this)">17:30 - 18:00</div>
	</div>
	<div>
		<div class="box" id="${ymd}1800" onclick="selectBox(this)">18:00 - 18:30</div>
		<div class="box" id="${ymd}1830" onclick="selectBox(this)">18:30 - 19:00</div>
		<div class="box" id="${ymd}1900" onclick="selectBox(this)">19:00 - 19:30</div>
		<div class="box" id="${ymd}1930" onclick="selectBox(this)">19:30 - 20:00</div>
		<div class="box" id="${ymd}2000" onclick="selectBox(this)">20:00 - 20:30</div>
		<div class="box" id="${ymd}2030" onclick="selectBox(this)">20:30 - 21:00</div>
	</div>
</div>
<div id="button">
	<button onclick="getSelectedBoxIds()">일정등록</button>
	<button onclick="delSelectedBoxIds()">일정취소</button>
</div>
</body>
</html>