<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <style>
    .insert-title > p {
	font-size: 25px;
	}
    </style>
    
    <script src="/js/exit.js"></script>
    
    
    <script>
    
    $(document).ready(function() {
        // 완료 버튼을 클릭했을 때 처리하는 함수
        $('.inquiry-finish').click(function(event) {
        	var message;
        	if(${param.inquiryTarget!=null}){
        		message = "답변 작성 완료";
        	}
        	else{
        		message = "문의글이 성공적으로 작성되었습니다. \n 빠른 시일내에 답변 드리도록 하겠습니다";
        	}
        	alert(message); 
        });
    });
	</script>
    <div class="container" style="display: flex; width: 1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include> 
    <div class="container w-1000 set-color">
		<div class="cell center insert-title">
    		<c:if test="${param.inquiryTarget != null}">
				<p>문의 답변</p>
			</c:if>
			<c:if test="${param.inquiryTarget == null}">
				<p>문의글 작성</p>
			</c:if>
		</div>
    	
		<div class="cell">
			<form class="free-pass" action="insert" method="post">
				
				<c:if test="${param.inquiryTarget!=null}">
					<input type="hidden" name="inquiryTarget" value="${param.inquiryTarget}">
				</c:if>
				
				<c:choose>
					<c:when test="${param.inquiryTarget == null}">
						<input class="tool w-100" name="inquiryTitle" type="text" required placeholder="제목 입력"><br><br>
					</c:when>
					<c:otherwise>
						<input class="tool w-100" name="inquiryTitle" type="text" required 
								value="[RE]${targetDto.inquiryTitle}" placeholder="제목 입력"><br><br>
					</c:otherwise>
				</c:choose>
				
				<div class="cell">
					<textarea class="tool w-100" name="inquiryContent" placeholder="내용 입력"></textarea>
				</div>
				
				<div class="flex-cell">
					<div class="cell w-50">
						<a href="list" class="btn negative w-100">
							취소
						</a>
					</div>
					<div class="cell w-50">
						<button class="btn positive inquiry-finish w-100">
							완료
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	