<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="pt-3 pb-3">
	<h1>글 목록</h1>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>작성날짜</th>
				<th>수정날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="post" items="${postList}">
				<tr>
					<td>${post.id}</td>
					<td>
						<a href="/post/post_detail_view?postId=${post.id}">${post.subject}</a>
					</td>
					<td>
						<fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH시 mm분 ss초" />
					</td>
					<td>
						<fmt:formatDate value="${post.updatedAt}" pattern="yyyy-MM-dd HH시 mm분 ss초" var="updatedAt" />
						${updatedAt}
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="d-flex justify-content-center">
		<c:if test="${prevId ne 0}">
			<a href="/post/post_list_view?prevId=${prevId}" class="mr-3">&lt;&lt; 이전</a>
		</c:if>
		<c:if test="${nextId ne 0}">
			<a href="/post/post_list_view?nextId=${nextId}" class="ml-3">다음 &gt;&gt;</a>
		</c:if>
	</div>
	
	<div class="d-flex justify-content-end">
		<a href="/post/post_create_view" class="btn btn-primary">글쓰기</a>
	</div>
</div>