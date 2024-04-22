<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="w-50">
	<h1>글쓰기</h1>
	
	<input type="text" id="subject" class="form-control mb-2" placeholder="제목을 입력하세요">
	<textarea id="content" rows="10" class="form-control" placeholder="내용을 입력하세요"></textarea>
	
	<div class="d-flex justify-content-end my-3">
		<input type="file" id="file" accept=".jpg, .png, .gif">
	</div>
	
	<div class="d-flex justify-content-between">
		<button type="button" id="postListBtn" class="btn btn-dark">글 목록</button>
		<div>
			<button type="button" id="clearBtn" class="btn btn-secondary">모두 지우기</button>
			<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#postListBtn').on('click', function() {
			location.href = "/post/post-list-view";
		});
		
		$('#clearBtn').on('click', function() {
			$('#subject').val("");
			$('#content').val("");
			$('#file').val("");
		});
		
		$('#saveBtn').on('click', function() {
			let subject = $('#subject').val();		
			let content = $('#content').val();	
			let fileName = $('#file').val();	
			// C:\fakepath\image_icon.png
			
			if (!subject) {
				alert("제목을 입력하세요");
				return;
			}
			
			if (!content) {
				alert("내용을 입력하세요");
				return;
			}
			
			if (fileName) {
				let extension = fileName.split(".").pop().toLowerCase(); // 확장만 뽑아낸 후 소문자로 변경해서 검사
				if ($.inArray(extension, ['jpg', 'png', 'gif']) == -1) {
					alert("이미지 파일만 업로드 할 수 있습니다.");
					$('#file').val("");
					return;
				}
			}
			
			// form 태그를 js에서 만든다.
			// 이미지를 업로드 할 때는 반드시 form 태그가 있어야 한다.
			let formData = new FormData();
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// AJAX
			$.ajax({
				// request
				type:'POST'
				, url:"/post/post-create"
				, data:formData
				, enctype:"multipart/form-data" // 파일 업로드를 위한 필수 설정
				, processData:false // 파일 업로드를 위한 필수 설정
				, contentType:false // 파일 업로드를 위한 필수 설정
				
				// response
				, success:function(data) {
					if (data.code == 200) {
						alert("메모가 저장되었습니다.");
						location.href = "/post/post-list-view";
					} else {
						alert(data.error_message);
					}
				}
				, error:function(e) {
					alert("메모를 저장하는데 실패했습니다.")
				}
			});
		});
	});
</script>