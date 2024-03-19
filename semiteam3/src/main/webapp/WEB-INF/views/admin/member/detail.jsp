<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800">
	<div class="cell center">
		<h2>${memberDto.memberNick}님의 상세 정보</h2>
	</div>
	<div class="cell">
		<table class="table table-horizontal">
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
	
	<div class="cell right">
		<a class="btn positive" href="edit?memberId=${memberDto.memberId}">수정</a>
		<a href="delete?memberId=${memberDto.memberId}" class="link-confirm btn negative" data-message="정말 탈퇴시키시겠습니까?">
			회원강제탈퇴</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>