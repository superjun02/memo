<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex justify-content-between h-100">
	<div class="logo d-flex align-items-center">
		<h1 class="font-weight-bold p-4">메모 게시판</h1>
	</div>
	<div class="login-info h-100 d-flex align-items-center mr-4">
		<c:if test="${not empty userId}">
			<span class="font-weight-bold">${userName}님 안녕하세요.</span> 
			<a href="/user/sign_out" class="font-weight-bold ml-3">로그아웃</a>
		</c:if>
	</div>
</div>