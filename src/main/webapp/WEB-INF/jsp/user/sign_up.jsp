<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box m-3">
		<h1 class="mb-4">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<table class="sign-up-table table table-bordered">
				<tr>
					<th>* 아이디(4자 이상)<br></th>
					<td>
						<div class="d-flex">
							<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요." autocomplete="off">
							<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button><br>
						</div>					
						<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요." autocomplete="off"></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td><input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요." autocomplete="off"></td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td><input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요." autocomplete="off"></td>
				</tr>
				<tr>
					<th>* 이메일</th>
					<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요." autocomplete="off"></td>
				</tr>
			</table>
		
			<button type="button" id="signUpBtn" class="btn btn-primary float-right">회원가입</button>
		</form>
	</div>
</div>
<script>
	$(document).ready(function() {
		var idData = "";
		
		//아이디 중복확인
		$('#loginIdCheckBtn').on('click', function(e) {
			let loginId = $('input[name=loginId]').val().trim();
			
			//alert(loginId);
			//idCheckLength, idCheckDuplicated, idCheckOk
			if (loginId.length < 4) {
				$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
				$('#idCheckDuplicated').addClass('d-none');
				$('#idCheckOk').addClass('d-none');
				return;
			}
			
			// ajax 서버 호출 (중복여부)
			$.ajax({
				type: 'get'
				, url: '/user/is_duplicated_id'
				, data: {'loginId':loginId}
				, success: function(data) {
					
					if (data.result) {
						// 중복이다.
						$('#idCheckDuplicated').removeClass('d-none');
						$('#idCheckLength').addClass('d-none');
						$('#idCheckOk').addClass('d-none');
					} else {
						// 중복이 아니다
						$('#idCheckOk').removeClass('d-none');
						$('#idCheckDuplicated').addClass('d-none');
						$('#idCheckLength').addClass('d-none');
					}
				}, error: function(e) {
					alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.")
				}
			});
			
			idData = loginId;
		});
		
		// signUpBtn
		$('#signUpBtn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let confirmPassword = $('#confirmPassword').val().trim();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return;
			}
			
			if (password == '' || confirmPassword == '') {
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				$('#password').val('');
				$('#confirmPassword').val('');				
				return;
			}
			
			if (name == '') {
				alert("이름을 입력해주세요.");
				return;
			}
			
			if (email == '') {
				alert("이메일을 입력해주세요.");
				return;
			}
			
			// 아이디 중복확인이 완료됐는지 확인
			//-- #idCheckOk <div> 클래스에 d-none이 없으면 사용가능
			if ($('#idCheckOk').hasClass('d-none') || idData != loginId) {
				alert("아이디 중복확인을 해주세요");
				return;
			}
			
			// 서버에 요청!!
			
			var url = "/user/sign_up";
			var data = $('#signUpForm').serialize();

			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("가입을 환영합니다!!! 로그인을 해주세요.");				
					location.href="/user/sign_in_view";
				} else {
					alert("가입에 실패했습니다. 다시 시도해주세요.");
				}
			});
		});
	});
</script>