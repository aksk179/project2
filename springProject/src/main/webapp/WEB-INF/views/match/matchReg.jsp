<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b1a1baddfc194b964c714fcbe3f6d1aa&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/match/matchReg.css?v=<%=System.currentTimeMillis()%>">

<style>
	table {
		width: 100%;
	}
	.dateform {
		width: 14%;
		height: 60px;
		text-align: center;
	}
	.pre {
		background-color: #BDBDBD;
		width: 14%;
		height: 60px;
		text-align: center;
	}
	td {
		text-align: center;
	}
</style>
<script>
	function dateFilter(day) {
		var url = "${pageContext.request.contextPath}/match/matchReg.ma?day="+day;
		
		window.location.href = url;
	}
</script>

<div id="nav2">
	<div id="matching"></div>
	<div id="matching"></div>
	<div id="gym"><a onclick="dateFilter('');">매치 등록</a></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/match/matchList.ma">상대방 찾기</a></div>
</div>

<div>
	<table border="1">
 		<tr>
		<c:forEach items="${dateFilter}" var="item" varStatus = "d">
			<c:if test="${item.day lt item.today}">
				<td class="pre">
					<span>${item.yoil}</span>
					<p>${item.date}</p>
				</td>
			</c:if>
			
			<c:if test="${item.day ge item.today}">
				<td class="dateform" id="dateFilter" onclick="dateFilter('${item.day}');">
					<a href="#map"></a>
					<span>${item.yoil}</span>
					<p>${item.date}</p>
				</td>
			</c:if>
			
			<c:if test="${d.index eq 6}">
				</tr>
				<tr>
			</c:if>
		</c:forEach>
		</tr>
	</table>
</div>


<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:70%; height:500px; float:left;"></div>
<div style="width:30%; height:500px; float:left;">
	<form>
		<table>
			<thead>
				<tr>
					<th colspan="4">삭제 후 등록버튼을 눌러주세요!</th>
				</tr>
				<tr>
					<th>체육관 이름</th>
					<th>매치 날짜</th>
					<th>매치 시간</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="register">
 			<c:forEach items="${inSchedList}" var="inSchedule">
				<tr id='${inSchedule.code}'>
			        <td>${inSchedule.gymName}</td>
			        <td>${inSchedule.matchdate}</td>
					<td>${inSchedule.time}</td>
					<td><button type="button" style="align:right;" onclick='deleteTime(`${inSchedule.code}`);'>삭제</button></td>				
				</tr>
			</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4"><button type="button" onclick="registerMatch();">등록하기</button></td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<script type="text/javascript">
	var clickedOverlay = null;
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(37.5231462, 126.9096533), // 지도의 중심좌표
	    level: 5 // 지도의 확대 레벨
	};
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
 	<c:forEach items="${markerOverlayList}" var="markerOverlay">
		var address = "${markerOverlay.gymAddress}";
		console.log(address);
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		console.log("주소-좌표 변환 객체 생성");
	
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch("${markerOverlay.gymAddress}", function(result, status) {
		console.log("주소-좌표 검색 함수");	
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
				console.log("검색 완료됐으면");
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        var marker = new kakao.maps.Marker({
			        map: map,
			        position: coords
			    });
			    
			    var overlay = new kakao.maps.CustomOverlay({		
			        yAnchor: 3,
			        position: marker.getPosition()
			    });
				console.log("overlay밑");
					
	
				var wrap = document.createElement('div');
				wrap.className = "wrap";
				
				var info = document.createElement('div');
				info.className = "info";
				
				wrap.appendChild(info);
				
				var title = document.createElement('div');
				title.className = "title";
				sometext = document.createTextNode("${markerOverlay.gymName}");
				
				title.appendChild(sometext);
				info.appendChild(title);
				
				var close = document.createElement('div');
				close.className = "close";
				close.title = "닫기";
				
				title.appendChild(close);
				
				var body = document.createElement('div');
				body.className = "body";
				info.appendChild(body);
				
				var imgDiv = document.createElement('div');
				imgDiv.className="img";
				body.appendChild(imgDiv);
				
				var img = document.createElement('img');
				img.className = "img";
				img.src = "/spring/resources/img/member.png";
				img.width = "73";
				img.height = "70";
				imgDiv.appendChild(img);
				
				var desc = document.createElement('div');
				desc.className = "desc";
				body.appendChild(desc);
				
				var ellipsis = document.createElement('div');
				ellipsis.className = "ellipsis";
				
				var text = document.createTextNode("${markerOverlay.gymAddress}");
				
				ellipsis.appendChild(text);
				
				desc.appendChild(ellipsis);
				
				/////////////////////////////////////////////////////////////////
				var jibun = document.createElement('div');
				jibun.className = "jibun-ellipsis";
				
				var text2 = document.createTextNode("${markerOverlay.gymDetailAddress}");
				console.log("text2까지 옴");
				
				jibun.appendChild(text2);
				
				desc.appendChild(jibun);
				
				var footerDev = document.createElement('div');
				desc.appendChild(footerDev);

							
				<c:forEach items="${markerOverlay.matchTimeList}" var="time" varStatus="status">
					var link${status.index} = document.createElement('a');
					link${status.index}.className = "link";
					
					var text${status.index} = document.createTextNode("${time} ");

					link${status.index}.href = "javascript:setMarkerOverlay('${markerOverlay.gymNo}', '${markerOverlay.gymName}', '${markerOverlay.codeList[status.index]}', '${markerOverlay.matchdateList[status.index]}', '${markerOverlay.matchdayList[status.index]}', '${time}')";				
					link${status.index}.appendChild(text${status.index});
					
					footerDev.appendChild(link${status.index});	
					<c:if test="${status.index eq 4}">						
						var footerDev = document.createElement('div');
						desc.appendChild(footerDev);
					</c:if>
				</c:forEach>
								
				console.log("커스텀오버레이 다 그림");	
				console.log("오버레이 띄워줘");
				
				overlay.setContent(wrap);
				
				kakao.maps.event.addListener(marker, 'click', function() {
					if(clickedOverlay) {
						clickedOverlay.setMap(null);
					}
			        overlay.setMap(map);
			        clickedOverlay = overlay;
			    });
				
				close.onclick = function() {
					overlay.setMap(null);
				}
			}
		}); 
	</c:forEach>
		
	////////////////////////////////////////////////////////////////////////	
		
		var matchList = [];
	
		<c:forEach items="${inSchedList}" var="inSchedule">
			var codeValue = {};
			
			codeValue.code = '${inSchedule.code}';
			codeValue.value = 'N';	
			codeValue.gymNo = '${inSchedule.gymNo}';
			codeValue.matchday = '${inSchedule.matchday}';
			codeValue.matchtime = '${inSchedule.time}';
			
			matchList.push(codeValue);
		</c:forEach>
		
		console.log("matchList....");
		console.log(matchList);
		
		function setMarkerOverlay(gymNo, gymName, code, matchdate, matchday, time) {
			console.log(gymNo, gymName, code, matchdate, matchday, time);
			//if문으로 담았는지 조건 체크해야 함
			//없으면 담아주고, 화면에 띄우기
			//있으면 alert창 경고
	
			//matchList에 코드가 있고 vlaue가 N이면 이미 담겨 있는 모양이니까 담겨있다고 alert. 
			if(matchList.some(data => data.code == code && data.value == "N")) {
				alert("이미 담겨있습니다.");
			} else {									
				let content = $("#register").html();
					content += "<tr id='"+ code + "'>"
							+ 	"<td>" + gymName + "</td>"
							+   "<td>" + matchdate + "</td>"
							+   "<td>" + time + "</td>"
							+ 	"<td><button type='button' style='align:right;' onclick='deleteTime(`"+ code +"`);'>삭제</button></td>"
							+  "</tr>";
								
				console.log("content에 있는 내용 : " + content);
				
				//document.getElementById("register").value = content;
				$("#register").html(content);
				
				console.log("table안에 들어갈 내용 : " + content);
				
				//matchList에 이미 담겨있는 코드이면
				if(matchList.some(data => data.code == code)) {
					//코드 찾아서(ex."user01202306250900"   elementIndex 변수에 담고
					elementIndex = matchList.findIndex((obj => obj.code == code));
					//ex)"user01202306250900"의 value가 Y인 거를 N으로 바꾸기 --> 다시 담기
					matchList[elementIndex].value = "N";
				//matchList에 담겨있지 않은 코드면
				} else {
					// 새로 만들어
					var codeValue = {};
					codeValue.code = code;
					codeValue.value = "N";	
					codeValue.gymNo = gymNo;
					codeValue.matchday = matchday;
					codeValue.matchtime = time;
					matchList.push(codeValue);
				}
				console.log(matchList);
			}
		}
		
		function deleteTime(code) {
			console.log(code);
			$("#"+code).remove();
			//matchList.map((item) => item.code === code ? { ...item, value: "Y"} : item);
			
			elementIndex = matchList.findIndex((obj => obj.code == code));	
			console.log("Before update: ", matchList[elementIndex]);
			matchList[elementIndex].value = "Y";
			
			console.log(matchList);
		}

		function registerMatch() {
			console.log(matchList);
 			$.ajax({
				url: "${pageContext.request.contextPath}/match/register.do?userId=${loginMember.userId}",
				type: "post",
				data:  JSON.stringify(matchList),
				dataType: "JSON",
		        contentType : "application/json",
				success : function(data, status, xhr) {
					console.log(data);
					alert(data.msg);
				},
				error : function(xhr, status, error) {
					alert(status);
				}
			});
		}
	</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
