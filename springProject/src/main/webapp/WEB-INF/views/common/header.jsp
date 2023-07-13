<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<c:if test="${not empty msg}">
	<script type="text/javascript">
		alert('${msg}');
	</script>
</c:if>
</head>
<body>
<div id="nav1">
	<div id="logo"><a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="logo" width="200px" height="90px"></a></div>
	<div id="member"><img src="${pageContext.request.contextPath}/resources/img/alarm.png" alt="alarm" id="alarm" width="40px" onClick="popOpen();"></div>
	<div id="member"><a href="${pageContext.request.contextPath}/member/GoLoginPage.me"><img src="${pageContext.request.contextPath}/resources/img/member.png" alt="member" width="40px" height="40px"></a></div>
</div>
<div id="nav2">
	<div id="matching"><a href="${pageContext.request.contextPath}/match/matchList.ma">매칭</a></div>
	<div id="ranking"><a href="${pageContext.request.contextPath}/ranking/rankingList.ra">랭킹</a></div>
	<div id="league"><a href="${pageContext.request.contextPath}/league/leagueList.le">대회</a></div>
	<div id="vincero"><a href="${pageContext.request.contextPath}/support/support.su">고객지원</a></div>
</div>

<div id="wrap"></div>
    
<div class="modal-bg" onclick="popClose();"></div>
<div class="modal-wrap-title">
	<table width="100%">
		<thead>
			<tr>
				<th>시간</th>
				<th>메시지</th>
				<th><button type="button" style="align:right;" class="modal-close" onClick="popClose()">X</button></th>
			</tr>
		</thead>
	</table>
</div>
<div class="modal-wrap">
	<table>
		<tbody id="header_pop_up">
			
		</tbody>
	</table>
</div>
<script>
	let checkAlarmId;
	
	$(document).ready(function(){
	    checkAlarmId = setInterval(checkAlarmAjax, 10000); // 1초 간격으로 마지막 데이터 이후 입력 시	        
	}); 
	
	//새로운 알람 있는지 체크 있으면 이미지 변경
	function checkAlarmAjax(){
	    $.ajax({
	        url: "${pageContext.request.contextPath}/alarm/checkAlarm.al",
	        type: "POST",
	        cache: false,
	        async: false,
	        success: function(data){
	            if(0 < data) {
	            	console.log(data);
	                $("#alarm").attr("src", "${pageContext.request.contextPath}/resources/img/alarm_up.png");
	            } else {
	            	console.log("새로 들어온 값이 없어");
	            }
	        },
	        error : function(xhr, status, error) {
				clearInterval(checkAlarmId);
				alert(status);
				console.log(status);
			}
	    });
	}
	
	var alarmList = [];
	
	//데이터 읽어와서 팝업창에 뿌려주기
	function readAlarmAjax() {
	    $.ajax({
	        url: "${pageContext.request.contextPath}/alarm/read.al",
	        method: "POST",
	        dataType: "json",
	        contentType: "application/json",
	        cache: false,
	        async: false,
	        success: function(data) {
	        	console.log(data);
	        	console.log(data[0].alarmMsg);
	        	console.log(data.length);
	        	
		        for(let i=0; i<data.length; i++) {     
		        	if(data[i].readYn == 'N') {
			        	var alarm = {};
			        	
			        	alarm.alarmNo = data[i].alarmNo;
			        	alarmList.push(alarm);		        		
		        	}
		        	
					let content = $("#header_pop_up").html();
		        	console.log(content);									
						content += "<tr>"
								+ 	"<td>" + data[i].alarmTime + "</td>"
								+   "<td>" + data[i].alarmMsg + "</td>";
							if(data[i].alarmStatus == 0) {
						content	+= 	"<td>"
								+	"</td>";
							} else if(data[i].alarmStatus == 1) {
						content	+= 	"<td>"
								+		"<button type='button' style='align:right;' onclick='pay(`"+ data[i].no +"`);'>결제</button>"
								+	"</td>"	;
							} else if(data[i].alarmStatus == 2) {						
						content	+= 	"<td>"
								+		"<button type='button' style='align:right;' onclick='accept(`"+ data[i].no +"`);'>수락</button>"
								+		"<button type='button' style='align:right;' onclick='reject(`"+ data[i].no +"`);'>거절</button>"
								+	"</td>"		;					
							}
						content	+=  "</tr>";
					console.log("content에 있는 내용 : " + content);
					$("#header_pop_up").html(content);
					//document.getElementById("pop-up").value = content;
	        	}
	        	console.log("아아");
	        	console.log(alarmList);
	        },
	        error : function(xhr, status, error) {
				clearInterval();
				//alert();
				console.log(status);
			}
	    });
	}
	
	//팝업창 열기
	function popOpen() {
		var modalPopTitle = $('.modal-wrap-title');
		var modalPop = $('.modal-wrap');
		var modalBg = $('.modal-bg');
		
		$(modalPopTitle).show();
		$(modalPop).show();
		$(modalBg).show();
		readAlarmAjax();
		//window.open('${pageContext.request.contextPath}/alarm/readAlarm.al','win0','width=500,height=300,status=no,toolbar=0,scrollbars=yes,location=0,titlebar=0');
	}
	
	//팝업창 닫기 누르면 이미지 다시 바뀜
	function popClose() {	
		var modalPopTitle = $('.modal-wrap-title');	
		var modalPop = $('.modal-wrap');
		var modalBg = $('.modal-bg');

		$(modalPopTitle).hide();
	    $(modalPop).hide();
	    $(modalBg).hide();
		$("#alarm").attr("src", "${pageContext.request.contextPath}/resources/img/alarm.png");
		$("#header_pop_up").html("");	  
		
		console.log("popClose() : " + JSON.stringify(alarmList));
		readYnUpdate();
	}	
	
	//닫기 누르면 readYn=Y로 바꿔주고, 팝업창 비워주기
	function readYnUpdate() {
		$.ajax({
			url: "${pageContext.request.contextPath}/alarm/readYnUpdate.al",
			type: "post",
			data:  JSON.stringify(alarmList),
			dataType: "JSON",
	        contentType : "application/json",
			success : function(data, status, xhr) {
				console.log(data.result);
				alarmList = [];
			},
			error : function(xhr, status, error) {
				alert(status);
			}
		});
	}
	
	//수락 버튼
	function accept(no) {
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
			},
			error : function(xhr, status, error) {
				alert(status);
			}
		});
	}
	
	//거절 버튼
	function reject() {
		
	}
	
	//결제 버튼
	function pay() {
		
	}

</script>
