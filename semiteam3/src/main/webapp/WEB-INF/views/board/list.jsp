<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<body>

	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
	<div class="container w-1200" style="display:flex;">
	<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	<div class="container w-900">
	<%-- 제목칸 --%>
	<div class="cell center">
		<c:if test="${param.category == '축구'}">
			<h1>
				<i class="fa-solid fa-soccer-ball"></i> 축구게시판 <i
					class="fa-solid fa-soccer-ball"></i>
			</h1>
		</c:if>
		<c:if test="${param.category == '야구'}">
			<h1>
				<i class="fa-solid fa-baseball"></i> 야구게시판 <i
					class="fa-solid fa-baseball"></i>
			</h1>
		</c:if>
		<c:if test="${param.category == '농구'}">
			<h1>
				<i class="fa-solid fa-basketball"></i> 농구게시판 <i
					class="fa-solid fa-basketball"></i>
			</h1>
		</c:if>
		<c:if test="${param.category == 'E-스포츠'}">
			<h1>
				<i class="fa-solid fa-gamepad"></i> 게임게시판 <i
					class="fa-solid fa-gamepad"></i>
			</h1>
		</c:if>
		<c:if test="${param.category == '관리자'}">
			<h1>
				<i class="fa-solid fa-gear"></i> 관리자게시판 <i class="fa-solid fa-gear"></i>
			</h1>
		</c:if>
	</div>

		<div class="cell">타인에 대한 무분별한 비방 또는 욕설은 경고 없이 삭제될 수 있습니다</div>
		<div class="cell right">
			<h2>
				<a class="link" href="write?category=${param.category}"> <i
					class="fa-solid fa-plus"></i> 게시글 작성
				</a>
			</h2>
		</div>

	<%--전체공지 테이블 --%>
	<div class="cell">
		<table class="table table-horizontal table-hover">
			<thead class="center">
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>마감일</th>
					<th>상태</th>
					<th>조회수</th>
				</tr>
			</thead>

			<c:forEach var="boardDto" items="${adminListAll}">
				<tr>
					<td class="red">전체공지</td>
					<td class="left"><a class="link"
						href="detail?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle} </a></td>
					<td>${boardDto.boardWriterStr}</td>
					<td>${boardDto.boardWriteTimeStr}</td>
					<td>-</td>
					<td>-</td>
					<td>${boardDto.boardView}</td>
				</tr>
			</c:forEach>




			<%--게시판별 공지 테이블 --%>

			<c:forEach var="boardDto" items="${adminListCategory}">
				<tr>
					<td class="red">공지</td>
					<td class="left" width="40%"><a class="link"
						href="detail?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle} </a></td>
					<td>${boardDto.boardWriterStr}</td>
					<td>${boardDto.boardWriteTimeStr}</td>
					<td>-</td>
					<td>-</td>
					<td>${boardDto.boardView}</td>
				</tr>
			</c:forEach>

				<%--일반 게시판 테이블 --%>
			<c:forEach var="boardDto" items="${list}">
				<tr>
					<td>${boardDto.boardNo}</td>
					<%-- 제목칸 --%>
					<td class="left" width="40%">
						<%-- 제목 출력 --%> <a class="link"
						href="detail?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle} [${boardDto.boardReply}]</a>
					</td>
					<td>${boardDto.boardWriterStr}</td>
					<%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${boardDto.boardWriteTimeStr}</td>
					<%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>
						<fmt:formatDate value="${boardDto.boardLimitTimeDate}" pattern="yyyy-MM-dd HH:mm" ></fmt:formatDate>
					</td>
					<td>${boardDto.boardStatus}</td>
					<td>${boardDto.boardView}</td>
				</tr>
			</c:forEach>

			</table>
		</div>

		<div class="cell center">
			<%--네비게이터 출력(구조는 복잡하지만 /board/list와 같지 않을까?) --%>
			<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
		</div>
		<div class="cell left">
			<%-- 검색창 --%>
			<form action="list" method="get">
				<!-- 카테고리를 넘겨줘야함 -->
				<input type="hidden" name="category" value="${param.category}">
				<select name="column" class="tool">
					<option value="board_title"
						${param.column == 'board_title' ? 'selected' : ''}>제목</option>
					<option value="board_content"
						${param.column == 'board_content' ? 'selected' : ''}>내용</option>
					<option value="board_writer"
						${param.column == 'board_writer' ? 'selected' : ''}>작성자</option>
				</select> <input class="tool" type="search" name="keyword"
					placeholder="검색어 입력" required value="${param.keyword}">
				<button class="btn positive">검색</button>
			</form>
		</div>
	</div>
	</div>
</body>
	
