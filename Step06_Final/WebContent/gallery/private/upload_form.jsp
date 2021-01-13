<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/private/upload_form.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}/gallery/list.jsp">갤러리 목록</a>
			</li>
			<li class="breadcrumb-item">업로드 폼</li>
		</ul>
	</nav>
</div>
<div class="container">
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label for="caption">설명</label>
			<input class="form-control" type="text" name="caption" id="caption"/>
		</div>
		<div class="form-group">
			<label for="image">이미지</label>
			<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .jfif"/>
		</div>
		<button type="submit" class="btn btn-success">업로드</button>
		<button type="reset" class="btn btn-danger">취소</button>
	</form>
</div>
</body>
</html>