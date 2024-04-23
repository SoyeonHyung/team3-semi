<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
.qna-edit-title{
	font-size: 25px;
}

</style>
<script src="/js/exit.js"></script>

<form class="free-pass" action="edit" method="post" autocomplete="off">
    <input type="hidden" name="inquiryNo" value="${inquiryDto.inquiryNo}">
<div class="container" style="display: flex; width: 1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include> 
<div class="container w-1000 set-color">
    <div class="cell center">
    	<p class="qna-edit-title">문의게시글 수정</p>
    </div>
    <div class="cell">
        <label>제목</label>
        <input type="text" name="inquiryTitle" required class="tool w-100" value="${inquiryDto.inquiryTitle}">
    </div>
    <div class="cell">
        <label>내용</label>
        <%-- textarea는 시작태그와 종료태그 사이에 내용을 작성 --%>
        <textarea name="inquiryContent" required class="tool w-100" rows="10">${inquiryDto.inquiryContent}</textarea>
    </div>
    <div class="cell right">
        <a href="${pageContext.request.contextPath}/list" class="btn">목록</a>
        <button class="btn positive">수정</button>
    </div>
</div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>