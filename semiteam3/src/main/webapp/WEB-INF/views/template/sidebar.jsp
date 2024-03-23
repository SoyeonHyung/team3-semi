<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	position: sticky;
	width: 200px;
	background-color: #f8f9fa;
	color: #333;
	padding: 20px;
	/*top: 330px;*/
	height: fit-content;
	max-height: calc(100vh - 100px);
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	top: 0px;
	overflow-y: auto;
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

<body>

<aside class="sidebar">
    <div class="cell">
        <c:choose>
            <c:when test="${sessionScope.loginGrade == '관리자'}">
                <div>
                	<a href="/member/mypage" >
                		<img src="/member/image" alt="Preview Image" class="preview">
                	</a>
                   		<div class="cell">
                        	<a href="/member/mypage" class="name">
                        		${sessionScope.loginNick}
                        	</a>                      
                    	</div>
                    <span class="grade">
                    	<i class="fa-solid fa-wand-magic-sparkles"></i>
                    	${sessionScope.loginGrade}
                    </span>
                    <hr>
                    <a href="/board/mywriting" class="my">
                    	<i class="fa-solid fa-pencil"></i>
                    	내가 쓴 글
                    </a>
                    <a href="/board/mycomment" class="my">
                    	<i class="fa-regular fa-comment-dots"></i>
                    	내가 쓴 댓글
                    </a>
                </div>
   			<hr>             
    			<div class="cell">
					<a href="/board/list?category=축구" class="my">
						<i class="fa-solid fa-soccer-ball"></i>
						축구게시판
					</a>
					<a href="/board/list?category=야구" class="my">
						<i class="fa-solid fa-baseball"></i>
						야구게시판
					</a>
					<a href="/board/list?category=농구" class="my">
						<i class="fa-solid fa-basketball"></i>
						농구게시판
					</a>
					<a href="/board/list?category=E-스포츠" class="my">
						<i class="fa-solid fa-gamepad"></i>
						게임게시판
					</a>
					<a href="/inquiry/list" class="my">
						<i class="fa-solid fa-q"></i>
						문의게시판
					</a>
				</div>
			<hr>
				<div class="cell">
					<a href="/board/list?category=관리자" class="my">
						<i class="fa-solid fa-gear"></i>	
						관리자게시판
					</a>
					<a href="/admin/member/search" class="my">
						<i class="fa-regular fa-rectangle-list"></i>
						회원관리
					</a>
					<a href="/reportBoard/list" class="my">
						<i class="fa-solid fa-reply-all"></i>
						게시글 신고 목록
					</a>
					<a href="/reportReply/list" class="my">
						<i class="fa-solid fa-reply"></i>
						댓글 신고 목록
					</a>
    			</div>
    		<hr>
        		<div class="cell">
                    <a href="/member/logout" class="my">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                    로그아웃</a>
            	</div>
			</c:when>          
            <c:when test="${sessionScope.loginId !=null}">
 				<div>
                	<a href="/member/mypage">
                		<img src="image" alt="Preview Image" class="preview">
                	</a>
                    <div class="cell">
                        <a href="/member/mypage" class="name">
                        	${sessionScope.loginNick}
                        </a>                      
                    </div>
                    <span class="grade">${sessionScope.loginGrade}</span>
			<hr>
                    <a href="/board/mywriting" class="my">
                    	<i class="fa-solid fa-pencil"></i>
                    	내가쓴 글
                    </a>
                    <a href="/board/mycomment" class="my">
                    	<i class="fa-regular fa-comment-dots"></i>
                     	내가쓴 댓글
                    </a>
                    <a href="/board/mylike" class="my">
                    	<i class="fa-regular fa-heart"></i>
                     	찜목록
                    </a>
                </div>
			<hr>
				<div class="cell">
					<a href="/board/list?category=축구" class="my">
						<i class="fa-solid fa-soccer-ball"></i>
						축구게시판
					</a>
					<a href="/board/list?category=야구" class="my">
						<i class="fa-solid fa-baseball"></i>
						야구게시판
					</a>
					<a href="/board/list?category=농구" class="my">
						<i class="fa-solid fa-basketball"></i>
						농구게시판
					</a>
					<a href="/board/list?category=E-스포츠" class="my">
						<i class="fa-solid fa-gamepad"></i>
						게임게시판
					</a>
					<a href="/inquiry/list" class="my">
						<i class="fa-solid fa-q"></i>
						문의게시판
					</a>
				</div>
    		<hr>
        		<div class="cell">
                    <a href="/member/logout" class="my">
                    	<i class="fa-solid fa-arrow-right-from-bracket"></i>
                    	로그아웃
                    </a>
            	</div>
			</c:when>
            <c:otherwise>
                <div class="container">
                    <a href="/member/login" class="button btnFloat btnlogin">로그인</a>
                </div>
			</c:otherwise>
        </c:choose>
	</div>
</aside>

</body>
</html>