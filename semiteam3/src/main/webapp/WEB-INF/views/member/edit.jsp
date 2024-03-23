<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/exit.js"></script>
<style>
    .preview {
        border: 2px solid #ccc;
        border-radius: 50%;
        width: 200px;
        height: 200px;
        object-fit: cover;
    }

    .form-container {
        max-width: 1000px;
        margin: 0 auto;
    }

    form {
        margin-top: 20px;
    }

    form input[type="text"],
    form input[type="email"],
    form input[type="password"],
    form input[type="date"],
    form input[type="tel"] {
        width: 500px;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    form input[type="file"] {
        display: none;
    }

    .btn-container {
        display: flex;
        /*justify-content: space-between;*/
    }

    .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
    }

    .btn-address-search,
    .btn-address-clear {
        font-size: 18px;
        
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
<div class="form-container box center">
    <h1>개인정보 변경</h1>

    <form action="edit" method="post" autocomplete="off" enctype="multipart/form-data" class="free-pass">
        <input type="text" name="memberNick" required placeholder="닉네임 *" value="${memberDto.memberNick }"><br>
        <input type="email" name="memberEmail" required placeholder="이메일 *" value="${memberDto.memberEmail }"><br>
        <input type="date" name="memberBirth" value="${memberDto.memberBirth }" placeholder="생년월일"><br>
        <input type="tel" name="memberContact" placeholder="연락처" value="${memberDto.memberContact }"><br>
        <div class="container">
            <input type="text" name="memberPost" placeholder="우편번호" 
            		value="${memberDto.memberPost}" maxlength="6" style="width:380px">
            
            <button type="button" class="btn positive btn-address-search">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
            <button type="button" class="btn negative btn-address-clear">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>
        <input type="text" name="memberAddress1" placeholder="기본주소" value="${memberDto.memberAddress1}"><br>
        <input type="text" name="memberAddress2" placeholder="상세주소" value="${memberDto.memberAddress2}"><br>
        <input type="password" name="memberPw" required placeholder="비밀번호 확인 *"><br>
        <button type="submit" value="Upload" name="" class="btn">변경하기</button>
    </form>

    <c:if test="${param.error != null }">
        <p class="error-message">비밀번호가 일치하지 않습니다.</p>
    </c:if>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
