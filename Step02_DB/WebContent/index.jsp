<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<!-- 
css로딩은 navbar.jsp 에 포함시키지 않고, 이곳에서 한다. 이 3가지가 있어야 navbar.jsp 에 동작하는 ui가 있다. 
css로딩 include 시키기
-->
<jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<%-- 
<!-- container 밖으로 navbar 빼기 -->
<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
<!-- navbar-expand-sm 목록을 예쁘게 나열해줌 -->
<!-- 
	nav 요소는 div 요소에 의미를 더한 요소이다. (의미가 있는 div)
	- navigation 요소를 포함하고 있다고 알려준다.
-->
	<!-- 
	navbar 안에 새로운 div class="container" 생성 
	navbar 는 화면 전체를 차지하고 안에 내용은 container 만큼 차지해서 정렬됨.
	-->
	<div class="container">
		<!-- 
		배경색이 어두운색 계열이면 navbar-dark (밝은 색 글씨가 어울리고,)
		배경색이 밝은색 계열이면 navbar-light 클래스를 추가 해야한다. (어두운 색 글씨가 어울림)
		글자색을 결정해줌.
		 -->
		<nav class="navbar navbar-dark bg-primary">
	<!-- navbar-expand-sm 목록을 예쁘게 나열해줌 -->
	
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">Acorn</a>
			<!-- 
			http://localhost:8888/Step02_DB/ 최상위 경로만 써도 아파치 서버가 index.jsp를 찾아준다. 
			index.jsp가 없으면 404가 뜸.
			-->
			<ul class="navbar-nav">
				<li class="nav-item">
					<!-- 가급적이면 절대경로를 쓸 것. context 경로 걸기. cpath+tab -->
					<a class="nav-link" href="${pageContext.request.contextPath}/member/list.jsp">회원목록</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="${pageContext.request.contextPath}/todo/list.jsp">할일목록</a>
				</li>
			</ul>
		</nav>
	</div>
</nav>
-->
--%>

<%-- 포함시킬 jsp 페이지의 위치를 반드시 상대 경로로 page의 value로 정확히 명시해야 한다. --%>
<jsp:include page="include/navbar.jsp"></jsp:include>
<div class="container">
	<h1>인덱스 페이지 입니다.</h1>
	<ul>
		<li><a href="member/list.jsp">회원 목록 보기</a></li>
		<!-- 
		아래의 링크가 동작하도록 해보세요.
		목록보기, 추가, 수정, 삭제 기능을 모두 구현하세요.
		test.todo.dto
		test.todo.dao 패키지도 만들고 
		TodoDto, 
		TodoDao 도 만드세요.
		
		모두 구현후 bootstrap scc 도 모든 페이지에 적용 시켜 보세요.
		 -->
		<li><a href="todo/list.jsp">할일 목록 보기</a></li>
		<li><a href="test/signup_form.jsp">회원가입 폼 작성하기</a></li>
		
	</ul>
</div>
</body>
</html>