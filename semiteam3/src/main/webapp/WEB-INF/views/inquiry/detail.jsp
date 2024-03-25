<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.title{
		font-size:25px;
	}
	.info {
	color: #8395a7;
	}
	.detail {
	border: none;
	height: 1px;
	background-color: #e3c7a6;
	}
	.box {
	width: 1000px;
	background-color: #fff;
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
	<div class="box container">
		<div class="cell center">
			<c:if test="${inquiryDto.inquiryTarget != null}">
				<h2>문의답변</h2>
			</c:if>
			<c:if test="${inquiryDto.inquiryTarget == null}">
				<h2>문의글</h2>
			</c:if>
				
		</div>
		<div class="cell">
			<div class="title">${inquiryDto.inquiryTitle}
				<%--(추가) 수정시각 유무에 따라 수정됨 표시 --%>
				<c:if test="${inquiryDto.inquiryEtime != null}">
					(수정됨)
				</c:if>
			</div>
		</div>
		
		<div class="cell info">
			<h3>
				<%-- 탈퇴한 사용자일 때와 아닐때 나오는 정보가 다르게 구현 --%>
				<c:choose>
					<c:when test="${inquiryDto.inquiryWriter == null}">
						${inquiryDto.inquiryWriterStr}
					</c:when>
					<c:otherwise>
						작성자 | ${memberDto.memberNick}
						(${memberDto.memberGrade})
					</c:otherwise>
				</c:choose>
			</h3>
		</div>
		<div class="cell info">
			<fmt:formatDate value="${inquiryDto.inquiryWtime}"
									   pattern="yyyy-MM-dd HH:mm:ss"/>
			(${inquiryDto.inquiryWtimeDiff})
		</div>
		<hr  class="detail">
		<div class="cell" style="min-height:450px">
			<%--
					HTML은 엔터와 스페이스 등을 무시하기 때문에 textarea와 모양이 달라진다
					사용 에디터를 쓰면 알아서 글자를 보정해주기 때문에 문제가 없다
					기본 textarea를 쓰면 문제가 발생한다
					<pre>태그를 사용하면 글자를 있는 그대로 출력한다
					-Rich Text Editor 를 사용하면 문제가 해결된다(ex: summernote)
				 --%>
			${inquiryDto.inquiryContent}
		</div>
		<hr  class="detail">
	
		<div class="cell right">
	<!-- 		<a class="btn" href="write">글쓰기</a> -->
			<%-- 
				수정과 삭제 링크는 회원이면서 본인글이거나 관리자일 경우만 출력 
				- 본인글이란 로그인한 사용자 아이디와 게시글 작성자가 같은 경우
				- 관리자란 로그인한 사용자 등급이 '관리자'인 경우
				
				- 관리자인 경우만 답글쓰기 가능!
			--%>
			<c:if test="${sessionScope.loginId != null && (sessionScope.loginId == inquiryDto.inquiryWriter || sessionScope.loginGrade == '관리자')}">
				<a class="btn negative" href="edit?inquiryNo=${inquiryDto.inquiryNo}">글수정</a>
				<a class="btn negative link-confirm" 
					data-message="정말 삭제하시겠습니까?" 
					href="delete?inquiryNo=${inquiryDto.inquiryNo}">글삭제</a>
			</c:if>
			
			<c:if test="${sessionScope.loginGrade == '관리자' && inquiryDto.inquiryTarget == null}">
				<a class="btn positive" href="insert?inquiryTarget=${inquiryDto.inquiryNo}">답글쓰기</a>
			</c:if>
			<a class="btn positive" href="list">글목록</a>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	