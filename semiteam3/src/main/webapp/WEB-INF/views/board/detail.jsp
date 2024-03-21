<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.replylist-wrapper>.reply-item, .replylist-wrapper>.reply-item-edit {
	padding-bottom: 10px;
	margin-bottom: 10px;
	border-bottom: 1px solid #b2bec3;
}
</style>
<script type="text/template" id="reply-item-wrapper">
<div class="cell">
	<div class="reply-item">
	<h3>
		<span class="reply-writer">작성자</span>
		<i class="fa-solid fa-edit blue ms-20 btn-reply-edit"></i>
		<i class="fa-solid fa-trash red btn-reply-delete"></i>
	</h3>
	<pre class="reply-content"> 댓글 내용</pre>
	<div class="reply-time">yyyy-MM-dd HH:mm:ss</div>
			<%-- <c:if test="${sessionScope.loginId != null && sessionScope.loginId != boardDto.boardWriter}">  --%>	
			<c:if test="${sessionScope.loginId != null && (sessionScope.loginId == boardDto.boardWriter || sessionScope.loginGrade == '관리자')}">
				<div><a class="btn" href="http://localhost:8080/reportBoard/insert?reportBoardOrigin=${boardDto.boardNo}"><pre>신고</pre></a></div>
			</c:if>	
	</div>
	
</script>
<script type="text/template" id="reply-item-edit-wrapper">
<div class="reply-item-edit">
		<textarea class="tool w-100 reply-editor2" style="min-height: 150px"></textarea>
		<div class="right">
			<button class="btn positive btn-reply-save">
				<i class="fa-solid fa-check"></i>
					변경</button>
			<button class="btn negative btn-reply-cancel">
				<i class="fa-solid fa-xmark"></i>
					취소</button>
		</div>
	</div>

</script>

<script type="text/javascript">
	function loadList() {
		//파라미터에서 게시글 번호를 읽는다
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");

		//현재 사용자의 정보를 저장한다
		var loginId = "${sessionScope.loginId}";
		var loginNick = "${sessionScope.loginNick}";
		var isLogin = loginId.length>0;
		
		//페이지 로딩 완료 시 댓글 목록을 불러와서 출력
		$.ajax({
			url : "/rest/reply/list",
			method : "post",
			data : {
				replyOrigin : boardNo
			},
			success : function(response) {
				//댓글 개수를 표시
				$(".reply-count").text(response.length);

				//기존에 있는 내용을 지우도록 지시
				$(".reply-list-wrapper").empty();//비워라

				//내용을 목록에 출력
				//response는 List<ReplyDto>형태
				for (var i = 0; i < response.length; i++) {
					//template 불러오고
					var templateText = $("#reply-item-wrapper").text();
					var templateHTML = $.parseHTML(templateText);

					//정보출력
					$(templateHTML).find(".reply-writer").text(
							response[i].replyWriter);
					$(templateHTML).find(".reply-content").text(
							response[i].replyContent);
					$(templateHTML).find(".reply-time").text(
							response[i].replyTime);

					//화면에 필요한 전보를 추가(ex:삭제버튼에 번호 설정)
					//- data라는 명형으로는 읽기만 가능
					//- 태그에 글자를 추가하고 싶다면 .attr()명령 사용
					//- 현재 로그인한 사용자의 댓글에만 버튼을 표시(나머진 삭제)
					if(isLogin && loginNick == response[i].replyWriter) {
						$(templateHTML).find(".btn-reply-edit")
												.attr("data-reply-no", response[i].replyNo);
						$(templateHTML).find(".btn-reply-delete")
												.attr("data-reply-no", response[i].replyNo);
					}
					else {
						$(templateHTML).find(".btn-reply-edit").remove();
						$(templateHTML).find(".btn-reply-delete").remove();
					}

					//화면추가
					$(".reply-list-wrapper").append(templateHTML);

				}
			}
		});
	}

	$(function() {
		//최초에 목록 불러오기
		loadList();

		//문서에 댓글 삭제 이벤트 등록
		//- 화면을 지우는 것이 아니라 서버에 지워달라고 요청을 해야한다
		//- 삭제가 완료되면 화면을 직접 지우지 말고 목록을 다시 불러온다
		$(document).on("click", ".btn-reply-delete", function() {
			var choice = window.confirm("댓글을 삭제하시겠습니까?");
			if (choice == false)
				return;

			//태그에 심어져 있는 번호 정보를 읽어와서 삭제하도록 요청
			var replyNo = $(this).data("reply-no");

			$.ajax({
				url : "/rest/reply/delete",
				method : "post",
				data : {
					replyNo : replyNo
				},
				success : function(response) {
					loadList(); //삭제가 완료되면 목록 불러오기
				}
			});
		});

		//댓글 등록
		$(".btn-reply-insert").click(function() {
			//등록에 필요한 정보(내용, 소속글번호)를 구해온다
			var replyContent = $(".reply-editor").val();
			if (replyContent.length == 0)
				return; //비어있는 경우만 차단

			var params = new URLSearchParams(location.search);
			var boardNo = params.get("boardNo");

			$.ajax({
				url : "/rest/reply/insert",
				method : "post",
				data : {
					replyContent : replyContent,
					replyOrigin : boardNo
				},
				success : function(response) {
					$(".reply-editor").val(""); //에디터 내용 삭제
					loadList(); //등록 완료시 목록 갱신
				}
			});
		});

		//문서에 댓글 수정 이벤트 등록
		$(document).on(
				"click",
				".btn-reply-edit",
				function() {
					//(네이버)열려있는 모든 수정화면을 되돌린다
					$(".reply-item-edit").prev(".reply-item").show();
					$(".reply-item-edit").remove;

					//템플릿 불러와서 해석
					var templateText = $("#reply-item-edit-wrapper").text();
					var templateHtml = $.parseHTML(templateText);

					//댓글내용을 템플릿의 textarea에 설정
					var replyContent = $(this).parents(".reply-item").find(
							".reply-content").text();
					$(templateHtml).find(".reply-editor2").val(replyContent);

					//(추가) 변경버튼을 눌렀을 때 글번호를 알 수 있도록 설정
					var replyNo = $(this).data("reply-no");
					$(templateHtml).find(".btn-reply-save").attr(
							"data-reply-no", replyNo);
					//화면에 추가
					$(this).parents(".reply-item").hide().after(templateHtml);
				});

		$(document).on(
				"click",
				".btn-reply-save",
				function() {
					//서버에 변경요청을 비동기로 보내고 나서 목록을 갱신
					//전송에 필요한 정보 - 글번호, 글내용

					var replyNo = $(this).data("reply-no");
					var replyContent = $(this).parents(".reply-item-edit")
							.find(".reply-editor2").val();
					if (replyContent.length == 0)
						return;

					$.ajax({
						url : "/rest/reply/edit",
						method : "post",
						data : {
							replyNo : replyNo,
							replyContent : replyContent
						},
						success : function(response) {
							loadList(); //수정 완료 시 목록 갱신
						}
					});
				});

		$(document).on("click", ".btn-reply-cancel", function() {
			//수정용 화면을 제거하고 출력용 화면을 출력
			$(this).parents(".reply-item-edit").prev(".reply-item").show();
			$(this).parents(".reply-item-edit").remove();
		});
	});
</script>

<c:if test="${sessionScope.loginId != null}">
	<script>
		$(function() {
			//(주의) 아무리 같은 페이지라도 서로 다른 언어를 혼용하지 말것
			//- 자마스크립트네서 파라미터를 읽어 번호를 추출
			var params = new URLSearchParams(location.search);
			var boardNo = params.get("boardNo");

			//목표 : 하트를 클릭하면 좋아요 갱신처리
			$(".board-like").find(".fa-heart").click(
					function() {
						$.ajax({
							url : "/rest/board_like/toggle",//같은 서버이므로 앞 경로 생략
							method : "post",
							data : {
								boardNo : boardNo
							},
							success : function(response) {
								//console.log(response)

								//response.state에 따라서 하트의 형태를 설정
								$(".board-like").find(".fa-heart").removeClass(
										"fa-solid fa-regular").addClass(
										response.state ? "fa-solid"
												: "fa-regular");

								//response.count에 따라서 좋아요 개수를 표기
								$(".board-like").find(".count").text(
										response.count);
							}
						});
					});
		});
	</script>
</c:if>


<script type="text/javascript">
	//좋아요 최초 불러오기
	$(function() {
		//(주의) 아무리 같은 페이지라도 서로 다른언어를 혼용하지 말것
		//- 자바스크립트에서 파라미터를 읽어 번호를 추출
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");

		//최초에 표시될 화면을 위해 화면이 로딩되자마자 서버로 비동기 통신 시도
		$.ajax({
			url : "/rest/board_like/check",
			method : "post",
			data : {
				boardNo : boardNo
			},
			success : function(response) {
				//response.state에 따라서 하트의 형태를 설정
				$(".board-like").find(".fa-heart").removeClass(
						"fa-solid fa-regular").addClass(
						response.state ? "fa-solid" : "fa-regular");

				//response.count에 따라서 좋아요 개수를 표기
				$(".board-like").find(".count").text(response.count);
			}
		});
	});

	
</script>









<div class="container w-800">
	<div class="cell center">
		<h1>${boardDto.boardNo}번글보기</h1>
	</div>
	<div class="cell">
		<h2>
			제목: ${boardDto.boardTitle}

			<%--(추가) 수정시각 유무에 따라 수정됨 표시 --%>
			<c:if test="${boardDto.boardEditTime != null}">
				(수정됨)
			</c:if>
		</h2>
	</div>

	<div class="cell">
		<h4>
			<%-- 탈퇴한 사용자일 때와 아닐때 나오는 정보가 다르게 구현 --%>
			<c:choose>
				<c:when test="${boardDto.boardWriter == null}">
					${boardDto.boardWriterStr}
				</c:when>
				<c:otherwise>
					작성자: ${memberDto.memberNick}
					(${memberDto.memberGrade})
				</c:otherwise>
			</c:choose>
		</h4>
	</div>

	<div class="cell">
		마감시간
		<fmt:formatDate value="${boardDto.boardLimitTimeDate}"
			pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
	</div>
	<div class="cell">
		<span id="countdown"></span>
	</div>

	<c:if test="${sessionScope.loginId != null}">
		<div>
			<a class="btn"
				href="http://localhost:8080/reportBoard/insert?reportBoardOrigin=${boardDto.boardNo}"><pre>신고</pre></a>
		</div>

	</c:if>
	<c:if test="${sessionScope.loginGrade == '관리자'}">
		신고 횟수 : ${reportCountByReportBoardOrigin}
	</c:if> 
	
	<hr>
	<div class="cell" style="min-height: 250px">
		<%--
				HTML은 엔터와 스페이스 등을 무시하기 때문에 textarea와 모양이 달라진다
				사용 에디터를 쓰면 알아서 글자를 보정해주기 때문에 문제가 없다
				기본 textarea를 쓰면 문제가 발생한다
				<pre>태그를 사용하면 글자를 있는 그대로 출력한다
				-Rich Text Editor 를 사용하면 문제가 해결된다(ex: summernote)
			 --%>
		${boardDto.boardContent}
	</div>
	<hr>
	<div class="cell">
		조회수 ${boardDto.boardView} <span class="board-like red"> <i
			class="fa-regular fa-heart"></i> <span class="count">?</span>
		</span>

	</div>
	<div class="cell">
		<fmt:formatDate value="${boardDto.boardWriteTime}"
			pattern="yy-MM-dd HH:mm:ss" />
	</div>
	<div class="cell">${boardDto.boardWriteTimeDiff}</div>

	<div class="cell right">
		<a class="btn" href="write?category=${boardDto.boardCategory}">글쓰기</a>
		<%-- 
			수정과 삭제 링크는 회원이면서 본인글이거나 관리자일 경우만 출력 
			- 본인글이란 로그인한 사용자 아이디와 게시글 작성자가 같은 경우
			- 관리자란 로그인한 사용자 등급이 '관리자'인 경우
		--%>
		<c:if
			test="${sessionScope.loginId != null && (sessionScope.loginId == boardDto.boardWriter || sessionScope.loginGrade == '관리자')}">
			<a class="btn negative" href="edit?boardNo=${boardDto.boardNo}">글수정</a>
			<a class="btn negative link-confirm" data-message="정말 삭제하시겠습니까?"
				href="delete?boardNo=${boardDto.boardNo}">글삭제</a>
		</c:if>
		<a class="btn positive" href="list?category=${boardDto.boardCategory}">글목록</a>
	</div>

	<!-- 댓글 작성창 + 댓글 목록 -->
	<div class="cell">
		<span class="reply-count">0</span>개의 댓글이 있습니다
		<hr>
	</div>
	<div class="cell reply-list-wrapper">
		<div class="reply-item">
			<h3>
				<span class="reply-writer">작성자</span> <i
					class="fa-solid fa-edit blue ms-20 btn-reply-edit"></i> <i
					class="fa-solid fa-trash red btn-reply-delete"></i>
			</h3>
			<pre class="reply-content">댓글 내용</pre>
			<div class="reply-time">yyyy-MM-dd HH:mm:ss</div>

			<c:if
				test="${sessionScope.loginId != null && (sessionScope.loginId == boardDto.boardWriter || sessionScope.loginGrade == '관리자')}">
				<div>
					<a class="btn"
						href="http://localhost:8080/reportBoard/insert?reportBoardOrigin=${boardDto.boardNo}"><pre>신고</pre></a>
				</div>
			</c:if>

		</div>
		<div class="reply-item-edit">
			<textarea class="tool w-100 reply-editor2" style="min-height: 150px"></textarea>
			<div class="right">
				<button class="btn positive btn-reply-save">
					<i class="fa-solid fa-check"></i> 변경
				</button>
				<button class="btn negative btn-reply-cancel">
					<i class="fa-solid fa-xmark"></i> 취소
				</button>
			</div>
		</div>
	</div>

	<!-- 로그인이 딘 경우만 댓글 작성란이 활성화 되도록 구현 -->
	<c:choose>
		<c:when test="${sessionScope.loginId != null}">
			<div class="cell">
				<textarea class="tool w-100 reply-editor" style="min-height: 150px"
					placeholder="댓글 내용을 입력하세요"></textarea>
			</div>
			<div class="cell">
				<button class="btn positive w-100 btn-reply-insert">
					<i class="fa-solid fa-pen"></i> 댓글 작성
				</button>
			</div>
		</c:when>
		<c:otherwise>
			<div class="cell">
				<textarea class="tool w-100 reply-editor" style="min-height: 150px"
					placeholder="로그인 후 댓글 작성이 가능합니다" disabled></textarea>
			</div>
			<div class="cell">
				<button class="btn positive w-100 btn-reply-insert" disabled>
					<i class="fa-solid fa-ban"></i> 댓글 작성(로그인 후 이용 가능)
				</button>
			</div>
		</c:otherwise>
	</c:choose>
</div>


<script type="text/javascript">
	// 마감 시간 설정 (YYYY, MM, DD, HH, MM, SS 순서)
    var endTime = new Date(${boardDto.boardLimitTimeDate.year + 1900}, ${boardDto.boardLimitTimeDate.month}, ${boardDto.boardLimitTimeDate.date}, ${boardDto.boardLimitTimeDate.hours}, ${boardDto.boardLimitTimeDate.minutes}, ${boardDto.boardLimitTimeDate.seconds});

    // 1초마다 업데이트
    var timer = setInterval(updateCountdown, 1000);

    function updateCountdown() {
        var now = new Date();
        var distance = endTime - now;

        // 마감 시간이 지난 경우
        if (distance < 0) {
            clearInterval(timer);
            document.getElementById("countdown").innerHTML = "마감되었습니다.";
            return;
        }

        // 일, 시, 분, 초 계산
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // 결과 표시
        document.getElementById("countdown").innerHTML = "마감까지 " + days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초 남음";
    }

    // 페이지 로드 시 초기화
    updateCountdown();
    </script>