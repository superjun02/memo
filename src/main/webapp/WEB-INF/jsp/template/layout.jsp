<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMO 게시판</title>

<%-- bootstrap CDN --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
	
<%--외부 스타일 시트 --%>
<link rel="stylesheet" type="text/css" href="/static/css/style.css"></script>
</head>
<body>
	<div id="wrap">
		<header>
			<jsp:include page="../include/header.jsp" />
		</header>
		<section class="contents d-flex justify-content-center">
			<jsp:include page="../${viewName}.jsp" />
		</section>
		<footer>
			<jsp:include page="../include/footer.jsp" />
		</footer>
	</div>
</body>
</html>