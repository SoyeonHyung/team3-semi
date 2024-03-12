
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<head>
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="/js/commons.js"></script>
</head>


<style>
input[name=memberId] {
	background-image: url("/joinImage/image/user-login.png");
}

input[name=memberPw] {
	background-image: url("/joinImage/image/lock-login.png");
}
</style>





<div class="container w-400">
	<div class="cell">
		<c:if test="${param.error != null}">
			<h4 class="red center">로그인 정보가 일치하지 않습니다.</h4>
		</c:if>
	</div>
	<form action="login" method="post" autocomplete="off">
		<div class="cell center">
			<h1>로그인</h1>
		</div>
		<div class="cell">
			<label> 아이디 <input type="text" name="memberId"
				class="tool tool-image w-100">
			</label>
		</div>

		<div class="cell">
			<label> 비밀번호 <input type="password" name="memberPw"
				class="tool tool-image w-100">
			</label>

		</div>


		<hr class="my-20">

		<div class="cell ">
			<button class="btn positive w-100">로그인</button>
		</div>
		<div class="cell flex-cell">
			<div class="cell w-50 center">
				<a href="/member/findId" class="link">아이디 찾기</a>
			</div>
			<div class="cell w-50 center">
				<a href="/member/findPw" class="link">비밀번호 찾기</a>
			</div>
		</div>
		<hr>
		<div class="cell center blue">
			<p>아직 회원이 아니신가요?</p>
		</div>
	</form>
	<div class="cell center">
		<a href="/member/join" class="btn w-100 mb-20 pink">회원가입</a>
	</div>
</div>



