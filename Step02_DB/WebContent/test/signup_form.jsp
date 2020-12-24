<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/test/signup_form.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
	<!-- 
		폼 전송되는 내용을 아래의 테이블에 저장되는 기능을 구현해 보세요.
		
		language 칼럼에는 선택하지 않으면 NULL을 넣고 
		Java 를 선택하면 Java
		Java와 Python 을 선택하면 Java,Python
		Java와 Python 과 C++ 을 선택하면 Java, Python, C++
		문자열이 저장되도록 하세요.
		
		CREATE TABLE form_test(
			nick VARCHAR2(20) PRIMARY KEY,
			email CHAR(3),
			concern VARCHAR2(10),
			lan VARCHAR2(10),
			comment CLOB
		);
	 -->
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">회원가입 폼 작성</li>
		</ul>
	</nav>
	<form action="signup.jsp" method="post">
	<!-- 
	링크를 누르면 get방식 요청 (내용을 주소창에 달고감)
	method="post"라고 해주면 post방식 요청 (내용을 몸통에 달고감)
	
	method="get"이라고 하면 주소창에 넘어가는 내용 볼 수 있음. 
	-->
		<div class="form-group">
			<label for="nick">닉네임</label>
			<input type="text" name="nick"/><br />
		</div>
		<div class="form-group">
			<label for="email">이메일 수신 여부</label>
			<input type="radio" name="email" value="yes" checked="checked"/> 네
			<input type="radio" name="email" value="no"/> 아니요
		</div>
		<div class="form-group">
			<label for="concern">관심사</label>
			<select name="concern">
				<option value="">선택</option><!-- 선택을 안하면 빈문자열이 출력된다. -->
				<option value="game">게임</option>
				<option value="movie">영화</option>
				<option value="etc">기타</option>
			</select>
		</div>
		<!-- selected="selected" 사용가능 -->
		<div class="form-group">
			<label for="language">배우고 싶은 언어 체크</label><br />
			<input id="Java" type="checkbox" name="language" value="Java"/> 자바
			<input id="Python" type="checkbox" name="language" value="Python"/> 파이선
			<input id="C++" type="checkbox" name="language" value="C++"/> C++
		</div>
		<!-- 
		체크박스는 네임을 똑같이 작성을 해도 그룹으로 묶이지 않는다.
		동일한 파라미터 명으로 여러개의 벨류가 2개 혹은 3개가 다 전달되어야 한다.
		
		만일 get방식이라면
		?language=Java&language=Python&language=C++
		이런 모양으로 넘어간다.
		
		String[] language=request.getParameterValues("language");
		null이 리턴될 때가 있는데 = 아무것도 선택하지 않았을 때 그렇다.
		NullpointException이 발생하면 500번 버스탐. 서버에서 작업하다가 익셉션 발생하면 타는 버스.
		페이지가 존재하지 않을 때는 404번 버스 탐.
		 -->
		<div class="form-group">
			<label for="comment">남기고 싶은 말</label>
			<textarea class="form-control" name="comment" cols="30" rows="10"></textarea>
		</div>
		<button class="btn btn-success" type="submit">가입</button>
		<button class="btn btn-danger" type="reset">취소</button>
	</form> 
</div>
</body>
</html>