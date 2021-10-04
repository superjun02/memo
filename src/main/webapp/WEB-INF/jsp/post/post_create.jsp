<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center pt-3 pb-3">
	<div class="w-50">
		<h1>글쓰기</h1>
		
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력해주세요." autocomplete="off">
		<textarea rows="10" cols="100" id="content" class="form-control" placeholder="내용을 입력해주세요." autocomplete="off"></textarea>
		
		<div class="d-flex justify-content-end">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		
		<div class="w-100 d-flex justify-content-between pt-4">
			<a href="/post/post_list_view" class="btn btn-dark">목록</a>
			
			<div>
				<button type="button" id="clearBtn" class="btn btn-secondary">모두지우기</button>
				<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 모두 지우기 버튼 클릭
		$('#clearBtn').on('click', function() {
			// 제목과 textarea 영역을 빈칸으로 만든다.
			if (confirm("내용을 지우시겠습니까?")) {
				$('#subject').val('');
				$('#content').val('');
				$('#file').val('');
			}
		});
		
		// 글 내용 저장버튼 클릭
		$('#saveBtn').on('click', function() {
			let subject = $('#subject').val().trim();
			let content = $('#content').val();
			
			if (subject == '') {
				alert("제목을 입력해주세요")
				return;
			}
			
			if (content == '') {
				alert("내용을 입력해주세요")
				return;
			}
			
			// 파일이 업로드 된 경우에 확장자 검사
			let file = $('#file').val();
			
			if (file != '') {
				let ext = file.split('.').pop().toLowerCase();
				if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {
					alert("이미지 파일만 업로드 할 수 있습니다.");
					
					$('#file').val('');
					return;
				}
			}
			
			// form 태그를 자바스크립트에서 만든다.
			var formData = new FormData();
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// ajax
			$.ajax({
				type: 'POST'
				, url: '/post/create'
				, data: formData
				, enctype: 'multipart/form-data'      // 파일 업로드 필수 설정
				, processData: false      // 파일 업로드 필수 설정
				, contentType: false      // 파일 업로드 필수 설정
				, success: function(data) {
					if (data.result == 'success') {
						alert("메모가 저장되었습니다.");
						location.href = "/post/post_list_view";
					}
				}, error: function(e) {
					alert("메모 저장에 실패했습니다." + e);
				}
			});
		});
	});
</script>