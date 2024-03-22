<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.table {
	width: 95%;
	margin: 0 auto; /* 수평 가운데 정렬을 위한 마진 설정 */
	border-collapse: collapse;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.table th, .table td {
	padding: 8px;
	border-bottom: 1px solid #ddd;
}

.table th {
	text-align: left;
	background-color: #f2f2f2;
}

.gray-text {
	color: gray;
	text-align: center;
	margin-top: 10px;
}

.box {
	width: 800px;
	background-color: #f8f9fa;
	color: #333;
	padding: 20px;
	/*top: 330px;*/
	height: fit-content;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}
</style>

<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="box cell container w-1000">
	<div class="cell center">
		<h2>${memberDto.memberNick}님의 상세 정보</h2>
	</div>
	<div class="cell">
		<table class="table">
			<tr>
				<th>아이디</th>
				<td>
					${memberDto.memberId} 
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${memberDto.memberNick}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${memberDto.memberBirth}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${memberDto.memberContact}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${memberDto.memberPost} (${memberDto.memberAddress1 }
					${memberDto.memberAddress2 })</td>
			</tr>
			<tr>
				<th>회원등급</th>
				<td>${memberDto.memberGrade}</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>${memberDto.memberJoin}</td>
			</tr>
			<tr>
				<th>최종로그인</th>
				<td>${memberDto.memberLogin}</td>
			</tr>
			<tr>
				<th>신고 횟수</th>
				<td>
					${reporterCountByMemberId}
				</td>
			</tr>
			<tr>
				<th>신고 당한 횟수</th>
				<td>
					${reporteeCountByMemberId}
				</td>
			</tr>
		</table>
	</div>
	</div>
	
	<div class="cell right">
		<a class="btn positive" href="edit?memberId=${memberDto.memberId}">수정</a>
		<a href="delete?memberId=${memberDto.memberId}" class="link-confirm btn negative" data-message="정말 탈퇴시키시겠습니까?">
			회원강제탈퇴</a>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

