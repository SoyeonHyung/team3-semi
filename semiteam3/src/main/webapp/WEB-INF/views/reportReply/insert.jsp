<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 신고</title>
<script src="/js/exit.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="container w-1000">
		<div class="cell center">
			<h1>댓글 신고</h1>
		</div>
		<div class="cell">
			<label>신고사유</label> <select name="reportReplyReason" required
				class="tool w-100">
				<option value="">선택하세요</option>
				<option value="욕설/비방">욕설/비방</option>
				<option value="광고">광고</option>
				<option value="무의미한 글">무의미한 글</option>
			</select>
		</div>
		<div class="cell">
			<label>신고내용</label>
			<textarea name="reportReplyContent" required class="tool w-100"
				rows="10"></textarea>
		</div>
		<div class="cell right">
			<a href="list" class="btn">목록</a>
			<button class="btn positive">등록</button>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>