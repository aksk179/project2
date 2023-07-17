<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제</title>
<style>

.container {
    text-align: center;
}

h2 {
    margin-bottom: 20px;
}

form {
    display: flex;
    justify-content: center;
}

.button {
    padding: 10px 20px;
    background-color: #c8220f;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-right: 10px;
    transition: background-color 0.3s;
}


.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: none;
    width: 300px;
    text-align: center;
}

.button-row {
    margin-top: 20px;
}

.button-row button {
    margin-right: 10px;
}
</style>
<body>
    <div class="container">
        
        <div class="modal-content" >
            <h3>결제 방법 선택</h3>
            <div class="button-row">
                <button onclick="location.href='${pageContext.request.contextPath}/match/p_bank.ma?no=${param.no}'" class="button">계좌이체</button>
                <button onclick="location.href='${pageContext.request.contextPath}/match/p_mobile.ma'" class="button">휴대폰결제</button>
            </div>
        </div>
    </div>

</body>
</html>
