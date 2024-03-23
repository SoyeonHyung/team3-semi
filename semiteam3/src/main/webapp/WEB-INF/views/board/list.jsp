<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.info {
	color: #8395a7;
}

.reply {
	color: #1dd1a1;
}

.fa-pen {
	color: #e3c7a6;
}

.list-write {
	font-size: 18px;
}

.list-title > p {
	font-size: 40px;
	margin-top: 20px;
    margin-bottom: 10px;
    margin-left: 0;
    margin-right: 0; 
}

.list-title > hr {
    width: 23%;
    margin-top: 20px;
    margin-bottom: 40px;
    margin-left: 0;
    margin-right: 0; 
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

	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>




	<div class="container" style="display: flex; width: 1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
		<div class="container w-1000 set-color">
			<%-- 제목칸 --%>
			<div class="cell left list-title">
				<c:if test="${param.category == '축구'}">
					<p>축구게시판</p>
				</c:if>
				<c:if test="${param.category == '야구'}">
					<p>야구게시판</p>
				</c:if>
				<c:if test="${param.category == '농구'}">
					<p>농구게시판</p>
				</c:if>
				<c:if test="${param.category == 'E-스포츠'}">
					<p>게임게시판</p>
				</c:if>
				<c:if test="${param.category == '관리자'}">
					<p>관리자게시판</p>
				</c:if>
				<hr>
			</div>


			<div class="cell right pen">
				<p class="list-write">
					<a class="link" href="write?category=${param.category}"> <i
						class="fa-solid fa-pen"></i> 게시글 작성
					</a>
				</p>
			</div>

			<div class="cell flex-cell">
				<div class="cell left">
					<c:if test="${empty param.status && param.category ne '관리자'}">
						<form action="list" method="get">
							<input type="hidden" name="category" value="${param.category}">
							<input type="hidden" name="status" value="recruiting">
							<button class="btn positive status-btn">모집중인 게시글만 보기</button>
						</form>
					</c:if>
					<c:if test="${param.status == 'recruiting'}">
						<form action="list" method="get">
							<input type="hidden" name="category" value="${param.category}">
							<button class="btn positive status-btn">전체 글 보기</button>
						</form>
					</c:if>
				</div>

				<div class="cell width-fill right">
					<%-- 검색창 --%>
					<form action="list" method="get">
						<!-- 카테고리를 넘겨줘야함 -->
						<input type="hidden" name="category" value="${param.category}">
						<input type="hidden" name="status" value="${param.status}">
						<select name="column" class="tool">
							<option value="board_title"
								${param.column == 'board_title' ? 'selected' : ''}>제목</option>
							<option value="board_content"
								${param.column == 'board_content' ? 'selected' : ''}>내용</option>
							<option value="member_nick"
								${param.column == 'member_nick' ? 'selected' : ''}>작성자</option>
						</select> <input class="tool" type="search" name="keyword"
							placeholder="검색어 입력" value="${param.keyword}">
						<button class="btn positive empty-check">검색</button>
					</form>
				</div>


			</div>



			<%--전체공지 테이블 --%>
			<div class="cell">
				<table class="table table-horizontal table-hover ">


					<c:forEach var="boardDto" items="${adminListAll}">
						<tr>
							<td class="left"  width="70%">
								<div class="my-10">
									<a class="link" href="detail?boardNo=${boardDto.boardNo}">
										${boardDto.boardTitle} <span class="reply">[${boardDto.boardReply}]</span>
									</a>
								</div>
								<div class="info my-10">
									<span class="red">전체공지 </span>|
									<fmt:formatDate value="${boardDto.boardWriteTime}"
										pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
									| ${boardDto.boardWriterStr}
								</div>
							</td>
							<td class="info" >${boardDto.boardWriteTimeStr}
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




					<%--게시판별 공지 테이블 --%>

					<c:forEach var="boardDto" items="${adminListCategory}">
						<tr>
							<td class="left">
								<div class="my-10">
									<a class="link" href="detail?boardNo=${boardDto.boardNo}">
										${boardDto.boardTitle} <span class="reply">[${boardDto.boardReply}]</span>
									</a>
								</div>
								<div class="info my-10">
									<span class="red">공지 </span>|
									<fmt:formatDate value="${boardDto.boardWriteTime}"
										pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
									| ${boardDto.boardWriterStr}
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

					<%--일반 게시판 테이블 --%>
					<c:forEach var="boardDto" items="${list}">
						<tr>
							<td class="left">
								<div class="my-10" >
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
									| ${boardDto.boardWriterStr}
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
			</div>

			<div class="cell center">
				<%--네비게이터 출력(구조는 복잡하지만 /board/list와 같지 않을까?) --%>
				<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
			</div>


		</div>
	</div>
</body>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>