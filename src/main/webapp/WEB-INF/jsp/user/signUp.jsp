<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="w-50 d-flex justify-content-center">
	<div class="col-5">
		<div class="d-flex justify-content-center">
			<h1>MEMO 회원가입</h1>
		</div>
		<form id="signUpForm" method="post" action="/user/sign-up">
			<div class="pt-4">
				<label for="name">이름</label> 
				<input type="text" id="name" name="name" class="form-control">
			</div>
			
			<div class="pt-2">
				<label for="loginId">아이디</label>
				<div class="d-flex justify-content-between">
					<input type="text" id="loginId" name="loginId" class="form-control col-9">
					<div>
						<button type="button" id="loginIdChkBtn" class="btn btn-success">중복확인</button>
					</div>
				</div>
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</div>
			
			<div class="pt-2">
				<label for="password">비밀번호</label> 
				<input type="password" id="password" name="password" class="form-control">
			</div>
			<div class="pt-2">
				<label for="passwordChk">비밀번호 확인</label> 
				<input type="password" id="passwordChk" name="passwordChk" class="form-control">
			</div>
			<div class="pt-2">
				<label for="email">이메일</label> 
				<input type="text" id="email" name="email" class="form-control">
			</div>
			<div class="pt-3">
				<button type="submit" id="signUpBtn" class="btn btn-primary col-12">회원가입</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		var usableId = null;
		
		$('#loginIdChkBtn').on('click', function() {
			// 경고 문구 초기화
			$('#idCheckLength').addClass("d-none");
			$('#idCheckDuplicated').addClass("d-none");
			$('#idCheckOk').addClass("d-none");
			
			let loginId = $("input[name=loginId]").val().trim();
			if (loginId.length < 4) {
				$('#idCheckLength').removeClass("d-none");
				return;
			}
			
			$.get("/user/is-duplicated-id", {"loginId" : loginId})
			.done(function(data) {
				// {"code":200, "is_duplicated_id":true} true:중복
				if (data.code == 200) {
					if (data.is_duplicated_id) {
						$('#idCheckDuplicated').removeClass("d-none");
					} else {
						$('#idCheckOk').removeClass("d-none");
						usableId = loginId;
					}
				} else {
					alert(data.error_message);
				}
				
			});
		});
		
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault();
			
			// alert("회원가입");
			
			// validation
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let passwordChk = $('#passwordChk').val().trim();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			if (!name) {
				alert("이름을 입력하세요");
				return false;
			}

			if (!loginId) {
				alert("아이디를 입력하세요");
				return false;
			}
			
			if (!password || !passwordChk) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			
			if (password != passwordChk) {
				alert("비밀번호가 일치하지 않습니다.")
				return false;
			}
			
			if (!email) {
				alert("이메일을 입력하세요");
				return false;
			}
			
			// 중복확인 후 사용 가능한 아이디인지
			if ($('#idCheckOk').hasClass('d-none') || usableId != loginId) {
				alert("중복확인을 진행해주세요");
				return false;
			}
			
			let url = $(this).attr('action');
			let params = $(this).serialize();
			
			$.post(url, params)
			.done(function(data) {
				if (data.code == 200) {
					alert("가입을 환영합니다. 로그인 해주세요.")
					location.href = "/user/sign-in-view";
				} else {
					alert(data.error_message);
				}
			});
		});
	});
</script>