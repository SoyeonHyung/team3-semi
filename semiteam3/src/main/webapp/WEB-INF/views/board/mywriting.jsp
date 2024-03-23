<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.category{
    font-size: 20px;
    color: #e4b176;
}
p { /* p태그 전체를 뜻한다*/
	font-size: 24pt;
}

</style>
<body>
<!-- 작성글 내역 표시 -->
<div class="container" style="display: flex; width:1300px;">
	<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	<div class="container w-1000 set-color">
		<p class="left">내가 쓴 글</p>
			<div class="myWriting category right">
					<a href="" class="link">All</a>
					<a href="" class="link"><i class="fa-solid fa-soccer-ball"></i></a>
					<a href="" class="link"><i class="fa-solid fa-baseball"></i></a>
					<a href="" class="link"><i class="fa-solid fa-basketball"></i></a>
					<a href="" class="link"><i class="fa-solid fa-gamepad"></i></li></a>
			</div>
        <div class="cell">
		<table class="table table-horizontal table-hover">
			<thead class="center">
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성일</th>
					<th>마감일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<c:forEach var="boardDto" items="${boardList}">
				<tr>
					<td>${boardDto.boardNo}</td>
					<%-- 제목칸 --%>
					<td class="left" width="40%">
						<%-- 제목 출력 --%> <a class="link"
						href="detail?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle} </a>
					</td>
					
					<%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${boardDto.boardWriteTimeStr}</td>
					<%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${boardDto.boardLimitTime}</td>
					<td>${boardDto.boardView}</td>
				</tr>
			</c:forEach>
<style>
.category {
	font-size: 20px;
	color: #e4b176;
}

p.mywriting {
	font-size: 30px;
}

.info {
	color: #8395a7;
}

.reply {
	color: #1dd1a1;
}
</style>

<script type="text/javascript">
	window.onload = function() {
		var statusElements = document.querySelectorAll('.status');

		statusElements.forEach(function(statusElement) {
			var boardStatus = statusElement.textContent.trim();

			if (boardStatus === '모집 중') {
				statusElement.style.color = '#10ac84'; // 모집 중일 때의 색상
			} else if (boardStatus === '모집 완료') {
				statusElement.style.color = '#ff6b6b'; // 모집 완료일 때의 색상
			}
		});
	};
</script>

<body>
	<!-- 작성글 내역 표시 -->
	<div class="container" style="display: flex; width: 1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
		<div class="container w-1000 set-color">
			<p class="left mywriting">
				<i class="fa-solid fa-pencil"></i>
				내가 쓴 글
			</p>
			<div class="mywriting category right">
				<a href="mywriting" class="link me-20">All</a> 
				
				<a href="?category=축구" class="link me-20">
				<i class="fa-solid fa-soccer-ball"></i></a> 
					
				<a href="?category=야구" class="link me-20">
				<i class="fa-solid fa-baseball"></i></a> 
					
				<a href="?category=농구" class="link me-20">
				<i class="fa-solid fa-basketball"></i></a> 
				
				<a href="?category=E-스포츠" class="link">
				<i class="fa-solid fa-gamepad"></i></a>
			</div>
			<div class="cell">
				<table class="table table-horizontal table-hover">
					<c:forEach var="boardDto" items="${boardList}">
						<tr>
							<td class="left" width="70%">
								<div class="my-10">
									<a class="link" href="detail?boardNo=${boardDto.boardNo}">
										${boardDto.boardTitle} <span class="reply">[${boardDto.boardReply}]</span>
									</a>
								</div>
								<div class="info my-10">
									모집기간
									<fmt:formatDate value="${boardDto.boardWriteTime}"
										pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
									~
									<fmt:formatDate value="${boardDto.boardLimitTimeDate}"
										pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
								</div>
							</td>
							<td class="info">${boardDto.boardWriteTimeStr}
								<p>
									조회수
									<fmt:formatNumber value="${boardDto.boardView}"
										pattern="###,###"></fmt:formatNumber>
								</p>
							</td>
							<td>
								<div class="status">${boardDto.boardStatus}</div>
							</td>
						</tr>
					</c:forEach>

				</table>

				<div class="cell center">
					<jsp:include page="/WEB-INF/views/template/MywritingNavigator.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>