<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="d-flex justify-content-center pt-3 pb-3">
	<div class="w-50">
		<h1>글 상세/수정</h1>
		
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력해주세요." autocomplete="off" value="${post.subject}">
		<textarea rows="10" cols="100" id="content" class="form-control" placeholder="내용을 입력해주세요." autocomplete="off" >${post.content}</textarea>
		
		<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
		<c:if test="${not empty post.imagePath}">
			<div>
				<img alt="이미지" src="${post.imagePath}" width="300">
			</div>		
		</c:if>
		
		<div class="d-flex justify-content-end">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		
		<div class="w-100 d-flex justify-content-between pt-4">
			<button type="button" id="deleteBtn" class="btn btn-secondary" data-post-id="${post.id}">삭제</button>
			
			<div>
				<a href="/post/post_list_view" class="btn btn-dark">목록으로</a>
				<button type="button" id="updateBtn" data-post-id="${post.id}" class="btn btn-primary">수정</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('#deleteBtn').on('click', function() {
			
			let postId = $(this).data('post-id');
			
			if (confirm("삭제 하시겠습니까?")) {
				// ajax 통신으로 삭제 요청
				$.ajax({
					type: 'delete'
					, url: '/post/delete'
					, data: {'postId':postId}
					, success: function(data) {
						if (data.result == 'success') {
							alert('삭제 되었습니다');
							location.href = '/post/post_list_view';
						}
					}, error: function(e) {
						alert("메모를 삭제하는데 실패했습니다. " + e);
					}
				});
			}	
		});
		
		$('#updateBtn').on('click', function() {
			let subject = $('#subject').val().trim();
			
			if (subject == '') {
				alert("제목을 입력해주세요");
				return;
			}
			
			let content = $('#content').val();
			
			if (content == '') {
				alert('내용을 입력해주세요');
				return;
			}
			
			var file = $('#file').val();
			if (file != "") {
				console.log(file.split('.'));
				var ext = file.split('.').pop().toLowerCase();
				if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
					 alert('gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.');
					 $('#file').val('');
					 return;
				}
			}
			
			var formData = new FormData();
			
			formData.append("postId", $(this).data('post-id'));
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			
			// ajax 통신으로 서버에 전송한다.
			$.ajax({
				type: 'POST'
				, url: '/post/update'
				, data: formData
				, enctype: 'multipart/form-data'      
				, processData: false     
				, contentType: false 
				, success: function(data) {
					if (data.result == 'success') {
						alert("메모가 수정되었습니다.");
						location.href = "/post/post_list_view";
					}
				}, error: function(e) {
					alert("메모 저장에 실패했습니다." + e);
				}
			});
		});
	});
</script>