<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
.preview {
	border: 2px solid #ccc;
	border-radius: 50%;
	width: 200px;
	height: 200px;
	object-fit: cover;
}

.flex-cell {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	margin-bottom: 20px;
}

.flex-cell img {
	cursor: pointer;
}

.flex-cell ul {
	list-style-type: none;
	padding: 0;
	text-align: center;
}

.flex-cell ul li {
	margin-bottom: 10px;
}

.cell {
	text-align: center;
	margin-bottom: 20px;
}

.table {
	width: 95%;
	margin: 0 auto; /* 수평 가운데 정렬을 위한 마진 설정 */
	border-collapse: collapse;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.table th, .table td {
	padding: 8px;
	border-bottom: 1px solid #ddd;
}

.table th {
	text-align: left;
	background-color: #f2f2f2;
}

.left {
	text-align: left;
}

.gray-text {
	color: gray;
	text-align: center;
	margin-top: 10px;
}

.box {
	width: 800px;
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
    $(function(){
        
        $("#memberAttach").on("change", function() {
            var formData = new FormData();
            formData.append("attach", this.files[0]);
            $.ajax({
                url : "/rest/member_attach/upload",
                method : "post",
                data : formData,
                processData : false,
                contentType : false,
                success : function(response) {
                    if (response == null)
                        return;
                    $("#preview").attr("src", "image");
                }
            });
        });

    });

    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function(e) {
                $('#preview').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
            
        }
    }
</script>
	<div class="container" style="display: flex; width:1300px;">
		<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
<div class="box cell container">
<div class="flex-cell">
    <form action="mypage" method="post" autocomplete="off" enctype="multipart/form-data">
        <c:choose>
            <c:when test="${empty loginMember.memberAttach}">
                <label for="memberAttach">
                    <img src="image" width="200" height="200" alt="Preview Image" id="preview" class="preview">
                </label>
            </c:when>
            <c:otherwise>
                <label for="memberAttach">
                    <img src="/image/user.svg" id="preview" width="200" height="200" class="preview">
                </label>
            </c:otherwise>
        </c:choose>
        <input type="file" id="memberAttach" name="memberAttach" class="input" 
                    onchange="previewImage(this)" style="display:none">
    </form>
      <div class="gray-text">
        * 사진을 클릭하여 변경하세요   
    </div>
 
</div>
<div class="cell">
    <table class="table">
        <tr>
            <th width="30%">닉네임</th>
            <td class="left">${memberDto.memberNick}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td class="left">${memberDto.memberEmail}</td>
        </tr>
        <tr>
            <th>연락처</th>
            <td class="left">${memberDto.memberContact}</td>
        </tr>   
        <tr>
            <th>생년월일</th>
            <td class="left">${memberDto.memberBirth}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td class="left">
                [${memberDto.memberPost}] 
                ${memberDto.memberAddress1}
                ${memberDto.memberAddress2}
            </td>
        </tr>
        <tr>
            <th>등급</th>
            <td class="left">${memberDto.memberGrade}</td>
        </tr>
        <tr>
            <th>가입일시</th>
            <td class="left">
                <fmt:formatDate value="${memberDto.memberJoin}" 
                                            pattern="y년 M월 d일"/>
            </td>
        </tr>
        <tr>
            <th>로그인일시</th>
            <td class="left">
                <fmt:formatDate value="${memberDto.memberLogin}" 
                                            pattern="y년 M월 d일 H시 m분 s초"/>
            </td>
        </tr>
    </table>

		<div class="cell">
			<a href="/member/password" class="button">비밀번호 변경</a> <a
				href="/member/edit" class="button">개인정보 변경</a> <a
				href="/member/exit" class="button">회원 탈퇴</a>
		</div>
	</div>

</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
