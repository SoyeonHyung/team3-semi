<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
/* .input { */
/* 	width: 350px; */
/* 	padding: 0.5em 1em; */
/* 	border: 0.1px; */
/* } */
</style>

<script type="text/javascript">
	$(function() {
		//해야할 일
		//1. 아이디 입력창에서 입력이 완료될 경우 형식 검사하여 결과 기록
		//2. 비밀번호 입력창에서 입력이 완료될 경우 형식 검사하여 결과 기록
		//3. 비밀번호 확인창에서 입력이 완료될 경우 비밀번호와 비교하여 결과 기록
		//4. form의 전송이 이루어질 때 모든 검사결과가 유효한지 판단하여 전송

		//상태객체(React의 state로 개념이 이어짐)
		var state = {
			//key : value
			memberIdValid : false,
			memberPwValid : false,
			
			//객체에 함수를 변수처럼 생성할 수 있다
			//- this는 객체 자신(자바와 동일하지만 생략이 불가능)
			ok : function() {
				return this.memberIdValid && this.memberPwValid;
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
					var regex = /^[A-Za-z0-9!@#$]{6,15}$/;
					state.memberPwValid = regex.test($(this).val());
					$(this).removeClass("success fail").addClass(
							state.memberPwValid ? "success" : "fail");
				});
			

		//form 전송시에는 미리 설정해둔 상태변수만 확인하면 된다
		//- 검사 효과까지 보고싶다면 blur이벤트를 강제로 발생시킨다(trigger)
		//- $(대상).on("blur") 또는 $(대상).blur()
		$(".check-form").submit(function() {
			$("[name=memberId]").blur();
			$("[name=memberPw]").blur();
			
			return state.ok();
		});
	});
</script>
<script>
    // param.error가 null이 아닌 경우에만 alert을 표시합니다.
    <c:if test="${param.error != null}">
        alert("로그인 정보가 일치하지 않습니다");
    </c:if>
</script>
</head>
<body>
	<form action="login" method="post" autocomplete="off"
		class="check-form">
		<div class="container w-450" style="margin-top:80px">
			<div class="cell center title" style="color: #e3c7a6">
				<h1>
					<i class="fa-regular fa-user"></i> 로그인
				</h1>
			</div>
			<div class="cell">
				<div class="cell">
					<label>아이디<b style="color: red">*</b></label> <input type="text"
						name="memberId" placeholder="소문자 시작, 숫자 포함 8~20자" required
						class="tool w-100">

					<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
				</div>
				<div class="cell">
					<label>비밀번호<b style="color: red">*</b></label> <input
						type="password" name="memberPw"
						placeholder="대소문자,숫자,특수문자 포함 6~15자" required class="tool w-100">

					<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
				</div>

				<div class="cell">
					<button class="btn positive w-100"
						style="background-color: #e3c7a6">
						<i class="fa-solid fa-arrow-right-to-bracket"></i> 로그인
					</button>
				</div>

				<div class="cell right">
					<a href="findId">아이디 찾기</a>
				</div>
				<div class="cell right">
					<a href="findPw">비밀번호 찾기</a>
				</div>
				<div class="cell right" style="margin-bottom:200px">
					<a href="join">회원가입</a>
				</div>
			</div>
		</div>
	</form>
	
</body>
</html>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
