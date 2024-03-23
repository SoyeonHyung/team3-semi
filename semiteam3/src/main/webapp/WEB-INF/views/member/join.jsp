<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="/js/exit.js"></script>
<head>

</head>


<style>
input[name=memberId] {
	background-image: url("/image/joinImage/user-login.png");
}

input[name=memberPw], input[id="pw-reinput"] {
	background-image: url("/image/joinImage/lock-login.png");
}

input[name=memberNick] {
	background-image: url("/image/joinImage/nickname.png");
}

input[name=memberBirth] {
	background-image: url("/image/joinImage/calendar.png");
}

input[name=memberContact] {
	background-image: url("/image/joinImage/telephone.png");
}

input[name=memberEmail] {
	background-image: url("/image/joinImage/email.png");
}

input[name=memberPost] {
	background-image: url("/image/joinImage/post.png");
}

input[name=memberAddress1] {
	background-image: url("/image/joinImage/letterbox.png");
}

input[name=memberAddress2] {
	background-image: url("/image/joinImage/home.png");
}

input[name=memberId],[name=memberPw],[id="pw-reinput"],[name=memberNick] ,
[name=memberBirth], [name=memberContact],[name=memberEmail], [name=memberPost],
[name=memberAddress1],[name=memberAddress2]  
{
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

.fa-asterisk {
	color: red;
}
.box {
	width: 500px;
	background-color: #f8f9fa;
	color: #333;
	padding: 20px;
	height: fit-content;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}
.btn-prev{
	border: none;
}
.btn-next{
	border: none;
}

</style>

<script type="text/template" id="cert-template">
        <div>
            <input type="text" class="tool cert-input" placeholder="인증번호">
            <button type="button" class="btn btn-check-cert positive ms-10">
                <i class="fa-solid fa-check"></i>
            </button>
            <div class="success-feedback">이메일 인증이 완료되었습니다</div>
            <div class="fail-feedback">인증번호를 확인해주세요</div>
        </div>
  </script>

<script type="text/javascript">
	$(function() {
		//이전, 다음 버튼을 누르면 표시된 페이지의 순서에 맞게 진행바 변경
		calculatePercent(1);

		$(".page").find(".btn-prev").click(function() {
			//표시되는 페이지가 몇 번째인가?
			//-> $(대상).index(전체대상)
			//-> 대상은 :visible 이라고 붙이면 표시된 항목을 찾아준다(jQuery 전용)
			var index = $(".page:visible").index(".page") + 1;
			calculatePercent(index);
		});
		$(".page").find(".btn-next").click(function() {
			var index = $(".page:visible").index(".page") + 1;
			calculatePercent(index);
		});

		function calculatePercent(page) {
			var total = $(".page").length;
			var percent = page * 100 / total;
			$(".progressbar > .guage").css("width", percent + "%");
		}
	});

	$(function() {
		//상태객체(React의 state로 개념이 이어짐)
		var state = {
			//key : value
			memberIdValid : false,
			memberPwValid : false,
			memberPwCheckValid : false,
			memberNickValid : false,
			memberEmailValid : false,//수정
			memberBirthValid : true, //선택항목
			memberContactValid : true, //선택항목
			memberAddressValid : true,//선택항목
			//객체에 함수를 변수처럼 생성할 수 있다
			//- this는 객체 자신(자바와 동일하지만 생략이 불가능)
			ok : function() {
				return this.memberIdValid && this.memberPwValid
						&& this.memberPwCheckValid && this.memberNickValid
						&& this.memberEmailValid && this.memberBirthValid
						&& this.memberContactValid && this.memberAddressValid;
			},
		};

		$("[name=memberId]").blur(
				function() {
					var regex = /^[a-z][a-z0-9]{7,19}$/;
					var value = $(this).val();

					if (regex.test(value)) {//아이디 형식 검사를 통과했다면
						$.ajax({
							url : "/rest/member/checkId",
							method : "post",//전송방식(get/post)
							data : {
								memberId : value
							},
							success : function(response) {
								//console.log(response);
								if (response == "unable") {
									$("[name=memberId]").removeClass(
											"success fail fail2").addClass(
											"fail2");
									state.memberIdValid = false;
								} else if (response == "able") {
									$("[name=memberId]").removeClass(
											"success fail fail2").addClass(
											"success");
									state.memberIdValid = true;
								}
							}
						});
					} else {//아이디가 형식검사를 통과하지 못했다면
						$("[name=memberId]").removeClass("success fail fail2")
								.addClass("fail");
						state.memberIdValid = false;
					}
				});
		
		$("[name=memberPw]")
				.on(
						"blur",
						function() {
							var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$])[a-zA-Z\d!@#$]{6,15}$/;
							state.memberPwValid = regex.test($(this).val());
							$(this).removeClass("success fail").addClass(
									state.memberPwValid ? "success" : "fail");
						});
		$("#pw-reinput").blur(
				function() {
					var memberPw = $("[name=memberPw]").val();
					state.memberPwCheckValid = memberPw == $(this).val();

					if (memberPw.length == 0) {
						$(this).removeClass("success fail fail2").addClass(
								"fail2");
					} else {
						$(this).removeClass("success fail fail2").addClass(
								state.memberPwCheckValid ? "success" : "fail");
					}
				});
		$("[name=memberNick]").blur(
				function() {
					var regex = /^[가-힣0-9]{2,10}$/;
					var value = $(this).val();

					if (regex.test(value)) {
						$.ajax({
							url : "/rest/member/checkMemberNick",
							method : "post",
							data : {
								memberNick : value
							},
							success : function(response) {
								if (response) {//사용 가능한 경우 - success
									state.memberNickValid = true;
									$("[name=memberNick]").removeClass(
											"success fail fail2").addClass(
											"success");
								} else {//이미 사용중인 경우 - fail2
									state.memberNickValid = false;
									$("[name=memberNick]").removeClass(
											"success fail fail2").addClass(
											"fail2");
								}
							}
						});
					} else {//형식이 맞지 않는 경우 - fail
						state.memberNickValid = false;
						$("[name=memberNick]")
								.removeClass("success fail fail2").addClass(
										"fail");
					}
				});
		//인증을 마쳤는데 이메일칸에 추가 입력을 하는 경우는 모든 상태를 초기화
		//- 이메일 판정 취소
		//- 인증번호 입력창 제거
		//- 이메일 피드백 제거
		
		$("[name=memberEmail]").on("input", function(){
			if(state.memberEmailValid){
				state.memberEmailValid = false;
				$(this).removeClass("success fail");				
				$(".cert-wrapper").empty();
			}
		})


		//이메일 입력을 마친 상황일 때 잘못 입력한 경우만큼은 상태를 갱신
		$("[name=memberEmail]")
				.blur(
						function() {
							var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
							var value = $(this).val();

							var isValid = regex.test(value);

							if (isValid == false) {
								state.memberEmailValid = false;
							}

							$(this).removeClass("success fail").addClass(
									isValid ? "success" : "fail");

							//뒤에 있는 보내기 버튼을 활성화 또는 비활성화
							$(this)
									.next(".btn-send-cert")
									.prop("disabled", !isValid)
									.removeClass("positive negative")
									.addClass(isValid ? "positive" : "negative");
						});

		//인증 메일 보내기 이벤트
		var memberEmail;
		$(".btn-send-cert").click(function(){
			var btn = this;
			$(btn).find("i").removeClass("fa-regular fa-paper-plane")
							.addClass("fa-solid fa-spinner fa-spin");
			//보내기 버튼을 누르면 이메일 수정 불가
			$(btn).prop("disabled", true);
			
			//이메일 불러오기
			var email = $("[name=memberEmail]").val();
			if(email.length == 0) return;
			
			$.ajax({
				url:"/rest/member/sendCert",
				method:"post",//제출
				data:{ memberEmail : email },
				
				success: function(response){//데이터가 전송됐을시
				
				        // 템플릿 불러와서 인증번호 입력창을 추가
				        var templateText = $("#cert-template").text();
				        var templateHtml = $.parseHTML(templateText);
				        $(".cert-wrapper").empty().append(templateHtml);

				        // 이메일 저장
				        memberEmail = email;

				},
						error : function() {
							alert("시스템 오류. 잠시 후 이용바람");
						},
						complete : function() {
							$(btn).find("i").removeClass(
									"fa-solid fa-spinner fa-spin").addClass(
									"fa-regular fa-paper-plane");
							$(btn).prop("disabled", false);
						},
					});
				});

		//인증번호 확인 이벤트
		$(document).on(
				"click",
				".btn-check-cert",
				function() {
					var number = $(".cert-input").val();//인증번호
					if (memberEmail == undefined || number.length == 0)
						return;

					$.ajax({
						url : "/rest/member/checkCert",
						method : "post",
						data : {
							certEmail : memberEmail,
							certNumber : number
						},
						success : function(response) {
							$(".cert-input").removeClass("success fail")
									.addClass(
											response === true ? "success"
													: "fail");

							if (response === true) {
								$(".btn-check-cert").prop("disabled", true);
								state.memberEmailValid = true;
							} else {
								state.memberEmailValid = false;
							}
						},
						error : function() {
							alert("오류");
						},
					});
				});

		$("[name=memberContact]").blur(
				function() {
					var regex = /^010[1-9][0-9]{7}$/;
					var value = $(this).val();
					state.memberContactValid = value.length == 0
							|| regex.test(value);
					$(this).removeClass("success fail").addClass(
							state.memberContactValid ? "success" : "fail");
				});
		$("[name=memberBirth]")
				.blur(
						function() {
							var regex = /^(19[0-9]{2}|20[0-9]{2})-(02-(0[1-9]|1[0-9]|2[0-8])|(0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))$/;
							var value = $(this).val();
							state.memberBirthValid = value.length == 0
									|| regex.test(value);
							$(this).removeClass("success fail")
									.addClass(
											state.memberBirthValid ? "success"
													: "fail");
						});

		//주소는 세 개의 입력창이 모두 입력되거나 안되거나 둘 중 하나
		$("[name=memberAddress2]")
				.blur(
						function() {
							var post = $("[name=memberPost]").val();
							var address1 = $("[name=memberAddress1]").val();
							var address2 = $("[name=memberAddress2]").val();

							var isClear = post.length == 0
									&& address1.length == 0
									&& address2.length == 0;
							var isFill = post.length > 0 && address1.length > 0
									&& address2.length > 0;

							state.memberAddressValid = isClear || isFill;

							$(
									"[name=memberPost], [name=memberAddress1], [name=memberAddress2]")
									.removeClass("success fail")
									.addClass(
											state.memberAddressValid ? "success"
													: "fail");
						});

		//form 전송
		$(".check-form").submit(function() {
			//$(this).find("[name], #pw-reinput").blur();
			//$(this).find(".tool").blur();//모든 창

			//입력창 중에서 success fail fail2가 없는 창
			$(this).find(".tool").not(".success, .fail, .fail2").blur();
			// 			console.table(state);
			// 			console.log(state.ok());

			return state.ok();
		});
	});
	<c:if test="${param.error != null}">
    alert("로그인 정보가 일치하지 않습니다");
</c:if>
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    $(function(){
        $(".btn-address-search").click(function(){
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    $("[name=memberPost]").val(data.zonecode);
                    $("[name=memberAddress1]").val(addr);
                    
                    // 커서를 상세주소 필드로 이동한다.
                    $("[name=memberAddress2]").focus();
                }
            }).open();
        });
        
        $(".btn-address-clear").click(function(){
        	$("[name=memberPost]").val("");
        	$("[name=memberAddress1]").val("");
        	$("[name=memberAddress2]").val("");
        });
    });
    
    
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

<div class="box cell container">
<form action="join" method="post" enctype="multipart/form-data"
	class="check-form free-pass"" autocomplete="off">

	<div class="container w-450">
		<div class="cell title center">
			<h1>회원가입</h1>
		</div>

		<!-- 진행바 -->
<!-- 		<div class="cell"> -->
<!-- 			<div class="progressbar"> -->
<!-- 				<div class="guage"></div> -->
<!-- 			</div> -->
<!-- 		</div> -->


		<!-- 1페이지 - 필수항목들만 모아놓음
							(아이디 / 비밀번호 + 확인 / 닉네임) -->
		<div class="cell page w-450">
		<div class="cell right">
			<p>
				<i class="fa-solid fa-asterisk" style="color:red"></i> 
				표시는 필수항목입니다.
			</p>
		</div>
			<div class="cell">
				 아이디 <i class="fa-solid fa-asterisk"></i>
				 <input type="text" name="memberId" class="tool tool-image w-100"
					placeholder="소문자 시작, 숫자포함 8~20자">
				<div class="success-feedback">멋진 아이디네요!</div>
				<div class="fail-feedback">아이디는 소문자 시작, 숫자 포함 8~20자로 작성하세요</div>
			</div>

			<div class="cell">
				비밀번호 <i class="fa-solid fa-asterisk"></i>
				 <input type="password" name="memberPw"
					class="tool tool-image w-100"
					placeholder="대소문자, 숫자, 특수문자(!@#$) 포함 6~15자">
				<div class="success-feedback">비밀번호가 올바른 형식입니다</div>
				<div class="fail-feedback">비밀번호에는 반드시 영문 대,소문자와 숫자, 특수문자가
					포함되어야 합니다</div>
			</div>

			<div class="cell">
				 비밀번호 확인 <i class="fa-solid fa-asterisk"></i>
				 <input type="password" placeholder="" id="pw-reinput"
					class="tool tool-image w-100">
				<div class="fail2-feedback">비밀번호를 먼저 입력하세요</div>
				<div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
				<div class="success-feedback">비밀번호가 일치합니다</div>
			</div>

			<div class="cell">
				 닉네임 <i class="fa-solid fa-asterisk"></i>
				 <input type="text" name="memberNick" class="tool tool-image w-100"
					placeholder="한글, 숫자 2~10글자(반드시 한글로 시작)">
				<div class="fail-feedback">닉네임은 한글 시작, 한글 또는 숫자 2~10자로 작성하세요</div>
				<div class="success-feedback">닉네임 형식이 일치합니다</div>
			</div>

			<div class="flex-cell">
				<div class="w-100 left"></div>
				<div class="w-100 right">
					<button type="button" class="btn btn-next w-100">
						다음
						<i class="fa-solid fa-angle-right"></i>
					</button>
				</div>
			</div>
		</div>


		<!-- 2페이지 - 필수항목 중 이메일 인증 -->
		<div class="cell page w-450">
		<div class="cell right">
			<p>
				<i class="fa-solid fa-asterisk" style="color:red"></i> 
				표시는 필수항목입니다.
			</p>
		</div>
			<div class="cell">
				이메일 <i class="fa-solid fa-asterisk"></i>
				
				<div class="flex-cell w-100" style="flex-wrap: wrap;">
					<input type="email" name="memberEmail"
						placeholder="test1234@kh.com" class="tool tool-image width-fill">
					<button type="button" class="btn positive btn-send-cert ms-10">
						<i class="fa-regular fa-paper-plane"></i>
					</button>
					<div class="fail-feedback w-100">잘못된 이메일 형식입니다</div>
					<div class="fail2-feedback w-100">잘못된 이메일 형식입니다</div>
				</div>
			</div>
			
			 <div class="cell cert-wrapper"></div>
			

			<div class="flex-cell">
				<div class="w-100 left">
					<button type="button" class="btn btn-prev w-100 pink">
						<i class="fa-solid fa-angle-left"></i>
						이전
					</button>
				</div>
				<div class="w-100 right">
					<button type="button" class="btn btn-next w-100">
						다음
						<i class="fa-solid fa-angle-right"></i>
					</button>
				</div>
			</div>
		</div>

		<!-- 3페이지 - 생년월일/연락처/주소 -->
		<div class="cell page  w-450">
			<div class="cell">
				 생년월일 <input name="memberBirth"
					class="tool tool-image w-100" type="date">
				
			</div>

			<div class="cell">
				 연락처  <input name="memberContact"
					class="tool tool-image w-100" type="tel">
			</div>

			<div class="cell">
				주소
			</div>
			<div class="cell">
				<input name="memberPost" class="tool tool-image w-50"
					placeholder="우편번호" type="text">
				<button type="button" class="btn positive btn-address-search">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
				<button type="button" class="btn negative btn-address-clear">
					<i class="fa-solid fa-xmark"></i>
				</button>
			</div>
			<div class="cell">
				<input name="memberAddress1" class="tool tool-image w-100"
					placeholder="기본주소" type="text">
			</div>
			<div class="cell">
				<input name="memberAddress2" class="tool tool-image w-100"
					placeholder="상세주소" type="text">
			</div>

			<div class="flex-cell">
				<div class="w-100 left">
					<button type="button" class="btn btn-prev w-100 pink">
						<i class="fa-solid fa-angle-left"></i>
						이전
					</button>
				</div>
				<div class="w-100 right">
					<button type="button" class="btn btn-next w-100">
						다음
						<i class="fa-solid fa-angle-right"></i>
					</button>
				</div>
			</div>
		</div>


		<!-- 4페이지 - 프로필사진 -->
		<div class="cell page w-450 center">
		
<div class="cell center">
    <form action="mypage" method="post" autocomplete="off" enctype="multipart/form-data" >
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
		<div class="gray-text">* 사진을 클릭하여 변경하세요</div>

	</form>
  </div>  
  	
				

				<div class="flex-cell">
				<div class="w-100 left">
					<button type="button" class="btn btn-prev w-100 pink">
						<i class="fa-solid fa-angle-left"></i>
						이전
					</button>
				</div>
				<div class="w-100 right">
					<button type="submit" class="btn positive w-100">회원가입</button>
				</div>
			</div>
		</div>



	</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
