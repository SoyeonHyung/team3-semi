<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>
<!-- 작성글 내역 표시 -->
<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="container w-1000 set-color">
<h2>내가 쓴 댓글</h2>
        <div class="cell">
		<table class="table table-horizontal table-hover">
			<thead class="center">
				<tr>
					<th>게시글 번호</th>
					<th width="40%">내용</th>
					<th>작성일</th>
				</tr>
			</thead>
			<!--  -->
			
			<c:forEach var="replyDto" items="${replyList}">
				<tr>
					<td>${replyDto.boardTitle}</td>
					<%-- 제목칸 --%>
					<td class="left" width="40%">
						<%-- 제목 출력--%>  <a class="link"
						href="/board/detail?boardNo=${replyDto.replyOrigin}">
							${replyDto.replyContent} </a>
					</td>
					<td>${replyDto.replyTime}</td>
				</tr>
			</c:forEach>

		</table>
		
				<div class="cell center">
			<jsp:include page="/WEB-INF/views/template/MycommentNavigator.jsp"></jsp:include>
		</div>
		
	</div>
	</div>
	</div>
	</body>
	
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>