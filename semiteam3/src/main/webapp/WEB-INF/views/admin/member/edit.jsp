<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .form-container {
        max-width: 1000px;
        margin: 0 auto;
    }

    form {
        margin-top: 20px;
    }
	
	
    form input[type="file"] {
        display: none;
    }
    
    <%--input 디자인--%>
    .edit{
    	width: 500px;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }
    form input[name="memberPost"] {
	    width: 400px; /* 너비 조정 */
	    padding: 10px; /* 내부 여백 설정 */
	    margin-bottom: 10px; /* 아래 여백 추가 */
	    border: 1px solid #ccc; /* 테두리 추가 */
	    border-radius: 5px; /* 테두리 둥글게 처리 */
	    font-size: 16px; /* 폰트 크기 설정 */
	    margin-right: 10px; /* 오른쪽 여백 추가 */
	}
    
    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-address-search,
    .btn-address-clear {
        font-size: 18px;
    }

    .btn.positive {
        background-color: #007bff;
        color: #fff;
    }

    .btn.negative {
        background-color: #dc3545;
        color: #fff;
    }

    .btn:hover {
        opacity: 0.8;
    }

    .error-message {
        color: red;
    }
    .box{
        width: 1000px;
        background-color: #f8f9fa;
        color: #333;
        padding: 20px;
        /*top: 330px;*/
        height: fit-content;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    $(function () {
        $(".btn-address-search").click(function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
                    $("[name=memberPost]").val(data.zonecode);
                    $("[name=memberAddress1]").val(addr);
                    $("[name=memberAddress2]").focus();
                }
            }).open();
        });

        $(".btn-address-clear").click(function () {
            $("[name=memberPost]").val("");
            $("[name=memberAddress1]").val("");
            $("[name=memberAddress2]").val("");
        });
    });
</script>


<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="form-container box center w-1000">
	<h1>${memberDto.memberNick}님의 정보 변경</h1>
	<form action="edit" method="post">
	    <input type="hidden" name="memberId" required value="${memberDto.memberId}"><br><br>
	    
	    <input type="text" class="edit" name="memberNick" required placeholder="닉네임 *" value="${memberDto.memberNick }"><br>
        <input type="email" class="edit" name="memberEmail" required placeholder="이메일 *" value="${memberDto.memberEmail }"><br>
        <input type="date" class="edit" name="memberBirth" value="${memberDto.memberBirth }" placeholder="생년월일"><br>
        <input type="tel" class="edit" name="memberContact" placeholder="연락처" value="${memberDto.memberContact }"><br>
        <div>
            <input type="text" name="memberPost" placeholder="우편번호" value="${memberDto.memberPost}">
            <button type="button" class="btn positive btn-address-search">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
            <button type="button" class="btn negative btn-address-clear">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        
        <input type="text" class="edit" name="memberAddress1" placeholder="기본주소" value="${memberDto.memberAddress1}"><br>
        <input type="text" class="edit" name="memberAddress2" placeholder="상세주소" value="${memberDto.memberAddress2}"><br>
	    <select class="edit" name="memberGrade">
	        <!-- <option value="">회원등급</option>  -->
	        <option value="일반회원">일반회원</option>
	        <option value="신고된회원">신고된회원</option>
	        <option value="휴면회원">휴면회원</option>
	        <option value="관리자">관리자</option>
	    </select><br><br>
	    <button class="btn positive right">변경하기</button>
	</form>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>