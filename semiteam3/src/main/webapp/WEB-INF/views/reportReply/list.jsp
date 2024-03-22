<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 신고 목록</title>
</head>
<body>
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
	<div class="box cell container">
		<div class="cell center">
			<h1>댓글 신고 목록</h1>
		</div>
		<div class="cell">
			<%-- 목록 --%>
			<table class="table">
				<thead>
					<tr>
						<th>댓글 신고 번호</th>
						<th>신고자</th>
						<th>신고사유</th>
						<th>신고일</th>
					</tr>
				</thead>
				<tbody align="center">
					<c:forEach var="reportReplyDto" items="${list}">
						<tr>
							<td>
								<a class="link" href="detail?reportReplyNo=${reportReplyDto.reportReplyNo}">
								${reportReplyDto.reportReplyNo}
								</a>
							</td>
							<td>${reportReplyDto.reportReplyWriter}</td>
							<td>${reportReplyDto.reportReplyReason}</td>
							<td>${reportReplyDto.reportReplyDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="cell center">
			<%-- 검색창 --%>
			<form action="list" method="get">
				<select name="column" class="tool">
					<option value="member_id"
						${param.column == 'member_id' ? 'selected' : ''}>신고자</option>
					<option value="report_reply_reason"
						${param.column == 'report_reply_reason' ? 'selected' : ''}>신고사유</option>
				</select> <input class="tool" type="search" name="keyword"
					placeholder="검색어 입력" required value="${param.keyword}">
				<button class="btn positive">검색</button>
			</form>
		</div>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>