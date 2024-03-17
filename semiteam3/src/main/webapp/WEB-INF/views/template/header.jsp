<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%--
	HTML은 여러 버전이 있었으며, 지금은 HTML5가 표준
	- 디자인과 관련된 요소를 많이 제거하고 다른 언어들과의 화합을 고려
	- 자체적으로 제공하는 컴포넌트(화면도구)를 많이 늘렸음
	<!DOCTYPE html>은 HTML5 임을 표시하는것
	<html> 은 HTML문서의 범위를 정하는 태그(없으면 자동으로 생김)
	<html>은 <head>와 <body>로 나뉜다
	<head>에는 문서의 정보를 작성하고 <body>에는 화면에 표시할 내용을 작성
	
	<meta>는 홈페이지의 정보를 설정하는 태그
	<title>은 문서의 제목이며 브라우저의 탭부분에 표시됨
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KH13c 홈페이지</title>
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
.note-editor {
	border: 1px solid #e3c7a6 !important;
}

.menu {
	margin: 0;
	padding: 0;
}
ul > li{
	z-index: 100;
	height:40px;
}
.menu ul {
    padding: 0;
    margin: 0;
}




</style>

<script>
	$(function() {
		var options = {
			toolbar : [
			// [groupName, [list of button]]
			[ 'style', [ 'bold', 'italic', 'underline' ] ],
			// ['font', ['strikethrough', 'superscript', 'subscript']],
			[ 'fontsize', [ 'fontname', 'fontsize' ] ],
					[ 'color', [ 'forecolor', 'backcolor' ] ],
					[ 'para', [ 'style', 'ul', 'ol', 'paragraph' ] ],
					// ['height', ['height']]
					[ 'insert', [ 'picture', 'link', 'hr' ] ], ],

			//기본높이 설정(단위 : px)
			/* height : 200,
			minHeight : 200,
			maxHeight : 300, */

			//안내문구 설정
			//placeholder: "내용을 입력하세요", 
			callbacks : {
				onImageUpload : function(files) {
					var editor = this;

					var formData = new FormData();
					//formData.append("이름", 값);
					for (var i = 0; i < files.length; i++) {
						formData.append("attachList", files[i]);
					}

					$.ajax({
						url : "/rest/board_attach/upload",
						method : "post",
						data : formData,
						processData : false,
						contentType : false,
						success : function(response) {
							// console.log(response);
							if (response == null)
								return;

							for (var i = 0; i < response.length; i++) {
								//response[i] == 이미지 번호 1개
								var tag = $("<img>").attr("src",
										"/download?attachNo=" + response[i])
										.attr("data-key", response[i])
										.addClass("server-img");
								$(editor).summernote("insertNode", tag[0]);
							}
						}
					});
				}
			}
	};
	
	$("[name='boardContent'], [name='inquiryContent']").summernote(options);
});

</script>

<!--ChartJD CDN-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="/js/commons.js"></script>


</head>
<body>
	<%--
	 상단영역
		- 홈페이지에서 가장 많이 보이는 부분
		- 로고, 검색창, 삿종 메뉴들을 배치
		- div는 투명한 영역
	 --%>
 	<div class="cell center">
			<h1 class="center"><a href="/" class="link">노실?</a></h1>
	</div>
	<div class="cell">
		<ul class="menu" width="400px">

			<li><a href="/board/list?category=축구"> <i
					class="fa-solid fa-soccer-ball"></i>&nbsp축구게시판
			</a></li>
			<li><a href="/board/list?category=야구"> <i
					class="fa-solid fa-baseball"></i>&nbsp야구게시판
			</a></li>
			<li><a href="/board/list?category=농구"> <i
					class="fa-solid fa-basketball"></i>&nbsp농구게시판
			</a></li>
			<li><a href="/board/list?category=E-스포츠"> <i
					class="fa-solid fa-gamepad"></i>&nbsp게임게시판
			</a></li>

<!-- 			<li><a href="/inquiry/list"><i class="fa-solid fa-question"></i>
					<i class="fa-solid fa-list"></i></a></li> -->
			<!-- <li><a href="/"><i class="fa-solid fa-home"></i> <i
					class="fa-solid fa-arrow-right-to-bracket"></i></a></li> -->
			<li class="menu-end"><c:choose>
				<c:when test="${sessionScope.loginId !=null}">
					<a href="/member/mypage"> <i class="fa-solid fa-user"></i>${sessionScope.loginNick}
					</a>
						<ul>
							<li>
								<a href="/member/logout"><i	class="fa-solid fa-arrow-right-from-bracket"></i> 로그아웃
								</a>
							</li>
						</ul>
				</c:when>
				<c:otherwise>
					<a href="/member/login"> <i class="fa-regular fa-user"></i> 로그인
					</a>
						<ul>
							<li>
								<a href="/member/join"> <i class="fa-solid fa-user-plus"></i> 회원가입
								</a>
							</li>
						</ul>
					</c:otherwise>
				</c:choose>
			</li>
			<c:if test="${sessionScope.loginGrade == '관리자'}">
				<li classs="menu-end"><a href="#">관리자메뉴</a>
					<ul>
						<li><a href="/admin/member/search">회원관리</a></li>
						<li><a href="/reportBoard/list">게시글 신고 목록</a></li>
					</ul></li>
			</c:if>
		</ul>
	</div>
	<div>


	</div>
</body>
</html>








