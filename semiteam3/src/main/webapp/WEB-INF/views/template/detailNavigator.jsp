<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.page-navigator>a {
	border-color: transparent;
}
</style>
<%-- 네비게이터 --%>
<%-- 이전이 있을 경우만 링크를 제공 --%>
<div class="page-navigator">
	<c:choose>
		<c:when test="${pageVO.isFirstBlock()}">
			<a>&lt;이전</a>
		</c:when>
		<c:otherwise>
			<a
				href="list?category=${boardDto.boardCategory}&page=${pageVO.prevBlock}&${pageVO.queryString}">&lt;이전</a>
		</c:otherwise>
	</c:choose>

	<%-- for(int i=beginBlock; i <= endBlock; i++){..} --%>
	<c:forEach var="i" begin="${pageVO.getBeginBlock()}"
		end="${pageVO.getEndBlock()}" step="1">
		<%-- 다른 페이지일 경우만 링크를 제공 --%>
		<c:choose>
			<c:when test="${pageVO.page == i }">
				<a href="#" class="on">${i}</a>
			</c:when>
			<c:otherwise>
				<a
					href="list?category=${boardDto.boardCategory}&page=${i}&${pageVO.getQueryString()}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<%-- 다음이 있을 경우만 링크를 제공 --%>

	<c:choose>
		<c:when test="${pageVO.isLastBlock()}">
			<a>다음&gt;</a>
		</c:when>
		<c:otherwise>
			<a
				href="list?category=${boardDto.boardCategory}&page=${pageVO.getNextBlock()}&${pageVO.getQueryString()}">다음&gt;</a>
		</c:otherwise>
	</c:choose>
</div>