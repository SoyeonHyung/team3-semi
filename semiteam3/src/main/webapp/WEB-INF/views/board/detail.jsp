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

.title {
	font-size: 30px;
}

.info {
	color: #8395a7;
}

.detail {
	border: none;
	height: 1px;
	background-color: #e3c7a6;
}

.reply {
	color: #1dd1a1;
}

.board-like, .btn-board-report, .fa-bell {
	color: #ee5253;
}

.title2 {
	background-color: #f0eae2;
}

.reply-writer {
    font-weight: 500;
}

.btn-reply-edit:hover,
.btn-reply-delete:hover {
    color: #f3a683;
    cursor: pointer;
}

.not-bell {
	font-weight: 450;
}

.not-bell:hover {
	text-decoration: none;
	cursor: pointer;
	color: #f3a683;
}

.btn-reply-report {
	font-size: 15px;
	cursor: pointer;
}
.btn-edit{
 	background-color:#F2D692;
 	color:#fff;
}
div > p > img{
	max-width:960px;
}

div > p > img{
	max-width:960px;
}

.author {
	font-size: 10px;
	background-color: #778beb;
	border-radius: 2em;
	padding: 5px 7px;
	color: white;
}




</style>


<script type="text/template" id="reply-item-wrapper">
<div class="cell">
	<div class="reply-item mx-20">
		<div class="cell flex-cell">
			<div class="cell w-50 left">
				<i class="fa-regular fa-comment-dots"></i>
				<span class="reply-writer">작성자</span>
				<span class="info">
					<span class="author">작성자</span>
				(</span>
				<span class="reply-time info">yyyy-MM-dd HH:mm:ss</span>
				<span class="info">)</span>
			</div>
			<div class="cell width-fill right info">
				<span class="btn-reply-edit">수정<span class="reply-edit-delete-bar"> | </span></span>
				<span class="btn-reply-delete">삭제</span>
			</div>
				<i class="fa-solid fa-bell btn-reply-report ms-10 my-15"><span class="btn-reply-report not-bell"> 신고</span></i>
		</div>
	<pre class="reply-content"> 댓글 내용</pre>
			<%-- <c:if test="${sessionScope.loginId != null && sessionScope.loginId != boardDto.boardWriter}">  --%>
	</div>
	<hr class="detail">
	
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

<!-- 댓글 신고 관련 -->
<script type="text/template" id="reply-item-report-wrapper">
    <div class="reply-item-report">
        <hr class="detail">
		<h4>댓글 신고</h4> 
        <select name="reportReplyReason" required class="tool w-100 reply-report-reason">
            <option value="">신고사유</option>
            <option value="욕설/비방">욕설/비방</option>
            <option value="광고">광고</option>
            <option value="무의미한 글">무의미한 글</option>
        </select>
        <textarea class="tool w-100 reply-report-content" style="min-height: 150px"></textarea>
        <div class="right">
            <button class="btn positive btn-reply-report-save">
                <i class="fa-solid fa-check"></i>
                신고하기
            </button>
            <button class="btn negative btn-reply-report-cancel">
                <i class="fa-solid fa-xmark"></i>
                취소
            </button>
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
	var isLogin = loginId.length > 0;
	var loginGrade = "${sessionScope.loginGrade}";
	
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
				if (loginGrade == '관리자'){//관리자면
					$(templateHTML).find(".btn-reply-edit").remove();
					$(templateHTML).find(".btn-reply-delete").attr( //삭제버튼 보여주기
							"data-reply-no", response[i].replyNo);
					$(templateHTML).find(".btn-reply-report").remove();
					$(templateHTML).find(".reply-edit-delete-bar").remove();
				}
				
				//if (isLogin && (loginNick == response[i].replyWriter || loginGrade == '관리자')) {//로그인되엇고 본인 댓글일때 
				else if (isLogin && loginNick == response[i].replyWriter) {//로그인되엇고 본인 댓글일때  
					$(templateHTML).find(".btn-reply-edit").attr(
							"data-reply-no", response[i].replyNo);
					$(templateHTML).find(".reply-edit-delete-bar").show();
					$(templateHTML).find(".btn-reply-delete").attr(
							"data-reply-no", response[i].replyNo);

					$(templateHTML).find(".btn-reply-report").remove();//신고는 못해

				} else {
					$(templateHTML).find(".btn-reply-edit").remove();
					$(templateHTML).find(".reply-edit-delete-bar").remove();
					$(templateHTML).find(".btn-reply-delete").remove();

					if (isLogin) {
						$(templateHTML).find(".btn-reply-report").attr(
								"data-reply-no", response[i].replyNo);
					} else {
						$(templateHTML).find(".btn-reply-report").remove();
					}
				}

         // 작성자 표시 (게시글 작성자와 동일하면 보여줌)
			if (response[i].replyWriter === response[i].boardWriter) {
			    $(templateHTML).find(".author").show();
			} else {
			    $(templateHTML).find(".author").hide();
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
			var params = new URLSearchParams(location.search);
			var boardNo = params.get("boardNo");
			
			$.ajax({
				url : "/rest/reply/delete",
				method : "post",
				data : {
					replyNo : replyNo,
					replyOrigin : boardNo
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
<%-- 댓글 신고 이벤트 --%>
	$(document)
				.on(
						"click",
						".btn-reply-report",
						function() {
							// 신고 창이 이미 열려있는지 확인
							//(추가) 신고버튼을 눌렀을 때 댓글번호를 알 수 있도록 설정
							//var reportReplyOrigin = $(this).parents(".reply-item").data("reply-no");
							var reportReplyOrigin = $(this).data("reply-no");

							if ($(".reply-item-report").length > 0) {
								return; // 이미 열려있으면 아무 것도 하지 않음
							}

							// 신고 창을 보여줌
							var templateText = $("#reply-item-report-wrapper")
									.text();
							var templateHTML = $.parseHTML(templateText);
							$(this).parents(".reply-item").after(templateHTML);

							// 신고 등록 버튼 클릭 시
							$(document)
									.one(
											"click",
											".btn-reply-report-save",
											function() {
												//댓글 번호 불러오기
												console.log(reportReplyOrigin);
												var reportReplyReason = $(
														".reply-report-reason")
														.val();
												var reportReplyContent = $(
														".reply-report-content")
														.val();

												// 신고 사유와 내용이 입력되었는지 확인
												if (reportReplyReason.length == 0
														|| reportReplyContent.length == 0) {
													alert("신고 사유와 내용을 모두 입력해주세요.");
													return;
												}

												// AJAX를 통해 신고 등록 요청
												$
														.ajax({
															url : "/rest/reportReply/insert",
															method : "post",
															data : {
																reportReplyReason : reportReplyReason,
																reportReplyContent : reportReplyContent,
																reportReplyOrigin : reportReplyOrigin
															// 댓글 번호 추가
															},
															success : function(
																	response) {
																// 신고 완료 후 신고 창을 숨김
																$(
																		".reply-item-report")
																		.remove();
																alert("댓글 신고가 완료되었습니다.");
															}
														});
											});

							// 취소 버튼 클릭 시
							$(document).on("click", ".btn-reply-report-cancel",
									function() {
										// 신고 창을 숨김
										$(".reply-item-report").remove();
									});
						});
	});
	
	//모집 중 or 모집완료 일 때 카운트다운 색상 변경
		document.addEventListener('DOMContentLoaded', function() {
		    var countdownElement = document.getElementById('countdown');
		    var boardStatus = '${boardDto.boardStatus}'; // boardDto.boardStatus 값
		
		    if (boardStatus === '모집 중') {
		        countdownElement.style.color = '#10ac84'; // 모집 중일 때의 색상
		    } else if (boardStatus === '모집 완료') {
		        countdownElement.style.color = '#ff6b6b'; // 모집 완료일 때의 색상
		    }
		});
	
	
	
	
	//모집 완료 됐다면 글 수정 못하게
	$(document).on("click", ".btn-edit", function() {
	    var boardStatus = '${boardDto.boardStatus}';
	    if (boardStatus === '모집 완료') {
	        window.alert('모집이 완료된 글은 수정할 수 없습니다.');
	        return false;
	    }
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
		
		//리스트 글자색상 변경
		window.onload = function() {
			// 클래스 이름이 "status"인 모든 엘리먼트를 가져옵니다.
			var statusElements = document.querySelectorAll('.status');

			statusElements.forEach(function(statusElement) {
				var boardStatus = statusElement.textContent.trim();

				if (boardStatus === '모집 중') {
					statusElement.style.color = '#10ac84'; // 모집 중일 때의 색상
				} else if (boardStatus === '모집 완료') {
					statusElement.style.color = '#ff6b6b'; // 모집 완료일 때의 색상
				}
			});
		};
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
	
	window.onload = function() {
		var statusElements = document.querySelectorAll('.status');

		statusElements.forEach(function(statusElement) {
			var boardStatus = statusElement.textContent.trim();

			if (boardStatus === '모집 중') {
				statusElement.style.color = '#10ac84'; // 모집 중일 때의 색상
			} else if (boardStatus === '모집 완료') {
				statusElement.style.color = '#ff6b6b'; // 모집 완료일 때의 색상
			}
		});
	};
</script>

<div class="container" style="display: flex; width: 1300px;">
	<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	<div class="container">
		<div class="container w-1000 set-color">
			<div class="cell title left">${boardDto.boardTitle}</div>
			<div class="cell flex-cell info">
				<div class="cell w-50 left">
					<c:if test="${boardDto.boardCategory == '축구'}">
			축구
		</c:if>
					<c:if test="${boardDto.boardCategory == '야구'}">
						<i class="fa-solid fa-baseball"></i> 야구  
		</c:if>
					<c:if test="${boardDto.boardCategory == '농구'}">
						<i class="fa-solid fa-basketball"></i> 농구 
		</c:if>
					<c:if test="${boardDto.boardCategory == 'E-스포츠'}">
						<i class="fa-solid fa-gamepad"></i> 게임 
		</c:if>
					<c:if test="${boardDto.boardCategory == '관리자'}">
						<i class="fa-solid fa-gear"></i> 공지 
		</c:if>
					| ${boardDto.boardWriteTimeDiff}
					<%--(추가) 수정시각 유무에 따라 수정됨 표시 --%>
					<c:if test="${boardDto.boardEditTime != null}">
				(수정됨)
			</c:if>
					|
					<%-- 탈퇴한 사용자일 때와 아닐때 나오는 정보가 다르게 구현 --%>
					<c:choose>
						<c:when test="${boardDto.boardWriter == null}">
					${boardDto.boardWriterStr}
				</c:when>
						<c:otherwise>
					${memberDto.memberNick}
				</c:otherwise>
					</c:choose>
				</div>

				<div class="cell w-50 right">
					조회수 ${boardDto.boardView} | <i class="fa-regular fa-comment-dots"></i>
					댓글 <span class="reply-count">0</span> | <span class="board-like">
						<i class="fa-regular fa-heart"></i> <span class="count">?</span>
					</span>
				</div>
			</div>

			<c:if test="${memberDto.memberGrade != '관리자'}">
				<div class="cell flex-cell">

					<div class="cell w-50 left info">
						<c:if test="${not empty boardDto.boardLimitTimeDate}">
				모집기간
				<fmt:formatDate value="${boardDto.boardWriteTime}"
								pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
				~
				<fmt:formatDate value="${boardDto.boardLimitTimeDate}"
								pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>

							<div class="cell">
								<span id="countdown"></span>
							</div>
						</c:if>
					</div>

					<div class="cell w-50 right">

						<c:if test="${sessionScope.loginId != null}">
							<a class="link btn-board-report"
								href="http://localhost:8080/reportBoard/insert?reportBoardOrigin=${boardDto.boardNo}">
								<i class="fa-solid fa-bell btn-board-report"></i> 신고
							</a>
						</c:if>
						<div class="cell">
							<c:if test="${sessionScope.loginGrade == '관리자'}">
								신고 횟수 : ${reportCountByReportBoardOrigin}
							</c:if>
						</div>

					</div>

				</div>
			</c:if>




			<hr class="detail">

			<div class="cell" style="min-height: 250px">
				${boardDto.boardContent}</div>

			<hr class="detail">

			<div class="cell right">
				<a class="btn" href="write?category=${boardDto.boardCategory}">글쓰기</a>

				<%-- 수정과 삭제 링크는 회원이면서 본인글이거나 관리자일 경우만 출력 --%>
				<c:if
					test="${sessionScope.loginId != null && (sessionScope.loginId == boardDto.boardWriter || sessionScope.loginGrade == '관리자')}">
					<a class="btn btn-edit"
						href="edit?boardNo=${boardDto.boardNo}">글수정</a>
					<a class="btn negative link-confirm" data-message="정말 삭제하시겠습니까?"
						href="delete?boardNo=${boardDto.boardNo}">글삭제</a>
				</c:if>

				<c:choose>
					<c:when test="${boardDto.boardCategory == '관리자'}">
						<a class="btn positive" onclick="history.back()">글목록</a>
					</c:when>
					<c:otherwise>
						<a class="btn positive"
							href="list?category=${boardDto.boardCategory}">글목록</a>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- 댓글 작성창 + 댓글 목록 -->
			<div class="cell">
				<hr class="detail">
			</div>
			<div class="cell reply-list-wrapper ">
				<div class="reply-item">
					<div class="cell flex-cell mx-20">
						<div class="cell w-50 left">
							<i class="fa-regular fa-comment-dots"></i> <span class="reply-writer">작성자</span>
							<span class="info">
							    <span class="author">작성자</span>
							(</span> <span class="reply-time info">yyyy-MM-dd
								HH:mm:ss</span> <span class="info">)</span>
						</div>
						<div class="cell w-50 right info">
							<span class="btn-reply-edit">수정<span class="reply-edit-delete-bar"> | </span></span>
							<span class="btn-reply-delete">삭제</span>
						</div>
							<i class="fa-solid fa-bell btn-reply-report ms-10 my-15"><span class="btn-reply-report not-bell"> 신고</span></i>
					</div>

					<pre class="reply-content">댓글 내용</pre>

					<c:if
						test="${sessionScope.loginId != null && (sessionScope.loginId == boardDto.boardWriter || sessionScope.loginGrade == '관리자')}">
						<div>
							<a class="btn"
								href="http://localhost:8080/reportBoard/insert?reportBoardOrigin=${boardDto.boardNo}">신고</a>
						</div>
					</c:if>

				</div>
				<div class="reply-item-edit">
					<textarea class="tool w-100 reply-editor2"
						style="min-height: 150px"></textarea>
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
						<textarea class="tool w-100 reply-editor"
							style="min-height: 150px" placeholder="댓글 내용을 입력하세요"></textarea>
					</div>
					<div class="cell">
						<button class="btn positive w-100 btn-reply-insert">
							<i class="fa-solid fa-pen"></i> 댓글 작성
						</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="cell">
						<textarea class="tool w-100 reply-editor"
							style="min-height: 150px" placeholder="로그인 후 댓글 작성이 가능합니다"
							disabled></textarea>
					</div>
					<div class="cell">
						<button class="btn positive w-100 btn-reply-insert" disabled>
							<i class="fa-solid fa-ban"></i> 댓글 작성(로그인 후 이용 가능)
						</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>

		<c:if test="${memberDto.memberGrade != '관리자'}">
			<div class="cell m-30"></div>


			<div class="container w-1000 set-color">
				<div class="cell">
					<table class="table table-horizontal table-hover">
						<c:forEach var="boardDto" items="${list}">
							<c:choose>
								<c:when test="${param.boardNo == boardDto.boardNo}">
									<tr class="title2">
								</c:when>
								<c:otherwise>
									<tr>
								</c:otherwise>
							</c:choose>
							<td class="left" width="70%">
								<div class="my-10">
									<a class="link" href="detail?boardNo=${boardDto.boardNo}">
										${boardDto.boardTitle} <span class="reply">[${boardDto.boardReply}]</span>
									</a>
								</div>
								<div class="info my-10">
									모집기간
									<fmt:formatDate value="${boardDto.boardWriteTime}"
										pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
									~
									<fmt:formatDate value="${boardDto.boardLimitTimeDate}"
										pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
									| ${boardDto.boardWriterStr}
								</div>
							</td>
							<td class="info">${boardDto.boardWriteTimeStr}
								<p class="my-10">
									조회수
									<fmt:formatNumber value="${boardDto.boardView}"
										pattern="###,###"></fmt:formatNumber>
								</p>
							</td>
							<td>
								<div class="status">${boardDto.boardStatus}</div>
							</td>
						</c:forEach>
					</table>
				</div>



				<div class="cell center">
					<jsp:include page="/WEB-INF/views/template/detailNavigator.jsp"></jsp:include>
				</div>

				<div class="cell center">
					<%-- 검색창 --%>
					<form action="list" method="get">
						<!-- 카테고리를 넘겨줘야함 -->
						<input type="hidden" name="category"
							value="${boardDto.boardCategory}"> <select name="column"
							class="tool">
							<option value="board_title"
								${param.column == 'board_title' ? 'selected' : ''}>제목</option>
							<option value="board_content"
								${param.column == 'board_content' ? 'selected' : ''}>내용</option>
							<option value="member_nick"
								${param.column == 'member_nick' ? 'selected' : ''}>작성자</option>
						</select> <input class="tool" type="search" name="keyword"
							placeholder="검색어 입력" value="${param.keyword}">
						<button class="btn positive empty-check">검색</button>
					</form>
				</div>
			</div>
		</c:if>
	</div>
</div>
</body>

<%--이유는 모르겠지만 이걸 밑에 넣어야 로드가 빨리됨 --%>
<script type="text/javascript">
    // 마감 시간 설정 (YYYY, MM, DD, HH, MM, SS 순서)
    <c:if test="${not empty boardDto.boardLimitTimeDate && memberDto.memberGrade ne '관리자'}">
        var endTime = new Date(
            ${boardDto.boardLimitTimeDate.year + 1900}, 
            ${boardDto.boardLimitTimeDate.month}, 
            ${boardDto.boardLimitTimeDate.date}, 
            ${boardDto.boardLimitTimeDate.hours}, 
            ${boardDto.boardLimitTimeDate.minutes}, 
            ${boardDto.boardLimitTimeDate.seconds}
        );

        // 1초마다 업데이트
        var timer = setInterval(updateCountdown, 1000);

        function updateCountdown() {
            var now = new Date();
            var distance = endTime - now;

            // 마감 시간이 지난 경우
            if (distance < 0) {
                clearInterval(timer);
                document.getElementById("countdown").innerHTML = "마감되었습니다.";
                document.getElementById("countdown").style.color = "#ff6b6b";
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
    </c:if>
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>