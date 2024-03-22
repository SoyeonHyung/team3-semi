<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.replylist-wrapper>.reply-item, .replylist-wrapper>.reply-item-edit {
	padding-bottom: 10px;
	margin-bottom: 10px;
	border-bottom: 1px solid #b2bec3;
}

.title {
	font-size: 30px;
}

.info {
	color: #8395a7;
}

.detail {
    border: none; /* 기본 테두리를 제거합니다. */
    height: 1px; /* 선의 높이를 설정합니다. */
    background-color: #e3c7a6; /* 선의 색상을 지정합니다. */
}

</style>

<div class="container w-1000 set-color">
	<div class="cell title left">노실? OPEN EVENT!!!</div>
	<div class="cell info">
		<i class="fa-solid fa-gear"></i> 공지 | Event | 관리자
	</div>

	<div class="cell">
		<img src="/image/eventPage960.png">
	</div>
	<div class="cell">
		24-03-20 12:00:00
	</div>

	<div class="cell right">
					<a class="btn positive" onclick="history.back()"">뒤로가기</a>
					<a class="btn positive" href="list?category=E-스포츠">글목록</a>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
