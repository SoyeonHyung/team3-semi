<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    h1 {
        text-align: center;
        margin-top: 20px;
    }

    form {
        width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
        font-size: 16px;
    }

    button:hover {
        background-color: #0056b3;
    }

    .error-message {
        color: red;
        text-align: center;
    }
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>비밀번호 변경</h1>
<c:if test="${param.error != null}">
    <div class="error-message">비밀번호가 일치하지 않습니다</div>
</c:if>
<form action="password" method="post">
    현재 비밀번호: <input name="originPw" type="password" required><br><br>
    변경할 비밀번호: <input name="changePw" type="password" required><br><br>
    <button>확인</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
