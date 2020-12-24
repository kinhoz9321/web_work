<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	jsp 페이지 안에서의 주석 입니다.
	여기 작성한 내용은 jsp 페이지가 해석하지 않습니다.
	클라이언트 웹브라우저에 출력되지 않습니다.
--%>

<!-- 
	여기도 주석이긴 하지만
	여기 작성한 내용은 그대로 클라이언트에게 출력됩니다.
	클라이언트 웹브라우저는 여기 작성한 내용을 해석하지 않습니다.
 -->
 
 <%--
 	특정 jsp 페이지에 포함 시킬 내용을 jsp 페이지에 작성할 수 있습니다.
 --%>
 <nav class="navbar navbar-dark bg-primary navbar-expand-sm">
 	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">Acorn</a>
		<ul class="navbar-nav">
			<li class="nav-item">
				<!-- 가급적이면 절대경로를 쓸 것. context 경로 걸기. cpath+tab -->
				<a class="nav-link" href="${pageContext.request.contextPath}/member/list.jsp">회원목록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="${pageContext.request.contextPath}/todo/list.jsp">할일목록</a>
			</li>
		</ul>
	</div>
</nav>