<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>
<!-- 작성글 내역 표시 -->
<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="container w-1000 set-color">
<h2>찜목록</h2>
        <div class="cell">
		<table class="table table-horizontal table-hover">
			<thead class="center">
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>마감일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<c:forEach var="boardDto" items="${likeList}">
				<tr>
					<td>${boardDto.boardNo}</td>
					<%-- 제목칸 --%>
					<td class="left" width="40%">
						<%-- 제목 출력 --%> <a class="link"
						href="/board/detail?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle} </a>
					</td>
					<td>${boardDto.boardWriterStr}</td>
					<%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${boardDto.boardWriteTimeStr}</td>
					<%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${boardDto.boardLimitTime}</td>
					<td>${boardDto.boardView}</td>
				</tr>
			</c:forEach>
		</table>
		
		<div class="cell center">
			<%--네비게이터 출력(구조는 복잡하지만 /board/list와 같지 않을까?) --%>
			<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
		</div>
	</div>
	</div>
	</div>
	</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>