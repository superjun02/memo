<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="w-50">
	<h1>글 상세</h1>
	
	<input type="text" id="subject" class="form-control mb-2" placeholder="제목을 입력하세요" value="${post.subject}">
	<textarea id="content" rows="10" class="form-control" placeholder="내용을 입력하세요">${post.content}</textarea>
	
	<c:if test='${!empty post.imagePath}'>
		<div class="my-3">
			<img alt="업로드 된 이미지" src="${post.imagePath}" width="300">
		</div>
	</c:if>
	
	<div class="d-flex justify-content-end my-3">
		<input type="file" id="file" accept=".jpg, .png, .gif">
	</div>
	
	<div class="d-flex justify-content-between">
		<button type="button" id="delPostBtn" class="btn btn-secondary">삭제</button>	
		<div>
			<a href="/post/post-list-view" class="btn btn-dark">목록으로</a>
			<button type="button" id="saveBtn" class="btn btn-primary">수정</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		
	});
</script>