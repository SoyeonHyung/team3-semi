<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
.map {
	width: 100%;
	height: 400px;
}


</style>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44051ef145f6b735ac8da5c7428992fc&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		var loginGrade = "${sessionScope.loginGrade}";

		// 관리자인 경우 마감 시간 입력 필드를 숨깁니다.
		if (loginGrade === "관리자") {
			$("#datetimepicker").closest(".cell.right").hide();
		}

		$("button.positive").click(function() {
			var title = $("input[name='boardTitle']").val().trim();
			var content = $("textarea[name='boardContent']").val().trim();

			// 마감 시간 
			if (loginGrade !== "관리자") {
				var limitTime = $("input[name='boardLimitTime']").val().trim();
				if (limitTime === '') {
					alert('마감 시간을 입력해주세요.');
					return false; // 작성 완료 이벤트를 중지합니다.
				}
			}

			// 관리자가 아닌 경우 제목과 내용을 모두 입력하고 마감 시간을 설정해야 합니다.
			if (loginGrade !== "관리자" && (title === '' || content === '')) {
				alert('제목과 내용을 모두 입력해주세요.');
				return false; // 작성 완료 이벤트를 중지합니다.
			}

		});

	});
</script>


<script src="/js/exit.js"></script>


	<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="container w-1000">
	<div class="set-color">
		<%-- 제목칸 --%>
		<div class="cell center title">
			<c:if test="${param.category == '축구'}">
				<h2>축구게시글 작성</h2>
			</c:if>
			<c:if test="${param.category == '야구'}">
				<h2>야구게시글 작성</h2>
			</c:if>
			<c:if test="${param.category == '농구'}">
				<h2>농구게시글 작성</h2>
			</c:if>
			<c:if test="${param.category == 'E-스포츠'}">
				<h2>게임게시글 작성</h2>
			</c:if>
			<c:if test="${param.category =='관리자'}">
				<h2>전체 공지 작성</h2>
			</c:if>
		</div>
		<div class="cell">
			<form class="free-pass" action="write?category=${param.category}"
				method="post">
				<div class="cell">
					<input type="hidden" name="boardCategory" value="${param.category}">
				</div>

				<div class="cell right">
					<label for="datetimepicker">마감 시간</label> <input type="text"
						name="boardLimitTime" id="datetimepicker"
						class="form-control tool w-50">
				</div>

				<div class="cell">
					<input class="tool w-100" name="boardTitle" type="text"
						placeholder="제목">
				</div>
				<div class="cell">
					<textarea class="tool w-100" name="boardContent" 
						placeholder="내용 입력"></textarea>
				</div>
				<div class="flex-cell">
					<div class="cell w-50">
						<a href="list?category=${param.category}"
							class="btn negative w-100"> 취소 </a>
					</div>
					<div class="cell w-50">
						<button class="btn positive w-100">작성완료</button>
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
	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
