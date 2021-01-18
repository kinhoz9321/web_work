<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/popup_page.jsp</title>
<style>
/*배경색 노랑*/
	body{
		background-color: yellow;
	}
</style>
</head>
<body>
<h3>팝업된 페이지 입니다.</h3>
<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam eos eius nemo ducimus quam totam dignissimos qui aperiam distinctio maxime dolore maiores optio ad. Quaerat itaque quod architecto sint voluptatum.</p>
<a href="javascript: self.close();">닫기</a>
<%-- 콘솔에서 확인 가능 --%>
</body>
</html>
<%--
window.open() 팝업창 열기
self.close() 팝업창 닫기
 --%>


