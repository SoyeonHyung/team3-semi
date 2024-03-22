<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="container w-1000 set-color">
	<div class="cell center">
		<h1>Q & A</h1>
	</div>
	
	<div class="cell right">
		<h2><a class="link" href="insert">+문의하기</a></h2>
	</div>
	<div class="cell">
		<div class="cell left">
	
	<%-- 검색창 --%>
	<form action="list" method="get">
		<select name="column" class="tool">
			<option value="inquiry_title" ${param.column == 'inquiry_title' ? 'selected' : ''}>문의내용</option>
			<option value="inquiry_writer" ${param.column == 'inquiry_writer' ? 'selected' : ''}>작성자</option>
			<option value="inquiry_content" ${param.column == 'inquiry_content' ? 'selected' : ''}>내용</option>
		</select>
		<input class="tool" type="search" name="keyword" placeholder="검색어 입력" required value="${param.keyword}">
		<button class="btn positive">검색</button>
	</form>
	</div>
		<%-- 테이블 --%>
		<table class="table table-horizontal table-hover">

	<tbody align="center">
		</thead>
		<tbody align="center">
			<c:forEach var="inquiryDto" items="${list}">
				<tr>
					<c:choose>
						<c:when test="${inquiryDto.inquiryTarget == null}">
							<td><i class="fa-solid fa-q"></i></td>
						</c:when>
						<c:otherwise>
							<td><i class="fa-solid fa-a red"></i></td>
						</c:otherwise>
					</c:choose>
					
					<%-- 제목칸 --%>
					<td class="left">
					
						<%-- 제목 앞에 차수만큼 띄어쓰기 처리 --%>
						<c:forEach var="i" begin="1" end="${inquiryDto.inquiryDepth}" step="1">
							&nbsp;&nbsp;
						</c:forEach>
						
						<%-- 답글일 경우만 이미지를 출력 --%>
						<%-- <c:if test="${inquiryDto.inquiryDepth > 0}">
							→
						</c:if> --%>
					
						<%-- 제목 출력 --%>
						<a class="link" href="detail?inquiryNo=${inquiryDto.inquiryNo}">
						${inquiryDto.inquiryTitle}
						</a>
					</td>
					<td>${inquiryDto.inquiryWriterStr}</td><%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${inquiryDto.inquiryWtimeStr}</td><%-- dto 에서 가상의 메소드 하나 만들어주기 --%>
					<td>${inquiryDto.inquiryEtime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		</div>
		<div class="cell center">
			<%--네비게이터 출력(구조는 복잡하지만 /inquiry/list와 같지 않을까?) --%>
			<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
		</div>
		
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>