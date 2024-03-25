<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/exit.js"></script>
<style>
.write-title > p {
	font-size: 25px;
}


</style>



<script type="text/javascript">
$(function() {
    // 작성완료 버튼 클릭 이벤트 처리
    $('button.positive').click(function() {
        var loginGrade = "${sessionScope.loginGrade}";
        var title = $('input[name="boardTitle"]').val().trim();
        var content = $('textarea[name="boardContent"]').val().trim();
        var limitTime = $('input[name="boardLimitTime"]').val().trim();
        var boardTitleLength = $('#boardTitle').val().length;
        var boardContentLength = $('#boardContent').val().length;

        // 관리자인 경우 마감시간 칸 숨김
        if (loginGrade === "관리자") {
            $("#datetimepicker-div").hide();
        }
        
        //관리자가 아닌데 마감시간설정을 안했다면
        if (loginGrade !== "관리자" && limitTime === '') {
            alert('마감 시간을 입력해주세요.');
            return false;
        }

        // 제목과 내용을 모두 입력해야함(관리자도)
        if (title === '' || content === '') {
            alert('제목과 내용을 모두 입력해주세요.');
            return false;
        }

        // 게시글 제목의 길이가 300자를 초과하는지
        if (boardTitleLength > 300) {
            alert('게시글 제목의 허용범위를 초과하였습니다.');
            return false;
        }

        // 게시글 내용의 길이제한
        if (boardContentLength > 4000) {
            alert('게시글 내용의 허용범위를 초과하였습니다.');
            return false;
        }
    });
    

    // 페이지 로드시 관리자인 경우 마감시간 칸 숨김
    var loginGrade = "${sessionScope.loginGrade}";
    if (loginGrade === "관리자") {
        $("#datetimepicker-div").hide();
    }
});
	
</script>





<div class="container" style="display: flex; width:1300px;">
	<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	<div class="container w-1000">
	<div class="set-color">
		<%-- 제목칸 --%>
		<div class="cell center write-title">
			<c:if test="${param.category == '축구'}">
				<p>축구게시글 작성</p>
			</c:if>
			<c:if test="${param.category == '야구'}">
				<p>야구게시글 작성</p>
			</c:if>
			<c:if test="${param.category == '농구'}">
				<p>농구게시글 작성</p>
			</c:if>
			<c:if test="${param.category == 'E-스포츠'}">
				<p>게임게시글 작성</p>
			</c:if>
			<c:if test="${param.category =='관리자'}">
				<p>전체 공지 작성</p>
			</c:if>
		</div>
		<div class="cell">
			<form class="free-pass" action="write?category=${param.category}"
				method="post">
				<div class="cell">
					<input type="hidden" name="boardCategory" value="${param.category}">
				</div>

				<div class="cell right" id="datetimepicker-div">
					<label for="datetimepicker">마감 시간</label> <input type="text"
						name="boardLimitTime" id="datetimepicker"
						class="form-control tool w-50">
				</div>

				<div class="cell">
					<input class="tool w-100" name="boardTitle" type="text" id="boardTitle" 
						placeholder="제목">
				</div>
				<div class="cell">
					<textarea class="tool w-100" name="boardContent" id="boardContent" 
						placeholder="내용 입력"></textarea>
				</div>
				<div class="flex-cell">
					<div class="cell w-50">
						<a href="list?category=${param.category}"
							class="btn negative w-100"> 취소 </a>
					</div>
					<div class="cell w-50">
						<button type="submit" id="submitBtn" class="btn positive w-100">작성완료</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
</div>


<!-- Flatpickr CSS (위에다 하면 적용이 안돼서 밑에다가 했음-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- Flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- 한국어 설정 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>


<script type="text/javascript">
	flatpickr('#datetimepicker', {
		enableTime : true,
		dateFormat : "Y-m-d H:i",
		// 한국어 설정
		locale : "ko",
		// 시간을 위아래 버튼 30분 간격으로 설정
		//(근데 사용자가 직접 입력하면 그걸로 바뀌는데 어떻게 잠그는지 모르겠음)
		minuteIncrement : 30,
		time_24hr : true,
		minDate : "today",
		enableminute : false,
		
		minTime : new Date().getHours() + ":" + (new Date().getMinutes() + 1),
		
		defaultHour: new Date().getHours(),
		defaultMinute: new Date().getMinutes(), 
	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>