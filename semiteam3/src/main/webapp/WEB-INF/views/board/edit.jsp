<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/js/exit.js"></script>

<form action="edit" method="post" autocomplete="off" class="free-pass">
	<input type="hidden" name="boardNo" value="${boardDto.boardNo}">

	<div class="container" style="display: flex; width: 1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
		<div class="container w-1000 set-color">
			<div class="cell center">
				<h1>게시글 수정</h1>
			</div>

			<div class="cell right">
				<label for="datetimepicker">마감 시간</label> <input type="text"
					name="boardLimitTime" id="datetimepicker"
					class="form-control tool w-50" value="${boardDto.boardLimitTime}">
			</div>

			<div class="cell">
				<label>제목</label> <input type="text" id="boardTitle"
					name="boardTitle" class="tool w-100" value="${boardDto.boardTitle}">
			</div>
			<div class="cell">
				<label>내용</label>
				<%-- textarea는 시작태그와 종료태그 사이에 내용을 작성 --%>
				<textarea name="boardContent" id="boardContent" class="tool w-100">${boardDto.boardContent}</textarea>
			</div>
			<div class="cell right">
				<a href="list?category=${boardDto.boardCategory}" class="btn">목록</a>
				<button class="btn positive">수정</button>
			</div>
		</div>
	</div>
</form>
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
		
		//기본 시간값 현재 시간,분으로 설정했음
		defaultHour : new Date().getHours(),
		defaultMinute : new Date().getMinutes(),
	});

	$(function() {
		// 작성완료 버튼 클릭 이벤트 처리
		$('button.positive').click(function() {
			var loginGrade = "${sessionScope.loginGrade}";
			var title = $('input[name="boardTitle"]').val().trim();
			var content = $('textarea[name="boardContent"]').val().trim();
			var limitTime = $('input[name="boardLimitTime"]').val().trim();
			var boardTitleLength = $('#boardTitle').val().length;
			var boardContentLength = $('#boardContent').val().length;

			//관리자인경우 마감시간 칸 숨김
			if (loginGrade === "관리자") {
				$("#datetimepicker").closest(".cell.right").hide();
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
	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
