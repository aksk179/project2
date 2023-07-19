<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<style type="text/css">
	table {
		width: 500px;
		border-collapse: collapse;
		background-color: #f3f3f3;
		border-radius: 4px; /* Add border-radius to the outer table border */
	}
	
	table th, table td {
		padding: 10px;
		border: none;
	}
	
	form {
		padding: 20px;
		text-align: center;
	}
	
	.container {
		width: 600px;
		margin: 0 auto;
		font-family: 'Arial', sans-serif;
		background-color: #f7f7f7;
		border-radius: 4px;
		box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	}
	
	h1 {
		text-align: center;
		padding: 50px;
	}
	
	table {
		width: 500px;
		border-collapse: collapse;
	}
	
	th {
		width: 200px;
		padding: 10px;
		border: none;
		text-align: center;
		color: #333;
	}
	
	td {
		width: 250px;
		padding: 10px;
		border: none;
	}
	
	label {
		width: 90%;
	}
	
	input[name="bankNo"] {
		text-align: center;
		font-size: 15px;
		font-weight: bold;
		width: 85%;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 4px;
		outline: none;
		transition: border-color 0.3s;
	}
	
	select[name="bank"] {
		background-color: #f3f3f3;
		text-align: center;
		font-weight: bold;
		font-size: 15px;
		width: 85%;
		padding: 10px;
		border: none;
		border-radius: 4px;
		outline: none;
		transition: border-color 0.3s;
	}
	
	input :focus {
		border-color: #c8220f;
	}
	
	input[type="button"] {
		padding: 8px 16px;
		background-color: #c8220f;
		color: #fff;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		transition: background-color 0.3s;
	}
	
	input[type="button"]:hover {
		background-color: #c8220f;
	}
	
	.doubleChk {
		background-color: #008cba;
	}
	
	.message {
		font-style: italic;
		color: #ff0000;
	}
	
	.successPhoneChk {
		color: #c8220f;
		font-weight: bold;
	}
	
	button[type="submit"], button[type="button"], button[type="reset"] {
		width: 80px;
		padding: 10px 20px;
		background-color: #c8220f;
		color: #fff;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		margin-top: 10px;
		transition: background-color 0.3s;
	}
	
	button[type="submit"]:hover, button[type="reset"]:hover, button[type="button"]:hover
		{
		background-color: #c8220f;
	}
	
	option {
		width: 400px;
	}
</style>
    <H1>가상계좌</H1>
    <form>
        <table align="center">
        <tr>
	        	<th>입금자</th>
	        	<th colspan="2">${loginMember.userName}</th>
	        </tr>
	        <tr>
	        	<th>금액</th>
	        	<th colspan="2">
	        		20,000원
	        		<input type="hidden" id="no" name="no" value="${no}">
	        	</th>
	        </tr>
	        <tr>
	        	<th>예금주</th>
	        	<th colspan="2">(주) 빈체로</th>
	        </tr>
	        <tr>
	        	<th>승인일시</th>
	        	<th colspan="2" id="sysdatatime"></th>
	        </tr>
            <tr>
                <th>
                    <select name="bank" id="bank" onchange="selectbank()">
                    	<option value="etc" selected>은행선택</option>
                        <option value="KA">카카오뱅크</option>
                        <option value="KB">국민은행</option>
                        <option value="WR">우리은행</option>
                        <option value="SH">신한은행</option>
                        <option value="IBK">기업은행</option>
                        <option value="HN">하나은행</option>
                        <option value="WH">외환은행</option>
                        <option value="CT">시티은행</option>
                        <option value="NH">농협</option>
                        <option value="SF">수협</option>
                        <option value="WC">우체국</option>
                    </select>
                </th>
                <td colspan="2"><input name="bankNo" id="bankNo" disabled></td>
            </tr>
            <tr>
                <th colspan="3"><button type="button" onclick="pBankSubmit();">확인</button></th>
            </tr>
        </table>
    </form>
</body>

<script>

	function pBankSubmit() {
		var no = $('#no').val();
		
		var data = {};
		data.no = no;
		
		$.ajax({
			url: "${pageContext.request.contextPath}/match/p_bankPay.ma",
			type: "POST",
			data: JSON.stringify(data),
			dataType: "JSON",
	        contentType : "application/json",
			success : function(data, status, xhr) {
				console.log(data.result);
				
				if(data.result === 'OK') {
					alert(data.msg);
					window.close();
				} else {
					alert(data.msg);
				}
			},
			error : function(xhr, status, error) {
				alert(status);
			}
		});
    }
	
   
    var currentDate = new Date();
    var currentDateTime = currentDate.toLocaleString();

    // Update the element with the current date and time
    document.getElementById("sysdatatime").innerText = currentDateTime;
   
        function selectbank() {
            var bankSelect = document.getElementById("bank");
            var accountInput = document.getElementById("bankNo");
            var selectedBank = bankSelect.value;
    
            if (selectedBank === "KA") {
                accountInput.value = "123 - 456 - 7890 - 03"; 
            } else if (selectedBank === "KB") {
                accountInput.value = "987 - 654 - 3210 - 54"; 
            } else if (selectedBank === "WR") {
                accountInput.value = "555 - 444 - 3333 - 15"; 
            } else if (selectedBank === "SH") {
                accountInput.value = "111 - 222 - 3333 - 75"; 
            } else if (selectedBank === "IBK") {
                accountInput.value = "222 - 333 - 4444 - 54"; 
            } else if (selectedBank === "HN") {
                accountInput.value = "888 - 999 - 0000 - 83"; 
            } else if (selectedBank === "WH") {
                accountInput.value = "777 - 666 - 5555 - 07"; 
            } else if (selectedBank === "CT") {
                accountInput.value = "666 - 555 - 4444 - 17"; 
            } else if (selectedBank === "NH") {
                accountInput.value = "999 - 888 - 7777 - 49"; 
            } else if (selectedBank === "SF") {
                accountInput.value = "444 - 555 - 6666 - 83";
            } else if (selectedBank === "WC") {
                accountInput.value = "555 - 444 - 3333 - 72"; 
            }
        }
    </script>
</html>