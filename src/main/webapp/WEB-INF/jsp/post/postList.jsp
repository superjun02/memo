<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="w-50">
	<h1>글 목록</h1>
	
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성날짜</th>
				<th>수정날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${postList}" var="post" varStatus="status">
				<tr>
					<td>${fn:length(postList) - status.index}</td>
					<td><a href="/post/post-detail-view?postId=${post.id}">${post.subject}</a></td>
					<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy년 M월 d일 HH:mm:ss" /></td>
					<td><fmt:formatDate value="${post.updatedAt}" pattern="yyyy년 M월 d일 HH:mm:ss" /></td>
				</tr>	
			</c:forEach>
		</tbody>
	</table>
	${userId123}
	<div class="d-flex justify-content-end">
		<a href="/post/post-create-view" class="btn btn-primary">글쓰기</a>
	</div>
</div>