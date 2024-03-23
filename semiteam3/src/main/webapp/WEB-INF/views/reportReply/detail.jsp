<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	.box {
		width: 1000px;
		background-color: #f8f9fa;
		color: #333;
		padding: 20px;
		/*top: 330px;*/
		height: fit-content;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 10px;
	}
	.title{
		font-size:30px;
	}
	.info {
	color: #8395a7;
	}
	.detail {
	border: none;
	height: 1px;
	background-color: #e3c7a6;
	} 
</style>
</head>
<body>
	<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	<div class="container w-1000 set-color">
		<div class="cell center">
			<h2>댓글 신고 상세</h2>
		</div>

		<div class="cell info">
			<h4>
				<%-- 탈퇴한 사용자일 때와 아닐 때 나오는 정보가 다르게 구현 --%>
				<c:choose>
					<c:when test="${reportReplyDto.reportReplyWriter == null}">
					${reportReplyDto.getReportReplyWriterStr}
				</c:when>
					<c:otherwise>
					신고자 |
					${memberDto.memberNick}
					(${memberDto.memberGrade})
				</c:otherwise>
				</c:choose>
			</h4>
		</div>
		<div class="cell info">
			<pre>신고사유 | ${reportReplyDto.reportReplyReason}</pre>
		</div>
		<div class="cell info">
			<pre><fmt:formatDate value="${reportReplyDto.reportReplyDate}"
				pattern="yyyy-MM-dd HH:mm:ss" /></pre>
		</div>
		<hr class="detail">
		<div class="cell" style="min-height: 200px;">
			<pre>${reportReplyDto.reportReplyContent}</pre>
		</div>

		

		<!-- 신고당한 댓글 -->
		<hr>
		<div class="cell info">
			신고 당한 댓글 (No. ${reportedReplyData.reply_no})
		</div>
		<hr class="detail">
		<div class="cell" style="min-height: 200px;">
			<pre>${reportedReplyData.reply_content}</pre>
		</div>
		<hr class="detail">
		<div class="cell right">
			<a class="btn negative link-confirm" data-message="정말 삭제하시겠습니까?"
					href="delete?reportReplyNo=${reportReplyDto.reportReplyNo}">댓글 신고글삭제</a>
			<a class="btn positive" onclick="history.back()">댓글 신고글 목록</a>
<!-- 			<a class="btn positive" href="list">댓글 신고글 목록</a> -->
			<!-- <a class="btn positive" href="/board/detail?boardNo=${originalBoardNo}">신고된 댓글 보러가기</a> -->

		</div>
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
