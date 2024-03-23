<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 구글 폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<!-- 내가 구현한 스타일 -->
<link rel="stylesheet" type="text/CSS" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/CSS" href="/css/test.css"> -->

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- jquery cdn -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="/js/commons.js"></script>


<!--summernote cdn-->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<style>
<%--템플릿 페이지를 불러오는 코드 --%>

	body {
  margin: 0;
  /* 확대시켜서 스크롤 생기는 거 가려줌 */
  overflow: hidden;
}

/* 글씨를 화면 가운데에 위치 */
.background-blur {
  font-size: 50px;
  display: flex;
  height: 80vh;
  justify-content: center;
  align-items: center;
  color:gray
}

/* background-image blur */
.background-blur::before {
  content: "";
  position: ;
  left: 0;
  top: 0;
  width: 50%;
  height: 50%;
  z-index: -1;
  background-image: url("/image/home/nosilLogo.png");
  background-size: cover; 
  background-repeat: no-repeat;
  background-position: center;
  /* 배경 블러 */
  filter: blur(5px);
  transform: scale(1.1);
}


	
</style>
 <body>
    <div class="background-blur">
     
		<a href="/"><i class="fa-solid fa-house"></i>Main</a>
	</div>
  </body>
</html>


	  	

