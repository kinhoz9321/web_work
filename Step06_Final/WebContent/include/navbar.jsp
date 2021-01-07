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
 	부트스트랩 css는 이곳에 포함시키지 않는다. css가 동작을 하려면 navbar.jsp 가 포함되는 페이지에 로딩이 되어야 한다.
 	ex)index, list 등..
 --%>
 <%
 //"thisPage" 라는 파라미터 명으로 전달된 문자열 읽어오기
 String thisPage=request.getParameter("thisPage");
 //NullPointException 방지 (500번 버스 안타기)
 if(thisPage==null){
	 thisPage="";//빈문자열 넣어주기
 }
 %>
 
 <nav class="navbar navbar-dark navbar-expand-sm fixed-top">
 	<div class="container">
 		<a class="navbar-brand" href="${pageContext.request.contextPath}/">
 			<img style="width:30px","heighte="30px" src="${pageContext.request.contextPath}/images/rabbit_1.png"/>
 		</a>
		<a class="navbar-brand" href="${pageContext.request.contextPath}/">NewSite</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#topNav">
		<!-- 
		화면을 줄이면 왼쪽상단에 3줄버튼이 등장 (숨겨진 목록 출력용)
		data-target="#topNav" 뭐를 폈다가 사라지게 할 지 결정 아이디 결정!
		-->
			<span class="navbar-toggler-icon"></span>
		</button>
		<!-- 화면을 좁히면 목록이 사라짐 버튼을 눌렀을 때 접었다 폈다 할 목록 적기 -->
		<%-- <%=thisPage.equals("todo")?"active":"" --%>
		<div class="collapse navbar-collapse" id="topNav">
			<ul class="navbar-nav">
				<li class="nav-item <%=thisPage.equals("cafe")?"active":"" %>">
					<!-- 가급적이면 절대경로를 쓸 것. context 경로 걸기. cpath+tab -->
					<a class="nav-link" href="${pageContext.request.contextPath}/cafe/list.jsp">글 목록 보기</a>
				</li>
			</ul>
		</div>
	</div>
</nav>