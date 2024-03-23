<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 신고</title>
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
			<h2>게시글 신고 상세</h2>
		</div>

		 <div class="cell info">
			<h4>

				<c:choose>
					<c:when test="${reportBoardDto.reportBoardWriter == null}">
						${reportBoardDto.getReportBoardWriterStr}
					</c:when>
					<c:otherwise>
						신고자 | ${reportBoardDto.reportBoardWriter}
					</c:otherwise>
				</c:choose>

			</h4>
		</div> 
		<div class="cell info">
			<pre>신고사유 | ${reportBoardDto.reportBoardReason}</pre>
		</div>

		<div class="cell info">
			<fmt:formatDate value="${reportBoardDto.reportBoardDate}"
				pattern="yyyy-MM-dd HH:mm:ss" />
		</div>
		<hr class="detail">
		<div class="cell" style="min-height: 450px;">
			<pre>${reportBoardDto.reportBoardContent}</pre>
		</div>

		<hr class="detail">


		<div class="cell right">
			<a class="btn negative link-confirm" data-message="정말 삭제하시겠습니까?"
					href="delete?reportBoardNo=${reportBoardDto.reportBoardNo}">게시글 신고글삭제</a>
			<a class="btn positive" onclick="history.back()">게시글 신고글 목록</a>
<!-- 			<a class="btn positive" href="list">게시글 신고글 목록</a> -->
			<a class="btn positive" href="/board/detail?boardNo=${reportBoardDto.reportBoardOrigin}">신고된 게시글 보러가기</a>

		</div>
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>