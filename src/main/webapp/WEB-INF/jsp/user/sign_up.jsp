<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-4">
	<b>이름</b> <input type="text" class="form-control" name="name">
	<br>
	<div>
		<b>아이디</b> <input type="text" class="form-control" name="loginId"><br>
		<div class="d-flex justify-content-end">
			<button type="button" id="urlCheckBtn" class="btn btn-info btn-sm">중복확인</button>
		</div>
	</div>
	<b>비밀번호</b> <input type="password" class="form-control" name="password">
	<br> <b>비밀번호 확인</b> <input type="password" class="form-control"
		name="passwordChk"> <br> <b>프로필 이미지</b> <input
		type="text" class="form-control" name="profileUrl"> <br>
	<div class="d-flex justify-content-end">
		<button type="button" class="btn btn-secondary col-4">회원가입</button>
	</div>
</div>

