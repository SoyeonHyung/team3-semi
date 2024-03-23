<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 신고</title>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/exit.js"></script>


</head>
<body>

	<script type="text/javascript"> //헤더 아래에 있어야 작동
	$(document).ready(function() {
		$("form").submit(function() {
			alert("신고가 완료되었습니다");
		});
	});
	</script>
	
	<form action="insert" method="post" autocomplete="off" class="free-pass">
		<div class="container" style="display: flex; width:1300px;">
			<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
		<div class="container w-1000">
			<div class="cell center">
				<h1>게시글 신고</h1>
			</div>
			<div class="cell">
				<input name="reportBoardOrigin" type="hidden"
					value="${param.reportBoardOrigin}">
			</div>
			<div class="cell">
				<label>신고사유</label> <select name="reportBoardReason" required
					class="tool w-100">
					<option value="">선택하세요</option>
					<option value="욕설/비방">욕설/비방</option>
					<option value="광고">광고</option>
					<option value="무의미한 글">무의미한 글</option>
				</select>
			</div>
			<div class="cell">
				<label>신고내용</label>
				<textarea name="reportBoardContent" required class="tool w-100"
					rows="10"></textarea>
			</div>
			<div class="cell right">

				<c:if test="${sessionScope.loginGrade == '관리자'}">
					<a href="list" class="btn">목록</a>
				</c:if>
				<button class="btn positive" type="submit">등록</button>
			</div>
		</div>
		</div>
	</form>
	

   
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</body>
</html>