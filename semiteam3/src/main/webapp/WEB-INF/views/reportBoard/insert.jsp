<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/exit.js"></script>
<style>
.reportBoard-title > p {
	font-size: 25px;
}
</style>


<script type="text/javascript"> //헤더 아래에 있어야 작동
	$(document).ready(function() {
		$("form").submit(function() {
			alert("신고가 완료되었습니다");
		});
	});
</script>

	
<div class="container" style="display: flex; width:1300px;">
	<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	<div class="container w-1000">
		<div class="set-color">
			<div class="cell center reportBoard-title">
				<h1>게시글 신고</h1>
			</div>
			<div class="cell">
				<form action="insert" method="post" autocomplete="off" class="free-pass">
					<div class="cell">
						<input name="reportBoardOrigin" type="hidden"
								value="${param.reportBoardOrigin}">
					</div>
					<div class="cell right">
						<label>신고사유</label>
						<select name="reportBoardReason" class="tool w-50">
							<option value="">선택하세요</option>
							<option value="욕설/비방">욕설/비방</option>
							<option value="광고">광고</option>
							<option value="무의미한 글">무의미한 글</option>
						</select>
					</div>
					<div class="cell">
						<input class="tool w-100" name="reportBoardTitle" type="text" id="reportBoardTitle" 
								placeholder="제목">
					</div>
					<div class="cell">
						<textarea class="tool w-100" name="reportBoardContent" id="boardContent" 
							placeholder="내용 입력"></textarea>
					</div>
					<div class="flex-cell">
						<div class="cell w-50">
							<a href="list?category=${param.category}"
								class="btn negative w-100"> 취소 </a>
						</div>
						<div class="cell w-50">
							<button type="submit" id="submitBtn" class="btn positive w-100">등록</button>
							<c:if test="${sessionScope.loginGrade == '관리자'}">
								<a href="list" class="btn">목록</a>
							</c:if>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
	

   
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
