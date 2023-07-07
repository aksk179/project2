<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/memberPersonalInfo.css">
<title>Insert title here</title>
<script type="text/javascript">
function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('chk');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
</script>
</head>
<body>

	<form
		action="${pageContext.request.contextPath}/member/memberEnroll.me"
		id="joinForm" align="center">
		<h1>개인정보동의</h1>
		<ul class="join_box">
			<li class="checkBox check01">
				<ul class="clearfix">
					<li style="text-align: left; padding-left:90px";>이용약관, 개인정보 수집 및 이용, 위치정보 이용약관에 <br>모두 동의합니다.</li>
					<li class="checkAllBtn"><input type="checkbox" name="chk"
						id="chk" value="selectall" class="chkAll"
						onclick="selectAll(this)"></li>
				</ul>
			</li>
			<li class="checkBox check02">
				<ul class="clearfix">
					<li>이용약관 동의</li>
					<li class="checkBtn"><input type="checkbox" name="chk"
						required></li>
				</ul> <textarea name="" id="" style="resize: none;">여러분을 환영합니다. 빈체로 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 빈체로 서비스의 이용과 관련하여 빈체로 서비스를 제공하는 빈체로 주식회사(이하 ‘빈체로’)와 이를 이용하는 빈체로 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 빈체로 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>개인정보 수집 및 이용에 대한 안내</li>
					<li class="checkBtn"><input type="checkbox" name="chk"
						required></li>
				</ul> <textarea name="" id="" style="resize: none;">여러분을 환영합니다. 빈체로 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 빈체로 서비스의 이용과 관련하여 빈체로 서비스를 제공하는 빈체로 주식회사(이하 ‘빈체로’)와 이를 이용하는 빈체로 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 빈체로 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</textarea>
			</li>
			<li class="checkBox check03">
				<ul class="clearfix">
					<li>위치정보 이용약관 동의</li>
					<li class="checkBtn"><input type="checkbox" name="chk"
						required></li>
				</ul> <textarea name="" id="" style="resize: none; margin-bottom: 30px;">여러분을 환영합니다. 빈체로 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 빈체로 서비스의 이용과 관련하여 빈체로 서비스를 제공하는 빈체로 주식회사(이하 ‘빈체로’)와 이를 이용하는 빈체로 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 빈체로 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</textarea>
			</li>

		</ul>
		<br>
			<div id="btn"><button type="submit">다음단계</button></div>
			<br>
		
	</form>

</body>
</html>