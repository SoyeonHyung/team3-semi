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
        border: 1px solid #ccc;
        margin-bottom: 10px;
        border-radius: 5px;
        box-sizing: border-box;
    }

    button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #dc3545;
        color: #fff;
        cursor: pointer;
        font-size: 16px;
    }

    button:hover {
        background-color: #c82333;
    }

    .error-message {
        color: red;
        text-align: center;
    }
</style>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="box">
<form action="exit" method="post">
<div class="container">
	<div class="cell center"><h1>회원 탈퇴</h1></div>
	<div class="cell center"><p>탈퇴를 위해 비밀번호를 한 번 더 입력해 주세요</p></div>
	<div class="cell">
		<input type="password" name="memberPw" placeholder="비밀번호 입력" required>
	</div>
	<div class="cell">
		<button>탈퇴하겠습니다</button>
	</div>
	<c:if test="${param.error != null}">
	<div class="cell">
		<h3 style="color:red">비밀번호가 일치하지 않습니다</h3>
	</div>
	</c:if>
</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

