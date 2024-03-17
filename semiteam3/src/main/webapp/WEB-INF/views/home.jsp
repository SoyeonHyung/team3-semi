

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>


<html lang="ko">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KH13c</title>

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<!-- 내가 구현한 스타일 -->
<link rel="stylesheet" type="text/css" href="../css/commons.css">
<!--<link rel="stylesheet" type="text/css" href="../css/test.css">-->

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- swiper js cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-rwdImageMaps/1.6/jquery.rwdImageMaps.min.js"></script>


<style>
.swiper {
	width: 100%;
	/*             height: 300px; */
}

.responsive-img {
	width: 100%
}
.swiper-slide {
    display: flex; /* Flexbox 레이아웃 사용 */
    justify-content: center; /* 가로 중앙 정렬 */
}
.swiper-slide-next {
    z-index: -10;
}

</style>

<!-- jquery cdn -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- 내가 만든 스크립트 추가(jQuery를 사용했으니 jQuery CDN 아래 작성) -->
<script type="text/javascript">
	$(document).ready(function() {
		$('img[usemap]').rwdImageMaps();
	});
	$(function() {

		var swiper2 = new Swiper('.demo02', {
			//direction: 'vertical',//수평(horizontal) 또는 수직(vertical)
			loop : true,//슬라이드의 순환 여부를 설정(true/false)

			//자동재생 설정
			//autoplay: true,//기본설정
			autoplay : {
				delay : 5000,//전환간격(ms)
				pauseOnMouseEnter : true,//마우스가 올라가면 자동재생 중지
			},

			// 페이지 네비게이터 관련 설정
			pagination : {
				el : '.swiper-pagination',//el은 element(요소)를 의미
				clickable : true,//클릭 가능 여부 설정
				type : "bullets",//네비게이터 요소 모양(bullets, fraction, progresbar)
			},

		});
	});
</script>
</head>

	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
	<div id="maincontainer w-100" class="cell">
		<div class="container w-100">
			<div class="cell center">
				<!-- Slider main container -->
				<div class="swiper demo02">
					<!-- Additional required wrapper -->
					<div class="swiper-wrapper">
						<!-- Slides -->
						<div class="swiper-slide">
							<img src="/image/home/main2.png">
						</div>
						<div class="swiper-slide">
							<img src="/image/home/event.png">
						</div>
						<div class="swiper-slide">
							<img src="https://picsum.photos/id/27/1920/400">
						</div>
						<div class="swiper-slide">
							<img src="https://picsum.photos/id/29/1920/400">
						</div>
						<div class="swiper-slide">
							<img src="https://picsum.photos/id/33/1920/400">
						</div>
					</div>
					<!-- If we need pagination -->
					<div class="swiper-pagination"></div>

					<!-- If we need navigation buttons -->
				</div>
			</div>
		</div>
	</div>
