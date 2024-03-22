<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
        /*top: 330px;*/
        height: fit-content;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
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
			memberEmailValid : false,
			
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
		$("[name=memberEmail]").on(
				"blur",
				function() {
					var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
					state.memberEmailValid = regex.test($(this).val());
					$(this).removeClass("success fail").addClass(
							state.memberEmailValid ? "success" : "fail");
				});
		$(".check-form").submit(function() {
			$("[name=memberId]").blur();
			$("[name=memberEmail]").blur();
			
			return state.ok();
		});
	});
</script>

<body>

	<div class="form-container box" style="margin-top:40px">
		<h1>
			<i class="fa-solid fa-lock"></i>
			비밀번호 찾기
		</h1>
		<form action="findPw" method="post" autocomplete="off" class="check-form">
			<div class="form-group">
				<label for="memberId">아이디<b style="color: red">*</b></label>
				<input type="text" name="memberId" class="tool w-100" 
			placeholder="아이디를 입력하세요">
				<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
			</div>
			<div class="form-group">
				<label for="memberEmail">이메일<b style="color: red">*</b></label>
				<input type="text" name="memberEmail" class="tool w-100" 
			placeholder="testuser@kh13.com">
				<div class="fail-feedback">형식에 맞게 다시 작성해주세요.</div>
			</div>	
				<div class="cell" >
					<button type="sumit" class="btn positive w-100" 
							style="background-color: #e3c7a6">
						<i class="fa-solid fa-arrow-right-to-bracket"></i>
						찾기
					</button>
				</div>
				
		</form>
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>