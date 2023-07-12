<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Calendar" %>
<%
    request.setCharacterEncoding("utf-8");

    Calendar cal = Calendar.getInstance();
    int y = cal.get(Calendar.YEAR);
    int m = cal.get(Calendar.MONTH) + 1;
    int d = cal.get(Calendar.DATE);
    
    String _y = request.getParameter("y");
    String _m = request.getParameter("m");
    
    if (_y != null) y = Integer.parseInt(_y);
    if (_m != null) m = Integer.parseInt(_m);

    cal.set(y, m - 1, 1);
    y = cal.get(Calendar.YEAR);
    m = cal.get(Calendar.MONTH) + 1;

    int startDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    int daysInMonth = cal.getActualMaximum(Calendar.DATE);

    String[] weekDays = { "일", "월", "화", "수", "목", "금", "토" };
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gym/calendar.css?v=<%=System.currentTimeMillis()%>">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="일정캘린더" name="title"/>
</jsp:include>

<div id="nav2">
	<div id="gym"><a href="${pageContext.request.contextPath}/gym/gymUpdateForm.gym">체육관 정보 수정</a></div>
	<div id="matching"></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/gym/gymCalendar.gym">일정 관리</a></div>
	<div id="gym"><a href="${pageContext.request.contextPath}/gym/gymView.gym">사용자 통계</a></div>
</div>
<div id="section">
<div id="container">
	<h3>1. 먼저 체육관 예약을 받고싶은 날짜부터 달력에서 클릭하세요 &emsp;-></h3>
        <table>
            <caption>
                <select id="y" onchange="changeDate();">
                    <% for (int i = y - 5; i <= y + 5; i++) { %>
                        <option value="<%= i %>" <%= y == i ? "selected" : "" %>><%= i %>년</option>
                    <% } %>
                </select>
                <select id="m" onchange="changeDate();">
                    <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= i %>" <%= m == i ? "selected" : "" %>><%= i %>월</option>
                    <% } %>
                </select>
            </caption>
            <tr height="70px">
                <% for(int i=0; i<7; i++) { %>
                    <td width="80px" bgcolor="#EDE6D6" align="center">
                        <font color="<%= i == 0 ? "red" : (i == 6 ? "blue" : "black") %>">
                            <%= weekDays[i] %>
                        </font>
                    </td>
                <% } %>
            </tr>
            	<%
                   int dayOfMonth = 1;
                   int rowIndex = 0;
                   while(dayOfMonth <= daysInMonth) {
                      out.println("<tr height='70px'>");
                      for(int i=0; i<7; i++) {
                         if(rowIndex == 0 && i < startDayOfWeek - 1) {
                            out.println("<td align='center' bgcolor='#ffffff'>&nbsp;</td>");
                         }  else {
	                            if(dayOfMonth <= daysInMonth) {
	                                out.print("<td align='center' bgcolor='#ffffff'>");
	                                out.print("<a href='javascript:void(0);' onclick='dayPage(" + dayOfMonth + ");'>" + dayOfMonth + "</a>");
	                                out.print("</td>");
	                                dayOfMonth++;
	                            } else {
	                                out.print("<td align='center' bgcolor='#ffffff'>&nbsp;</td>");
	                            }
                         }
                    }
                    out.println("</tr>");
                    rowIndex++;
                }
            %>
        </table>
       
</div>
<jsp:include page="/WEB-INF/views/gym/gymSchedule.jsp"/>
</div>

<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp" /> --%>
</body>
<script type="text/javascript">
	function changeDate() {
	    const y = document.getElementById("y").value;
	    const m = document.getElementById("m").value;
	    const url = "${pageContext.request.contextPath}/gym/gymCalendarSelect.gym?y=" + y + "&m=" + m;
	    location.href = url;
	}
	
	function dayPage(d) {
	    const y = document.getElementById("y").value;
	    const m = document.getElementById("m").value;
	    const userId = "${loginMember.userId}";
	    console.log(userId);
	    const url = "${pageContext.request.contextPath}/gym/dayPage.gym?userId=" + userId + "&y=" + y + "&m=" + m + "&d=" + d;
	    location.href = url;
	}
</script>

</html>