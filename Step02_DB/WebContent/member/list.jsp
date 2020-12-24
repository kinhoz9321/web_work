<%@page import="test.member.dto.MemberDto"%>
<%@page import="test.member.dao.MemberDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한페이지에 몇개씩 표시할 것인지
	int pageRowCount=5;
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면 (파라미터가 안넘어오면 null 1페이지를 보여준다.)
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 저장한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*pageRowCount;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*pageRowCount;
	
	//startRowNum 과 endRowNum 을 MemberDto 객체에 담고
	MemberDto dto=new MemberDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	//MemberDao 객체를 이용해서 회원 목록을 얻어온다. getList에 startRowNum 과 endRowNum 을 담은 MemberDto 전달
	List<MemberDto> list=MemberDao.getInstance().getList(dto);
	//여기 있는 내용을 반복문 돌면서 table row를 얻어내면 된다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<%-- 
<!-- container 밖으로 navbar 빼기 -->
<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
<!-- navbar-expand-sm 목록을 예쁘게 나열해줌 -->
	<!-- 
	navbar 안에 새로운 div class="container" 생성 
	navbar 는 화면 전체를 차지하고 안에 내용은 container 만큼 차지해서 정렬됨.
	-->
	<div class="container">
		<nav class="navbar navbar-dark bg-primary navbar-expand-sm">
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
--%>
<%-- 
navbar.jsp 페이지에 요청  파라미터를 전달할 수 있다.
"thisPage" 라는 파라미터 명으로 "member" 라는 문자열 전달
따라서 navbar.jsp 페이지에서는 아래와 같이 파라미터를 추출할 수 있다.
String thisPage=request.getParameter("thisPage")
list.jsp 가 ?thisPage=member 라는 파라미터를 navbar.jsp 에게 전달했다고 생각하기
--%>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="member" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav><!-- 현재 어디에 있는지 확인할 수 있는 navbar -->
		<ul class="breadcrumb"><!-- breadcrumb Home/회원목록 이렇게 출력됨 -->
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath}">Home</a>
			</li>
			<li class="breadcrumb-item">회원목록</li>
		</ul>
	</nav>
</div>
<div class="container">
	<button type="button" class="btn btn-outline-success"><a href="insertform.jsp" style="color:black">회원 추가 하러가기</a></button>
	<button type="button" class="btn btn-outline-warning"><a href="../index.jsp" style="color:black">인덱스 페이지로 돌아가기</a></button>
	<table class="table">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>주소</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<%for(MemberDto tmp:list){ %>
				<tr>
					<td><%=tmp.getNum() %></td>
					<td><%=tmp.getName() %></td>
					<td><%=tmp.getAddr() %></td>
					<td><a href="updateform.jsp?num=<%=tmp.getNum()%>">수정</a></td>
					<td><a href="delete.jsp?num=<%=tmp.getNum()%>">삭제</a></td>
					<!-- get방식 parameter를 들고가야 하는 수정, 삭제 -->
				</tr>
			<%} %>
		</tbody>
	</table>
		<!-- 반복문 돌면서 list의 방의 사이즈 만큼 내용을 찍어낸다. for문 코드 이해하기 
		여기서 주의할 것 for문의 {}
		참조되는 내용 그대로 출력할 때는 <//%= 을 사용하기
		-->
	<p class="alert alert-warning">
		현재 페이지는 <strong><%=pageNum %></strong> 입니다. <br />
		죄송하지만 현재 저희 개발자가 아직 안배운 게 있어서 다른 페이지로 이동하고 싶으면 <br />
		주소창에 <code>?pageNum=원하는 페이지</code> 처럼 작성해서 이동하세요.
		페이징 처리 UI 는 아래에 공사 중 입니다...(투명공사 잼...)
	</p>
	<div class="container">
	<nav>
		<ul class="pagination pagination justify-content-center">
			<li class="page-item">
				<a href="" class="page-link">&laquo;</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="list.jsp?pageNum=1">1</a>
			</li>
			<li class="page-item"> 
				<a class="page-link" href="list.jsp?pageNum=2">2</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="list.jsp?pageNum=3">3</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="list.jsp?pageNum=4">4</a>
			</li>
			<li class="page-item">
				<a class="page-link" href="list.jsp?pageNum=5">5</a>
			</li>
			<li class="page-item">
				<a href="" class="page-link">&raquo;</a>
			</li>
		</ul>
	</nav>
	</div>
</div>
</body>
</html>