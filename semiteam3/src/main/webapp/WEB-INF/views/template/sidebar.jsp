<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KH13c 홈페이지</title>
<!-- 구글 폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- 내가 구현한 스타일 -->
<link rel="stylesheet" type="text/CSS" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/CSS" href="/css/test.css"> -->

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- jquery cdn -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="/js/commons.js"></script>

<style>
	 .preview {
        border: 2px solid #ccc;
        border-radius: 50%;
        width: 150px;
        height: 150px;
        object-fit: cover;
    }
    /* 공통 스타일 */
    body {
        margin: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    /* 사이드바 스타일 */
    .sidebar {
        position: static;
        width: 200px;
        background-color: #f8f9fa;
        color: #333;
        padding: 20px;
        /*top: 330px;*/
        height: fit-content;
        max-height: calc(100vh - 100px);
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    
    .name {
        color: #000000;
        font-size: 20px;
        font-weight: bold;
        text-decoration: none;
    }
    
    .my {
        display: block;
        color: #666;
        text-decoration: none;
        padding: 8px 0;
    }
    
    .my:hover {
        color: #333;
    }
    
    .btnFloat {
        display: block;
        background-color: #007bff;
        color: #fff;
        text-align: center;
        padding: 10px 0;
        border-radius: 5px;
        text-decoration: none;
        transition: background-color 0.3s;
    }
    
    .btnFloat:hover {
        background-color: #0056b3;
    }
    .grade{
    	color:#e3c7a6;
    }
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</head>
<body>

<aside class="sidebar">
    <div class="cell">
        <c:choose>
            <c:when test="${sessionScope.loginId !=null}">
                <div>
                    <c:choose>
                        <c:when test="${empty loginMember.memberAttach}">
                            <img src="image" width="150" height="150" alt="Preview Image" id="preview" class="preview">
                        </c:when>
                        <c:otherwise>
                            <img src="/image/user.svg" id="preview" width="150" height="150" class="preview">
                        </c:otherwise>
                    </c:choose>
                    <div class="cell">
                        <a href="/member/mypage" class="name">${sessionScope.loginNick}</a>                      
                    </div>
                    <span class="grade">${memberDto.memberGrade}</span>

                    <hr>
                    <a href="/board/mywriting" class="my">내가쓴 글</a>
                    <a href="/board/mycomment" class="my">내가쓴 댓글</a>
                    <a href="/board/mylike" class="my">찜목록</a>
                    <a href="/member/logout" class="my">로그아웃</a>
                </div>
   				<hr>             
            </c:when>          
            <c:otherwise>
                <div class="container">
                    <a href="/member/login" class="button btnFloat btnlogin">로그인</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="cell">
			<a href="/board/list?category=축구" class="my"> <i
				class="fa-solid fa-soccer-ball"></i>&nbsp축구게시판
			</a> <a href="/board/list?category=야구" class="my"> <i
				class="fa-solid fa-baseball"></i>&nbsp야구게시판
			</a> <a href="/board/list?category=농구" class="my"> <i
				class="fa-solid fa-basketball"></i>&nbsp농구게시판
			</a> <a href="/board/list?category=E-스포츠" class="my"> <i
				class="fa-solid fa-gamepad"></i>&nbsp게임게시판
			</a> <a href="/inquiry/list" class="my">
			<i class="fa-solid fa-q"></i>&nbsp문의게시판
			</a>
		</div>
</aside>

</body>
</html>
