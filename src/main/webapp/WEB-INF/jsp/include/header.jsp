<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-between align-items-center h-100">
	<%-- logo --%>
	<div class="pl-3">
		<h1>MEMO 게시판</h1>
	</div>
	<%-- login 정보 --%>
	<div class="pr-3">
		<c:if test="${not empty userId}">
			<span>${name}님 안녕하세요.</span> 
			<a href="/user/sign-out">로그아웃</a>
		</c:if>
		<c:if test="${empty userId}">
			<a href="/user/sign-in-view">로그인</a>
		</c:if>
	</div>
</div>