<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex justify-content-center">
	<div class="login-box m-3">
		<h1 class="mb-4">로그인</h1>
		
		<form id="loginForm" action="/user/sign_in" method="post">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">ID</span>
				</div>
				<input type="text" class="form-control" id="loginId" name="loginId" autocomplete="off">
			</div>
	
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">PW</span>
				</div>
				<input type="password" class="form-control" id="password" name="password" autocomplete="off">
			</div>
			
			
			<input type="submit" class="btn btn-block btn-primary" value="로그인">
			<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
		</form>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#loginForm').submit(function(e) {
			e.preventDefault();
			
			let loginId = $('input[name=loginId]').val().trim();
			if (loginId == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			let password = $('input[name=password]').val();
			if (password == '') {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			var url = $('#loginForm').attr('action');
			var data = $('#loginForm').serialize();
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					location.href="/post/post_list_view";			
				} else {
					alert("로그인에 실패했습니다. 다시 시도해주세요.");
				}				
			});
		});
	});
</script>