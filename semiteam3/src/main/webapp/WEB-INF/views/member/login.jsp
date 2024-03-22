<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
    // param.error가 null이 아닌 경우에만 alert을 표시합니다.
    <c:if test="${param.error != null}">
        alert("로그인 정보가 일치하지 않습니다");
    </c:if>
</script>	
<style>
.input {
	width: 350px;
	padding: 0.5em 1em;
	border: 0.1px;
}
.form-container {
	width: 450px;
	margin: 0 auto;
}
.form-container h1 {
	color: #e3c7a6;
	text-align: center;
}
.form-group {
	margin-bottom: 20px;
}
.form-group label {
	display: block;
	margin-bottom: 5px;
}
.form-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}
.form-feedback {
	color: red;
	font-size: 14px;
}
.form-actions {
	text-align: center;
}
.form-actions button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #e3c7a6;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
}
.box{
	width: 500px;
	background-color: #f8f9fa;
	color: #333;
	padding: 20px;
	height: fit-content;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	/*top: 330px;*/
}

a{
	text-decoration: none;
	color:#e3c7a6;
}
a:hover {
    color: darken(#e3c7a6, 20%); /* 마우스를 올렸을 때 링크의 텍스트 색상 어둡게 만듭니다 */
    text-decoration: underline; /* 마우스를 올렸을 때 밑줄 추가 */
    color: #7f6d5f;
}
</style>

<script>

$(function() {
	//해야할 일
	//1. 아이디 입력창에서 입력이 완료될 경우 형식 검사하여 결과 기록
	//2. form의 전송이 이루어질 때 모든 검사결과가 유효한지 판단하여 전송

	//상태객체(React의 state로 개념이 이어짐)
	var state = {
		//key : value
		memberIdValid : false,
		memberPwValid : false,
		//객체에 함수를 변수처럼 생성할 수 있다
		//- this는 객체 자신(자바와 동일하지만 생략이 불가능)
		ok : function() {
			return this.memberIdValid && memberPwValid;
		},
	};

	$("[name=memberId]").on(
			"blur",
			function() {
				var regex = /^[a-z][a-z0-9]{7,19}$/;
				state.memberIdValid = regex.test($(this).val());
				$(this).removeClass("success fail").addClass(
						state.memberIdValid ? "success" : "fail");
	});
	$("[name=memberPw]").on(
					"blur",
					function() {
						var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$])[a-zA-Z\d!@#$]{6,15}$/;
						state.memberPwValid = regex.test($(this).val());
						$(this).removeClass("success fail").addClass(
								state.memberPwValid ? "success" : "fail");
	});
	$(".check-form").submit(function() {
		$("[name=memberId]").blur();
		$("[name=memberPw]").blur();
		
		return state.ok();
	});
});
</script>
</head>
<body>

	<div class="form-container box" style="margin-top:40px">
		<h1>
			<i class="fa-regular fa-user"></i> 로그인
		</h1>
		<form action="login" method="post" autocomplete="off" class="check-form">
			<div class="form-group">
				<label for="memberId">아이디<b style="color: red">*</b></label>
					 <input type="text" name="memberId" class="tool w-100" 
							placeholder="소문자 시작, 숫자포함 8~20자">
				<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
			</div>
			<div class="form-group">
				<label for="memberPw">비밀번호<b style="color: red">*</b></label> 
				<input type="password" name="memberPw" class="tool w-100" 
						placeholder="대소문자, 숫자, 특수문자(!@#$) 포함 6~15자">
				<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
				</div>
			<div class="form-group center">
				<a href="findId">아이디 찾기</a><span style="color: #e3c7a6"> |</span> <a
					href="findPw"> 비밀번호 찾기</a><span style="color: #e3c7a6"> |</span> <a
					href="join"> 회원가입</a>
			</div>

			<div class="form-actions">
				<button type="submit" class="btn">
					<i class="fa-solid fa-arrow-right-to-bracket"></i> 로그인
				</button>
			</div>

		</form>
	</div>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
