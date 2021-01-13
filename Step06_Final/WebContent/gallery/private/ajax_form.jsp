<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/private/ajax_form.jsp</title>
</head>
<body>
<div class="container">
	<form action="insert.jsp" method="post" id="insertForm">
		<input type="hidden" name="imagePath" id="imagePath"/>
		<div>
			<label for="caption">설명</label>
			<input type="text" name="caption" id="caption"/>
		</div>
	</form>
	<form action="ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart.form-data">
		<div>
			<label for="image">이미지</label>
			<input type="file" name="image" id="image"/>
		</div>
		<!-- 
			file을 올리면 server에 보내고 ajax 업로드한 이미지를 img_wrapper 에 보이게 한다.
			이미지 정보는 imagePath에 넣는다.
			버튼을 누르면 폼을 강제로 submit 한다.
		 -->
	</form>
	<button id="submitBtn">등록</button>
	<div class="img-wrapper">
		
	</div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<!-- jquery form 플러그인 javascript 로딩 -->
<script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
</body>
</html>