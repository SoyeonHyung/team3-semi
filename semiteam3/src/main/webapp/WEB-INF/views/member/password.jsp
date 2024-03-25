<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>
    // param.error가 null이 아닌 경우에만 alert을 표시합니다.
    <c:if test="${param.error != null}">
        alert("정보가 일치하지 않습니다");
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
    background-color: #e3c7a6;
    color: #fff;
    cursor: pointer;
    font-size: 16px;
}
button:hover {
    background-color: #e3c7a6;
}
.error-message {
    color: red;
    text-align: center;
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
.same{
	border-color:#d63031 !important;
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
			return this.memberIdValid && originPwValid;
		},
	};

	$("[name=originPw]").on(
			"blur",
			function() {
				var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$])[a-zA-Z\d!@#$]{6,15}$/;
				state.originPwValid = regex.test($(this).val());
				$(this).removeClass("success fail").addClass(
						state.originPwValid ? "success" : "fail");
});
	$("#pw-reinput").blur(
			function() {
				var originPw = $("[name=originPw]").val();
				state.originPwCheckValid = originPw == $(this).val();

				if (originPw.length == 0) {
					$(this).removeClass("same fail fail2").addClass(
							"fail2");
				} else {
					$(this).removeClass("same fail fail2").addClass(
							state.originPwCheckValid ? "same" : "fail");
				}
			});
	//form 전송
	$(".check-form").submit(function() {
		//$(this).find("[name], #pw-reinput").blur();
		//$(this).find(".tool").blur();//모든 창

		//입력창 중에서 success fail fail2가 없는 창
		$(this).find(".tool").not(".success, .fail, .fail2").blur();
//			console.table(state);
//			console.log(state.ok());
		
		return state.ok();
	});
});
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body>

	<div class="form-container box" style="margin-top:40px">
		<h1>
			<i class="fa-solid fa-lock"></i>비밀번호 변경
		</h1>
		<form action="password" method="post" autocomplete="off" class="check-form">
    		<div class="form-group">
				<label for="originPw">현재 비밀번호<b style="color: red">*</b></label> 
				<input type="password" name="originPw" class="tool w-100" 
						placeholder="대소문자, 숫자, 특수문자(!@#$) 포함 6~15자">
				<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
			</div>
			<div class="form-group">
    			<label for="changePw">변경할 비밀번호<b style="color: red">*</b></label> 
    			<input type="password" placeholder="대소문자, 숫자, 특수문자(!@#$) 포함 6~15자" 
    					name="changePw" id="pw-reinput" class="tool  w-100">
				<div class="fail2-feedback">비밀번호를 먼저 입력하세요</div>
				<div class="fail-feedback">비밀번호를 입력하세여</div>
				<div class="success-feedback">비밀번호가 동일합니다</div>
			</div>
    		<div class="form-actions">
				<button type="submit" class="btn">
					<i class="fa-solid fa-check"></i>확인
				</button>
			</div>

		</form>
	</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
